<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Reset Password - TrustEdge</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f8f9fa;
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
		"Helvetica Neue", Arial, sans-serif;
	margin: 0;
	/* Center content vertically and horizontally on large screens */
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
}

.login-container {
	width: 100%;
	max-width: 450px;
	background: #fff;
	padding: 2.5rem 1.5rem;
	box-shadow: none;
	border-radius: 0;
	/* Remove min-height on small screens to prevent unnecessary empty space */
	min-height: auto;
}

/* For tablets and desktops */
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
	<div class="login-container">

		<div class="brand-logo">
			<img
				src="https://img.icons8.com/?size=100&id=8g9gOI6iAhrg&format=png&color=000000"
				alt="Logo" width="40">
			<h3 class="fw-bold m-0">TrustEdge</h3>
		</div>

		<h2 class="fw-bold">Reset Password</h2>
		<p class="text-muted">Enter your new password to reset your
			account</p>

		<%
		// Fetch session values
		String Email = (String) session.getAttribute("r_email");
		int Id = (session.getAttribute("r_id") != null) ? (Integer) session.getAttribute("r_id") : 0;
		%>

		<form method="post">
			<input type="hidden" name="id" value="<%=Id%>">

			<div class="mt-3">
				<label class="form-label">Email</label> <input type="email"
					class="form-control" value="<%=Email%>" readonly>
			</div>

			<div class="mt-3">
				<label class="form-label">New Password</label> <input
					type="password" name="password" class="form-control"
					placeholder="Enter new password" required>
			</div>

			<div class="d-grid mt-4">
				<button type="submit" name="reset" class="btn btn-custom btn-lg">Done</button>
			</div>
		</form>
	</div>

	<div class="toast-container position-fixed top-0 end-0 p-3"
		style="z-index: 1100;">
		<div id="resetSuccessToast"
			class="toast align-items-center text-bg-success border-0"
			role="alert" aria-live="assertive" aria-atomic="true">
			<div class="d-flex">
				<div class="toast-body">✅ Password reset successful!
					Redirecting to login...</div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
		</div>

		<div id="resetFailToast"
			class="toast align-items-center text-bg-danger border-0" role="alert"
			aria-live="assertive" aria-atomic="true">
			<div class="d-flex">
				<div class="toast-body">❌ Password reset failed. Try again!</div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast" aria-label="Close"></button>
			</div>
		</div>
	</div>

	<%
	if (request.getParameter("reset") != null) {
		String Password = request.getParameter("password");
		int Id1 = Integer.parseInt(request.getParameter("id"));

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minibankapp", "root", "root");
			PreparedStatement ps = con.prepareStatement("update register set r_password=? where r_id=?");
			ps.setString(1, Password);
			ps.setInt(2, Id1);

			int updated = ps.executeUpdate();
			if (updated > 0) {
	%>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			let toastEl = document.getElementById('resetSuccessToast');
			let toast = new bootstrap.Toast(toastEl, {
				delay : 3000
			});
			toast.show();

			// Redirect to Login after 3 sec
			setTimeout(function() {
				window.location.href = "Login.jsp";
			}, 3000);
		});
	</script>
	<%
	} else {
	%>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			let toastEl = document.getElementById('resetFailToast');
			let toast = new bootstrap.Toast(toastEl, {
				delay : 4000
			});
			toast.show();
		});
	</script>
	<%
	}
	} catch (Exception e) {
	%>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			let toastEl = document.getElementById('resetFailToast');
			let toast = new bootstrap.Toast(toastEl, {
				delay : 5000
			});
			toast.show();
		});
	</script>
	<%
	}
	}
	%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>