<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Connect Your Account</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background: #f8f9fa;
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
		"Helvetica Neue", Arial, sans-serif;
	margin: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
}

.connect-box {
	width: 100%;
	max-width: 450px;
	background: #fff;
	padding: 2.5rem 2rem;
	box-shadow: none;
	border-radius: 0;
	text-align: center;
	position: relative;
	/* This is crucial for positioning the close button */
}

@media ( min-width : 768px) {
	.connect-box {
		box-shadow: 0 4px 25px rgba(0, 0, 0, 0.1);
		border-radius: 16px;
	}
}

.connect-box img {
	height: 60px;
	margin-bottom: 1rem;
}

.connect-box h4 {
	font-weight: 600;
	margin-bottom: 1.5rem;
}

.feature {
	display: flex;
	align-items: flex-start;
	gap: 12px;
	margin-bottom: 1.5rem;
	text-align: left;
}

.feature-icon {
	font-size: 20px;
	color: #0d6efd;
	margin-top: 2px;
}

.feature p {
	margin: 0;
	font-size: 14px;
	color: #444;
}

.continue-btn {
	margin-top: 2rem;
}

.continue-btn button {
	width: 100%;
	border-radius: 8px;
	padding: 12px;
	font-size: 16px;
}

.policy-text {
	margin-top: 1.5rem;
	font-size: 12px;
	color: #666;
}

.policy-text a {
	color: #0d6efd;
	text-decoration: none;
}

.close-btn {
	position: absolute;
	top: 15px;
	right: 15px;
	border: none;
	background: transparent;
	font-size: 20px;
	cursor: pointer;
	color: #666; /* Added for better visibility */
}
</style>
</head>
<body>
	<div class="connect-box">
		<button class="close-btn" onclick="window.location.href='index.jsp'">&#10006;</button>

		<img
			src="https://img.icons8.com/?size=100&id=8g9gOI6iAhrg&format=png&color=000000"
			alt="App Logo">

		<h4 class="fw-bold">Connect your account securely</h4>

		<div class="feature">
			<div class="feature-icon">⚡</div>
			<p>
				<strong>Quick Setup</strong><br>Link your bank in seconds with
				our secure system.
			</p>
		</div>
		<div class="feature">
			<div class="feature-icon">🔒</div>
			<p>
				<strong>Data Protection</strong><br>Your data is encrypted and
				never shared without your consent.
			</p>
		</div>

		<div class="continue-btn">
			<form action="SelectBank.jsp">
				<button type="submit" class="btn btn-dark btn-lg">Continue</button>
			</form>
		</div>

		<div class="policy-text">
			By continuing, you agree to our <a href="Privacy.jsp">Privacy &
				Policy</a>.
		</div>
	</div>
</body>
</html>