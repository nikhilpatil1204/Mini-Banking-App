<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.*"%>



<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Login - TrustEdge</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f8f9fa;
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
		"Helvetica Neue", Arial, sans-serif;
	margin: 0;
	min-height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
}

.login-container {
	width: 100%;
	max-width: 450px;
	background: #fff;
	padding: 2.5rem 1.5rem;
	box-shadow: none;
	border-radius: 0;
}

@media ( min-width : 768px) {
	.login-container {
		border-radius: 12px;
		box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	}
}

.brand-logo {
	display: flex;
	align-items: center;
	gap: 10px;
	margin-bottom: 20px;
}

.brand-logo img {
	width: 40px;
}

.brand-logo h3 {
	font-weight: 700;
	margin: 0;
	color: #212529;
}

h2 {
	font-weight: 700;
	font-size: 1.8rem;
	color: #007bff;
}

.form-label {
	font-weight: 600;
	color: #333;
}

.form-control {
	border-radius: 8px;
	padding: 0.75rem 1rem;
	border-color: #ced4da;
}

.form-control:focus {
	box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.25);
	border-color: #80bdff;
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
</style>
</head>
<body>

	<%
	String showToast = null; 
	if (request.getParameter("login") != null) {
		String email = request.getParameter("a_email");
		String password = request.getParameter("a_password");

		String adminEmail = "nikhilpatil7967@gmail.com";
		String adminPassword = "nikhil@2004";
		String adminName = "Nikhil Patil";

		if (email.equals(adminEmail) && password.equals(adminPassword)) {
			session.setAttribute("a_name", adminName);
			showToast = "success"; 
		} else {
			showToast = "fail"; 
		}
	}
	%>

	<div class="login-container">
		<div class="brand-logo">
			<img
				src="https://img.icons8.com/?size=100&id=8g9gOI6iAhrg&format=png&color=000000"
				alt="Logo">
			<h3>TrustEdge</h3>
		</div>

		<h2>Admin Login</h2>
		<p class="text-muted">Enter your admin credentials</p>

		<form method="post" class="mt-4">
			<div class="mb-3">
				<label class="form-label">Admin Email</label> <input type="email"
					name="a_email" class="form-control" placeholder="Enter your email"
					required>
			</div>
			<div class="mb-3">
				<label class="form-label">Password</label> <input type="password"
					name="a_password" class="form-control"
					placeholder="Enter your password" required>
			</div>
			<div class="d-grid">
				<button type="submit" name="login" class="btn btn-custom btn-lg">Sign
					In</button>
			</div>
		</form>
	</div>

	<!-- Toasts -->
	<div class="toast-container position-fixed top-0 end-0 p-3"
		style="z-index: 1100;">
		<div id="loginSuccessToast"
			class="toast align-items-center text-bg-primary border-0"
			role="alert">
			<div class="d-flex">
				<div class="toast-body">
					<span class="fw-bold">✓</span> Login Successful! Redirecting...
				</div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast"></button>
			</div>
		</div>

		<div id="loginFailToast"
			class="toast align-items-center text-bg-danger border-0" role="alert">
			<div class="d-flex">
				<div class="toast-body">
					<span class="fw-bold">✗</span> Invalid Email or Password. Please
					try again.
				</div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast"></button>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
	<%if ("success".equals(showToast)) {%>
		let toast = new bootstrap.Toast(document
					.getElementById('loginSuccessToast'), {
				delay : 2000
			});
			toast.show();
			setTimeout(function() {
				window.location.href = 'AdminDashboard.jsp';
			}, 2000);
	<%} else if ("fail".equals(showToast)) {%>
		let toast = new bootstrap.Toast(document
					.getElementById('loginFailToast'), {
				delay : 4000
			});
			toast.show();
	<%}%>
		});
	</script>

</body>
</html>
