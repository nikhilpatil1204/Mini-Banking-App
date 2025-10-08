<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - TrustEdge</title>
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

.btn-google {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
	width: 100%;
	background: #fff;
	color: #444;
	font-weight: 600;
	border: 1px solid #ddd;
	padding: 0.75rem;
	border-radius: 8px;
	transition: background 0.3s ease;
}

.btn-google:hover {
	background: #f8f9fa;
}
</style>

</head>
<body>
	<div class="login-container">
		<div class="brand-logo">
			<img
				src="https://img.icons8.com/?size=100&id=8g9gOI6iAhrg&format=png&color=000000"
				alt="Logo">
			<h3>TrustEdge</h3>
		</div>

		<h2>Sign In</h2>
		<p class="text-muted">Enter your credentials to access your
			account</p>

		<form method="post" class="mt-4">
			<div class="mb-3">
				<label class="form-label">Email</label> <input type="email"
					name="r_email" class="form-control" placeholder="Enter your email"
					required>
			</div>
			<div class="mb-3">
				<label class="form-label">Password</label> <input type="password"
					name="r_password" class="form-control"
					placeholder="Enter your password" required>
			</div>
			<div class="text-end mb-3">
				<a href="ForgetPass.jsp" class="text-decoration-none">Forgot
					Password?</a>
			</div>
			<div class="d-grid">
				<button type="submit" name="login" class="btn btn-custom btn-lg">Sign
					In</button>
			</div>
			<p class="text-center mt-3">
				Don't have an account? <a href="Register.jsp">Sign Up</a>
			</p>
		</form>

		<!-- OR Divider -->
		<div class="text-center my-3">
			<span class="text-muted">────────── OR ──────────</span>
		</div>

		<!-- Google Login Button -->
		<a href="GoogleLoginServlet" class="d-grid">
			<button type="button" class="btn-google">
				<img src="https://cdn-icons-png.flaticon.com/512/281/281764.png"
					width="20" height="20" alt="Google"> Sign in with Google
			</button>
		</a>
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

	<%
	if (request.getParameter("login") != null) {
		String Email = request.getParameter("r_email");
		String Password = request.getParameter("r_password");

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minibankapp", "root", "root");
			PreparedStatement ps = con
					.prepareStatement("SELECT * FROM register WHERE r_email=? AND r_password=?")) {

		ps.setString(1, Email);
		ps.setString(2, Password);

		try (ResultSet rs = ps.executeQuery()) {
			if (rs.next()) {
				session.setAttribute("r_name", rs.getString("r_name"));
				session.setAttribute("r_dob", rs.getString("r_dob"));
				session.setAttribute("r_contact", rs.getString("r_contact"));
				session.setAttribute("r_email", rs.getString("r_email"));
				session.setAttribute("r_password", rs.getString("r_password"));
				session.setAttribute("r_address", rs.getString("r_address"));
				session.setAttribute("r_country", rs.getString("r_country"));
				session.setAttribute("r_state", rs.getString("r_state"));
				session.setAttribute("r_city", rs.getString("r_city"));
				session.setAttribute("r_pincode", rs.getString("r_pincode"));
	%>
	<script>
	document.addEventListener("DOMContentLoaded", function() {
		let toast = new bootstrap.Toast(document.getElementById('loginSuccessToast'), { delay: 3000 });
		toast.show();
		setTimeout(() => { window.location.href = "LinkAcc.jsp"; }, 3000);
	});
	</script>
	<%
	} else {
	%>
	<script>
	document.addEventListener("DOMContentLoaded", function() {
		let toast = new bootstrap.Toast(document.getElementById('loginFailToast'), { delay: 4000 });
		toast.show();
	});
	</script>
	<%
	}
	}
	}
	} catch (Exception e) {
	out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
	}
	}
	%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
