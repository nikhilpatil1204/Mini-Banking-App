<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Bank Registration</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
body {
	background: #f8f9fa;
	min-height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 0;
}

.container {
	max-width: 600px;
	padding: 1rem;
}

.card {
	padding: 30px;
	border: none !important;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	border-radius: 12px;
	background: #fff;
}

.form-label {
	font-weight: 600;
	color: #333;
}

.header {
	position: relative;
	margin-bottom: 20px;
}

.header button {
	position: absolute;
	font-size: 24px;
	border: none;
	background: transparent;
	cursor: pointer;
	top: -15px;
	color: #6c757d;
}

.header .back-btn {
	left: 0;
}

.header .close-btn {
	right: 0;
	top: 0;
}

.cross {
	display: block;
	width: 20px;
	height: 20px;
	position: relative;
	top: -5px;
}

.cross::before, .cross::after {
	content: '';
	position: absolute;
	top: 50%;
	left: 50%;
	width: 2px;
	height: 18px;
	background-color: #6c757d;
	transform-origin: center;
}

.cross::before {
	transform: translate(-50%, -50%) rotate(45deg);
}

.cross::after {
	transform: translate(-50%, -50%) rotate(-45deg);
}

.btn-custom {
	background: linear-gradient(to right, #007bff, #1e90ff);
	color: #fff;
	border: none;
	padding: 0.75rem 1.5rem;
	border-radius: 8px;
	font-weight: 600;
	font-size: 1rem;
	transition: background 0.3s ease, transform 0.2s ease;
}

.link-msg {
    margin-top: 15px;
    font-size: 0.9rem;
    color: #6c757d; /* muted gray */
    text-align: center;
}

.link-msg a {
    color: #007bff; /* bootstrap primary blue */
    font-weight: 600;
    text-decoration: none;
    transition: color 0.3s ease;
}

.link-msg a:hover {
    color: #0056b3; 
    text-decoration: underline;
}


.toast-container {
	position: fixed;
	top: 1rem;
	right: 1rem;
	z-index: 1055;
}

</style>
</head>
<body>

	<div class="container">
		<div class="card shadow">

			<div class="header">
				<button class="back-btn" onclick="window.history.back()">&#8592;</button>
				<button class="close-btn" onclick="window.location.href='index.jsp'">
					<span class="cross"></span>
				</button>
			</div>

			<h3 class="text-center mb-4 fw-bold">Link Your Bank</h3>

			<form method="post">
				<div class="mb-3">
					<label class="form-label">Bank Name</label> <input type="text"
						class="form-control" name="r_bankname"
						value="<%=request.getParameter("bankName") != null ? request.getParameter("bankName") : ""%>"
						readonly required>
				</div>
				<div class="mb-3">
					<label class="form-label">Account Number</label> <input type="text"
						class="form-control" name="r_accountno"
						placeholder="Enter your 12-digit account number" required>
				</div>
				<div class="mb-3">
					<label class="form-label">IFSC Code</label> <input type="text"
						class="form-control" name="r_ifsc" placeholder="Enter IFSC Code"
						required>
				</div>
				<div class="mb-3">
					<label class="form-label">Card Number</label> <input type="text"
						class="form-control" name="r_cardno"
						placeholder="Enter your 16-digit card number" required>
				</div>
				<div class="mb-3">
					<label class="form-label">Expiry Date</label> <input type="text"
						class="form-control" name="r_expiry"
						placeholder="MM/YY (e.g., 09/27)" required>
				</div>
				<div class="mb-3">
					<label class="form-label">CVV</label> <input type="password"
						class="form-control" name="r_cvv" placeholder="3-digit CVV"
						maxlength="3" required>
				</div>

				<button type="submit" name="registerbank"
					class="btn btn-custom w-100">Register Bank</button>

				<!-- Direct message below button -->
				<p class="link-msg">
					Already linked a bank account? <a href="BankLogin.jsp">Click here</a>
				</p>

			</form>
		</div>
	</div>

	<!-- Toast Messages -->
	<div class="toast-container">
		<div id="successToast"
			class="toast align-items-center text-bg-primary border-0"
			role="alert">
			<div class="d-flex">
				<div class="toast-body">Bank details updated successfully!</div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast"></button>
			</div>
		</div>
		<div id="errorToast"
			class="toast align-items-center text-bg-danger border-0" role="alert">
			<div class="d-flex">
				<div class="toast-body">Failed to update bank details.</div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast"></button>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

	<%
	boolean success = false;
	if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("registerbank") != null) {
		String Bank = request.getParameter("r_bankname");
		String Account = request.getParameter("r_accountno");
		String IFSC = request.getParameter("r_ifsc");
		String Card = request.getParameter("r_cardno");
		String Expiry = request.getParameter("r_expiry");
		String CVV = request.getParameter("r_cvv");
		String Email = (String) session.getAttribute("r_email");

		if (Email != null) {
			try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minibankapp", "root", "root");

		PreparedStatement ps = con.prepareStatement(
				"INSERT INTO bank_accounts (r_email, r_bankname, r_accountno, r_ifsc, r_cardno, r_expiry, r_cvv, r_balance) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
		ps.setString(1, Email);
		ps.setString(2, Bank);
		ps.setString(3, Account);
		ps.setString(4, IFSC);
		ps.setString(5, Card);
		ps.setString(6, Expiry);
		ps.setString(7, CVV);
		ps.setBigDecimal(8, new java.math.BigDecimal("0.00"));

		int rows = ps.executeUpdate();
		if (rows > 0)
			success = true;
		con.close();
			} catch (Exception e) {
		e.printStackTrace();
			}
		}

		if (success) {
			out.println("<script>var toastEl=document.getElementById('successToast');"
			+ "var toast=new bootstrap.Toast(toastEl,{delay:2000}); toast.show();"
			+ "setTimeout(function(){window.location.href='Home.jsp';},2000);</script>");
		} else {
			out.println("<script>var toastEl=document.getElementById('errorToast');"
			+ "var toast=new bootstrap.Toast(toastEl,{delay:2000}); toast.show();</script>");
		}
	}
	%>
</body>
</html>
