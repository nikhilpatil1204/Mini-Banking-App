<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal"%>
<%@ page import="javax.servlet.http.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Processing Transfer - TrustEdge</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body class="container mt-5">
	<%
	String email = (String) session.getAttribute("r_email");
	if (email == null) {
		response.sendRedirect("Login.jsp");
		return;
	}

	// Read form parameters
	String bankName = request.getParameter("source_bank");
	String recipient_email = request.getParameter("recipient_email");
	String recipient_acc = request.getParameter("recipient_acc");
	String recipient_ifsc = request.getParameter("recipient_ifsc");
	String amountStr = request.getParameter("amount");
	String notes = request.getParameter("notes");

	// Basic validation
	if (bankName == null || bankName.trim().isEmpty() || recipient_email == null || recipient_email.trim().isEmpty()
			|| amountStr == null || amountStr.trim().isEmpty()) {
		out.println("<div class='alert alert-warning'>Please fill required fields (bank, recipient email, amount).</div>");
		out.println(
		"<div class='d-flex justify-content-center'><a href='Transfer.jsp' class='btn btn-secondary mt-3'>Back</a></div>");
		return;
	}

	BigDecimal amount = null;
	try {
		amount = new BigDecimal(amountStr.trim());
		if (amount.compareTo(BigDecimal.ZERO) <= 0) {
			out.println("<div class='alert alert-danger'>Amount must be greater than zero.</div>");
			out.println(
			"<div class='d-flex justify-content-center'><a href='Transfer.jsp' class='btn btn-secondary mt-3'>Back</a></div>");
			return;
		}
	} catch (Exception ex) {
		out.println("<div class='alert alert-danger'>Invalid amount format.</div>");
		out.println(
		"<div class='d-flex justify-content-center'><a href='Transfer.jsp' class='btn btn-secondary mt-3'>Back</a></div>");
		return;
	}

	// JDBC resources
	Connection con = null;
	PreparedStatement psBalCheck = null;
	ResultSet rsBal = null;
	PreparedStatement psName = null;
	ResultSet rsName = null;
	PreparedStatement psInsertTransfer = null;
	PreparedStatement psUpdateBal = null;
	PreparedStatement psInsertTxn = null;

	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minibankapp", "root", "root");
		con.setAutoCommit(false);

		// 1) Fetch sender balance and account number
		String balSql = "SELECT r_balance, r_accountno FROM bank_accounts WHERE r_email = ? AND r_bankname = ? LIMIT 1";
		psBalCheck = con.prepareStatement(balSql);
		psBalCheck.setString(1, email);
		psBalCheck.setString(2, bankName);
		rsBal = psBalCheck.executeQuery();

		if (!rsBal.next()) {
			out.println("<div class='alert alert-danger'>Your selected bank account was not found.</div>");
			out.println(
			"<div class='d-flex justify-content-center'><a href='Transfer.jsp' class='btn btn-secondary mt-3'>Back</a></div>");
			return;
		}

		BigDecimal balance = rsBal.getBigDecimal("r_balance");
		String sourceAccNo = rsBal.getString("r_accountno");

		if (balance.compareTo(amount) < 0) {
			out.println("<div class='alert alert-danger'>Insufficient balance. Your balance: " + balance + "</div>");
			out.println(
			"<div class='d-flex justify-content-center'><a href='Transfer.jsp' class='btn btn-secondary mt-3'>Back</a></div>");
			return;
		}

		// 2) Get recipient name (if registered)
		String recipientName = recipient_email; // fallback
		String nameSql = "SELECT r_name FROM register WHERE r_email = ? LIMIT 1";
		psName = con.prepareStatement(nameSql);
		psName.setString(1, recipient_email);
		rsName = psName.executeQuery();
		if (rsName.next()) {
			String n = rsName.getString("r_name");
			if (n != null && !n.trim().isEmpty())
		recipientName = n;
		}

		// 3) Insert into transfers
		String insertTransferSql = "INSERT INTO transfers (sender_email, source_bank, source_accno, transfer_note, recipient_email, recipient_accno, recipient_ifsc, amount, created_at) "
		+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())";
		psInsertTransfer = con.prepareStatement(insertTransferSql);
		psInsertTransfer.setString(1, email);
		psInsertTransfer.setString(2, bankName);
		psInsertTransfer.setString(3, sourceAccNo);
		psInsertTransfer.setString(4, notes);
		psInsertTransfer.setString(5, recipient_email);
		psInsertTransfer.setString(6, recipient_acc);
		psInsertTransfer.setString(7, recipient_ifsc);
		psInsertTransfer.setBigDecimal(8, amount);
		psInsertTransfer.executeUpdate();

		// 4) Update sender balance
		String updateBalSql = "UPDATE bank_accounts SET r_balance = r_balance - ? WHERE r_email = ? AND r_bankname = ?";
		psUpdateBal = con.prepareStatement(updateBalSql);
		psUpdateBal.setBigDecimal(1, amount);
		psUpdateBal.setString(2, email);
		psUpdateBal.setString(3, bankName);
		psUpdateBal.executeUpdate();

		// 5) Insert DEBIT transaction (negative amount)
		String insertTxnSql = "INSERT INTO transactions (t_email, t_name, t_amount, t_status, t_date, t_channel, t_category) "
		+ "VALUES (?, ?, ?, ?, NOW(), ?, ?)";
		psInsertTxn = con.prepareStatement(insertTxnSql);
		psInsertTxn.setString(1, email);
		psInsertTxn.setString(2, recipientName);
		psInsertTxn.setBigDecimal(3, amount.negate()); // negative for debit
		psInsertTxn.setString(4, "Success");
		psInsertTxn.setString(5, "Online Transfer");
		psInsertTxn.setString(6, "Fund Transfer");
		psInsertTxn.executeUpdate();

		// 6) Update recipient balance if they exist
		String updateRecipientBalSql = "UPDATE bank_accounts SET r_balance = r_balance + ? WHERE r_email = ? AND r_accountno = ? AND r_ifsc = ?";
		try (PreparedStatement psRecipientBal = con.prepareStatement(updateRecipientBalSql)) {
			psRecipientBal.setBigDecimal(1, amount);
			psRecipientBal.setString(2, recipient_email);
			psRecipientBal.setString(3, recipient_acc);
			psRecipientBal.setString(4, recipient_ifsc);
			int rowsUpdated = psRecipientBal.executeUpdate();

			// If recipient exists, insert CREDIT transaction
			if (rowsUpdated > 0) {
		String insertRecipientTxnSql = "INSERT INTO transactions (t_email, t_name, t_amount, t_status, t_date, t_channel, t_category) "
				+ "VALUES (?, ?, ?, ?, NOW(), ?, ?)";
		try (PreparedStatement psRecipientTxn = con.prepareStatement(insertRecipientTxnSql)) {
			psRecipientTxn.setString(1, recipient_email);
			psRecipientTxn.setString(2, recipientName);
			psRecipientTxn.setBigDecimal(3, amount); // positive for credit
			psRecipientTxn.setString(4, "Success");
			psRecipientTxn.setString(5, "Online Transfer");
			psRecipientTxn.setString(6, "Fund Transfer");
			psRecipientTxn.executeUpdate();
		}
			}
		}

		// Commit transaction
		con.commit();

		out.println("<div class='alert alert-success'>Transfer successful to " + recipientName + " (A/c: " + recipient_acc
		+ "). Amount: " + amount + "</div>");
		out.println("<p class='text-muted'>Redirecting to Transactions page...</p>");
		out.println("<script>setTimeout(function(){ window.location = 'Transaction.jsp'; }, 3000);</script>");

	} catch (Exception e) {
		try {
			if (con != null)
		con.rollback();
		} catch (Exception ignore) {
		}
		e.printStackTrace();
		out.println("<div class='alert alert-danger'>Error during transfer: " + e.getMessage() + "</div>");
		out.println(
		"<div class='d-flex justify-content-center'><a href='Transfer.jsp' class='btn btn-secondary mt-3'>Back</a></div>");
	} finally {
		try {
			if (rsName != null)
		rsName.close();
		} catch (Exception ignore) {
		}
		try {
			if (rsBal != null)
		rsBal.close();
		} catch (Exception ignore) {
		}
		try {
			if (psName != null)
		psName.close();
		} catch (Exception ignore) {
		}
		try {
			if (psBalCheck != null)
		psBalCheck.close();
		} catch (Exception ignore) {
		}
		try {
			if (psInsertTransfer != null)
		psInsertTransfer.close();
		} catch (Exception ignore) {
		}
		try {
			if (psUpdateBal != null)
		psUpdateBal.close();
		} catch (Exception ignore) {
		}
		try {
			if (psInsertTxn != null)
		psInsertTxn.close();
		} catch (Exception ignore) {
		}
		try {
			if (con != null)
		con.close();
		} catch (Exception ignore) {
		}
	}
	%>
</body>
</html>