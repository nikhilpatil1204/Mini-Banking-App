<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Bank Login</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
	max-width: 500px;
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
	color: #6c757d;
	text-align: center;
}

.link-msg a {
	color: #007bff;
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
		<div class="card">
			<h3 class="text-center mb-4 fw-bold">Bank Login</h3>

			<form method="post" action="Home.jsp">
				<div class="mb-3">
					<label class="form-label">Account Number</label> <input type="text"
						class="form-control" name="l_accountno" pattern="\d{12}"
						placeholder="Enter your 12-digit account number" required>
				</div>
				<div class="mb-3">
					<label class="form-label">Card Number</label> <input type="text"
						class="form-control" name="l_cardno" pattern="(\d{4}\s){3}\d{4}"
						placeholder="Enter your 16-digit card number (xxxx xxxx xxxx xxxx)"
						maxlength="19" required>
				</div>
				<div class="mb-3">
					<label class="form-label">CVV</label> <input type="password"
						class="form-control" name="l_cvv" pattern="\d{3}"
						placeholder="3-digit CVV" maxlength="3" required>
				</div>
				<button type="submit" name="loginbank" class="btn btn-custom w-100">Login</button>

				<p class="link-msg">
					Don’t have a linked bank account? <a href="bankregister.jsp">Click
						here to register</a>
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
				<div class="toast-body">Login successful! Redirecting...</div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast"></button>
			</div>
		</div>
		<div id="errorToast"
			class="toast align-items-center text-bg-danger border-0" role="alert">
			<div class="d-flex">
				<div class="toast-body">Invalid bank login credentials.</div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast"></button>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

	<%
	boolean loginSuccess = false;

	if ("POST".equalsIgnoreCase(request.getMethod()) && request.getParameter("loginbank") != null) {
		String account = request.getParameter("l_accountno").trim();
		String card = request.getParameter("l_cardno").trim();
		String cvv = request.getParameter("l_cvv").trim();
		String Email = (String) session.getAttribute("r_email");

		if (Email != null && !Email.isEmpty()) {
			try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minibankapp", "root",
				"root")) {
			String sql = "SELECT * FROM bank_accounts WHERE r_email=? AND r_accountno=? AND r_cardno=? AND r_cvv=?";
			try (PreparedStatement ps = con.prepareStatement(sql)) {
				ps.setString(1, Email);
				ps.setString(2, account);
				ps.setString(3, card);
				ps.setString(4, cvv);

				try (ResultSet rs = ps.executeQuery()) {
					if (rs.next()) {
						session.setAttribute("bank_id", rs.getInt("id"));
						session.setAttribute("bank_name", rs.getString("r_bankname"));
						session.setAttribute("account_no", rs.getString("r_accountno"));
						session.setAttribute("ifsc", rs.getString("r_ifsc"));
						session.setAttribute("card_no", rs.getString("r_cardno"));
						session.setAttribute("expiry", rs.getString("r_expiry"));
						session.setAttribute("balance", rs.getBigDecimal("r_balance"));
						loginSuccess = true;
					}
				}
			}
		}
			} catch (Exception e) {
		e.printStackTrace();
			}
		}

		if (loginSuccess) {
	%>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			var toastEl = document.getElementById('successToast');
			var toast = new bootstrap.Toast(toastEl, {
				delay : 2000
			});
			toast.show();
			setTimeout(function() {
				window.location.href = 'Home.jsp';
			}, 2000);
		});
	</script>
	<%
	} else {
	%>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			var toastEl = document.getElementById('errorToast');
			var toast = new bootstrap.Toast(toastEl, {
				delay : 2000
			});
			toast.show();
		});
	</script>
	<%
	}
	}
	%>

</body>
</html>
