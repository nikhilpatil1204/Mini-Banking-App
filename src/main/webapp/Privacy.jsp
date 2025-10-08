<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Privacy & Policy</title>
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

.modal-box {
	width: 100%;
	max-width: 600px;
	margin: 0 auto;
	border: none;
	border-radius: 0;
	padding: 2rem 1.5rem;
	box-shadow: none;
	background: #fff;
}

/* Styles for tablets and desktops */
@media ( min-width : 768px) {
	.modal-box {
		margin: 40px auto;
		border: 1px solid #ddd;
		border-radius: 12px;
		box-shadow: 0 2px 12px rgba(0, 0, 0, 0.12);
	}
}

.modal-box h5 {
	text-align: center;
	font-weight: bold;
	margin-bottom: 20px;
	font-size: 1.5rem;
}

/* Fixed height and scrollable content */
.policy-text {
	height: 400px; /* Adjust this value as needed */
	overflow-y: auto;
	font-size: 15px;
	color: #333;
	line-height: 1.7;
	padding-right: 8px;
}

/* Scrollbar with smaller height thumb */
.policy-text::-webkit-scrollbar {
	width: 6px;
}

.policy-text::-webkit-scrollbar-track {
	background: transparent;
	margin: 20px 0;
}

.policy-text::-webkit-scrollbar-thumb {
	background: #aaa;
	border-radius: 4px;
}

.policy-text::-webkit-scrollbar-thumb:hover {
	background: #777;
}

.continue-btn {
	background: #000;
	color: #fff;
	border-radius: 8px;
	padding: 12px;
	width: 100%;
	border: none;
	margin-top: 25px;
	font-size: 16px;
	font-weight: 600;
}

.continue-btn:hover {
	background: #222;
	color: #fff;
}
</style>
</head>
<body>
	<div class="modal-box">
		<h5>Privacy & Policy</h5>
		<div class="policy-text">
			<p>Welcome to our banking application. Your privacy is important
				to us. This Privacy Policy explains how we collect, use, disclose,
				and safeguard your information when you use our services.</p>
			<p>
				<strong>1. Information Collection</strong><br> We may collect
				personal details such as your name, email, bank details, and usage
				activity for account linking and security purposes.
			</p>
			<p>
				<strong>2. Data Usage</strong><br> The information collected is
				used strictly for verifying your bank connection, enhancing user
				experience, and ensuring secure transactions.
			</p>
			<p>
				<strong>3. Data Sharing</strong><br> We do not sell or rent
				your personal information. Data is shared only with your bank or
				trusted partners required for secure banking integration.
			</p>
			<p>
				<strong>4. Security</strong><br> We use industry-standard
				encryption and multi-factor authentication to protect your data.
			</p>
			<p>
				<strong>5. Consent</strong><br> By continuing, you agree to our
				privacy practices and authorize us to securely connect your bank
				account.
			</p>
		</div>

		<form action="SelectBank.jsp" method="get">
			<button type="submit" class="continue-btn">I Agree &
				Continue</button>
		</form>
	</div>
</body>
</html>