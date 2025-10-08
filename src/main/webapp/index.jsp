<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>TrustEdge Bank</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
	rel="stylesheet">

<style>
body {
	font-family: 'Poppins', sans-serif;
	color: #333;
	background-color: #f8f9fa;
}

p, .lead, .small {
	font-size: 0.95rem; /* make all subs slightly smaller */
}

.navbar {
	transition: all 0.3s ease;
}

.navbar.scrolled {
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
	background-color: #fff;
}

.brand-logo {
	display: flex;
	align-items: center;
	gap: 10px;
}

.brand-logo img {
	width: 40px;
}

.brand-logo h3 {
	font-weight: 700;
	margin: 0;
	color: #212529;
}

.btn-custom {
	background: linear-gradient(to right, #007bff, #1e90ff);
	color: #fff;
	border: none;
	padding: 0.5rem 1.5rem;
	border-radius: 8px;
	font-weight: 600;
	font-size: 1rem;
	transition: background 0.3s ease, transform 0.2s ease;
}

.btn-outline-dark {
	font-weight: 600;
	font-size: 1rem;
	padding: 0.5rem 1.5rem;
}

/* Hero Section */
.hero-section {
	background: linear-gradient(135deg, #ffffff, #f0f2f5);
	padding: 100px 0;
}

.hero-content h1 {
	font-weight: 700;
	font-size: 2.8rem;
	color: #1a237e;
	margin-bottom: 20px;
}

.hero-content p.lead {
	color: #455a64;
}

/* Features */
.features-section {
	padding: 80px 0;
	background: #fff;
}

.features-section h2 {
	font-weight: 700;
	color: #1a237e;
}

.features-section p {
	margin-bottom: 60px;
}

.feature-card {
	border: none;
	background: #f8f9fa;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	transition: all 0.3s ease-in-out;
}

.feature-card:hover {
	transform: translateY(-8px);
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
}

.feature-card i {
	font-size: 3.5rem;
	color: #007bff;
	transition: color 0.3s;
}

.feature-card:hover i {
	color: #1a237e;
}

/* CTA Card Centered */
.cta-section {
	max-width: 800px;
	margin: 60px auto;
	padding: 60px 30px;
	background: linear-gradient(135deg, #1e3a8a, #0d275b);
	color: #fff;
	text-align: center;
	border-radius: 16px;
	box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
}

.cta-section h2 {
	font-weight: 700;
	font-size: 2.3rem;
}

.cta-section .btn {
	padding: 12px 30px;
	font-weight: 600;
	border-radius: 30px;
}

/* Footer */
footer {
	background: #121212;
	color: #b0bec5;
	padding: 60px 0;
}

footer h5, footer h6 {
	color: #e0e0e0;
}

footer a {
	color: #b0bec5;
	text-decoration: none;
	transition: color 0.3s;
}

footer a:hover {
	color: #fff;
}

@media ( max-width : 991.98px) {
	.navbar-collapse .navbar-nav {
		display: flex;
		flex-direction: column;
		align-items: center;
	}
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg bg-white sticky-top">
		<div class="container">
			<div class="brand-logo">
				<img
					src="https://img.icons8.com/?size=100&id=8g9gOI6iAhrg&format=png&color=000000"
					alt="Logo">
				<h3>TrustEdge</h3>
			</div>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link" href="Register.jsp">Register</a></li>
					<li class="nav-item"><a class="nav-link" href="Login.jsp">User
							Login</a></li>
					<li class="nav-item d-lg-none"><a class="nav-link"
						href="AdminLogin.jsp">Admin Login</a></li>
				</ul>
				<a class="btn btn-custom d-none d-lg-inline-block ms-lg-3"
					href="AdminLogin.jsp">Admin Login</a>
			</div>
		</div>
	</nav>

	<section class="hero-section">
		<div class="container">
			<div class="row align-items-center">
				<div
					class="col-lg-6 hero-content text-center text-lg-start mb-4 mb-lg-0">
					<h1>
						Your Journey to Financial Freedom Begins with <span
							class="text-primary">TrustEdge</span>
					</h1>
					<p class="lead">Secure, simple, and smart digital banking. Take
						control of your finances from anywhere in the world.</p>
					<div
						class="mt-4 d-grid d-sm-flex gap-2 justify-content-center justify-content-lg-start">
						<a href="Register.jsp" class="btn btn-custom">Open an Account</a>
						<a href="#" class="btn btn-outline-dark ">Explore Features</a>
					</div>
				</div>
				<div class="col-lg-6 text-center">
					<img
						src="https://i.pinimg.com/1200x/cb/0c/e3/cb0ce36430155f76fd5a8a0ed7c5625b.jpg"
						class="img-fluid rounded-4 shadow-lg" alt="Bank Dashboard">
				</div>
			</div>
		</div>
	</section>

	<section class="features-section text-center">
		<div class="container">
			<h2>Banking Made Simple</h2>
			<p class="text-muted">Discover powerful features designed to make
				your banking experience seamless and secure.</p>
			<div class="row g-4 justify-content-center">
				<div class="col-md-6 col-lg-3">
					<div class="card feature-card p-4 h-100">
						<i class="bi bi-shield-lock-fill text-primary mb-3"></i>
						<h5>Secure Transactions</h5>
						<p>Bank-grade encryption and multi-factor authentication
							protect every transaction you make.</p>
					</div>
				</div>
				<div class="col-md-6 col-lg-3">
					<div class="card feature-card p-4 h-100">
						<i class="bi bi-gear-fill text-primary mb-3"></i>
						<h5>Easy Account Management</h5>
						<p>Intuitive dashboard to manage all your accounts, cards, and
							banking services in one place.</p>
					</div>
				</div>
				<div class="col-md-6 col-lg-3">
					<div class="card feature-card p-4 h-100">
						<i class="bi bi-bar-chart-line-fill text-primary mb-3""></i>
						<h5>Track Spending</h5>
						<p>Advanced analytics and insights help you understand and
							optimize your spending patterns.</p>
					</div>
				</div>
				<div class="col-md-6 col-lg-3">
					<div class="card feature-card p-4 h-100">
						<i class="bi bi-bank2 text-primary mb-3"></i>
						<h5>Connect Multiple Banks</h5>
						<p>Link accounts from different banks for a unified view of
							your complete financial picture.</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section class="cta-section">
		<h2 class="mb-3">Ready to Start Your Journey?</h2>
		<p class="lead mb-4">Open your account today and explore the power
			of digital banking with TrustEdge.</p>
		<a href="Register.jsp" class="btn btn-light btn-lg fw-bold">Join
			Now</a>
	</section>

	<footer>
		<div class="container text-center">
			<div class="row g-4">
				<!-- Column 1: About + Contact -->
				<div class="col-md-4">
					<h5 class="mb-3">TrustEdge Bank</h5>
					<p class="small">Your trusted partner for secure, modern
						banking solutions. Experience the future of finance today.</p>
					<h6 class="mb-3">Follow Us</h6>
					<div class="d-flex justify-content-center">
						<a href="#" class="me-3"><i class="bi bi-facebook fs-4"></i></a> <a
							href="#" class="me-3"><i class="bi bi-twitter fs-4"></i></a> <a
							href="#"><i class="bi bi-linkedin fs-4"></i></a>
					</div>

				</div>

				<!-- Column 2: Quick Links -->
				<div class="col-md-4">
					<h6 class="mb-3">Quick Links</h6>
					<ul class="list-unstyled">
						<li><a href="Register.jsp">Register</a></li>
						<li><a href="Login.jsp">User Login</a></li>
						<li><a href="AdminLogin.jsp">Admin Login</a></li>
					</ul>
				</div>

				<!-- Column 3: Social -->
				<div class="col-md-4">
					<!-- Contact Info -->
					<ul class="list-unstyled">
						<h6 class="mb-3">Contact Info</h6>
						<li class="mb-2"><i class="bi bi-telephone-fill me-2"></i>
							+91 98765 43210</li>
						<li class="mb-2"><i class="bi bi-envelope-fill me-2"></i>
							support@trustedgebank.com</li>
						<li><i class="bi bi-geo-alt-fill me-2"></i> Pune,
							Maharashtra, India</li>
					</ul>

				</div>
			</div>

			<hr class="border-secondary my-4">

			<p class="small mb-0 text-center">&copy; 2025 TrustEdge Bank. All
				Rights Reserved.</p>
		</div>
	</footer>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		document.addEventListener('DOMContentLoaded', function() {
			const navbar = document.querySelector('.navbar');
			window.addEventListener('scroll', function() {
				if (window.scrollY > 50) {
					navbar.classList.add('scrolled');
				} else {
					navbar.classList.remove('scrolled');
				}
			});
		});
	</script>
</body>
</html>