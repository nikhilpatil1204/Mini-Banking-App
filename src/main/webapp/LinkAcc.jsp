<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Link Account - Horizon</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">

<style>
body {
	background-color: #f8f9fa;
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
		"Helvetica Neue", Arial, sans-serif;
	margin: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
}

.card-container {
	width: 100%;
	max-width: 400px;
	background: #fff;
	padding: 2.5rem 2rem;
	box-shadow: none;
	border-radius: 0;
	position: relative;
	overflow: hidden;
}

@media ( min-width : 768px) {
	.card-container {
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

.card-container h2 {
	font-weight: 700;
	margin-bottom: 0.5rem;
	color: #007bff;
}

.card-container p {
	color: #6c757d;
	margin-bottom: 1.5rem;
}

.feature-box {
	display: flex;
	align-items: center;
	gap: 10px;
	background: #f1f5ff;
	padding: 8px 12px;
	border-radius: 8px;
	font-size: 0.9rem;
	color: #495057;
	margin-bottom: 10px;
}

.feature-box i {
	color: #007bff;
	font-size: 1.2rem;
}

.btn-custom {
	background: linear-gradient(to right, #007bff, #1e90ff);
	color: #fff;
	font-size: 1.1rem;
	padding: 0.75rem 1.5rem;
	border: none;
	border-radius: 8px;
	width: 100%;
	font-weight: 600;
	transition: transform 0.2s ease, box-shadow 0.3s ease;
}
</style>
</head>
<body>
	<div class="card-container">
		<div class="brand-logo">
			<img
				src="https://img.icons8.com/?size=100&id=8g9gOI6iAhrg&format=png&color=000000"
				alt="Logo">
			<h3>TrustEdge</h3>
		</div>
		<h2>Link Account</h2>
		<div class="text-muted small">Please link your account to get
			the best experience and improved convenience.</div>

		<div class="text-center mb-3">
			<img src="https://img.icons8.com/clouds/150/bank-building.png"
				alt="Bank illustration" class="img-fluid" style="max-height: 120px;">
		</div>

		<!-- Feature points -->
		<div class="feature-box">
			<i class="bi bi-shield-lock"></i> Secure connection
		</div>
		<div class="feature-box">
			<i class="bi bi-lightning-charge"></i> Fast setup
		</div>
		<div class="feature-box">
			<i class="bi bi-collection"></i> Manage all in one place
		</div>

		<form method="post" action="StartBankLinkServlet">
			<button type="submit" class="btn btn-custom mt-3">Connect
				bank</button>
		</form>

		<div class="mt-3 text-center">
			<small class="text-muted"> <i
				class="bi bi-lock-fill text-primary"></i> Your data is encrypted &
				secured.
			</small>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
