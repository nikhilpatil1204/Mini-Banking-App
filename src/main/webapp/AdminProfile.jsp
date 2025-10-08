<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Profile - TrustEdge</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">

<style>
:root {
	--bg: #f5f7fa;
	--card: #ffffff;
	--accent: #0d6efd;
	--soft-shadow: 0 6px 20px rgba(13, 110, 253, 0.08);
}

body {
	margin: 0;
	background: var(--bg);
	font-family: Inter, system-ui, Arial;
	display: flex;
	flex-direction: column;
}

/* Sidebar */
.sidebar {
	width: 260px;
	height: 100vh;
	background: var(--card);
	border-right: 1px solid #e9ecef;
	box-shadow: var(--soft-shadow);
	padding: 1.5rem 1rem;
	display: flex;
	flex-direction: column;
	position: fixed;
	top: 0;
	left: 0;
	z-index: 1050;
	transform: translateX(-100%);
	transition: transform 0.3s ease;
}

.sidebar.show {
	transform: translateX(0);
}

.sidebar .logo-section {
	margin-bottom: 1rem;
}

.sidebar .nav-link {
	color: #495057;
	border-radius: 10px;
	padding: 0.7rem 0.9rem;
	font-weight: 500;
	margin-bottom: 0.3rem;
	cursor: pointer;
}

.sidebar .nav-link:hover {
	background: linear-gradient(45deg, #0d6efd, #6610f2);
	color: white !important;
	font-weight: 600;
	box-shadow: 0 4px 10px rgba(13, 110, 253, 0.2);
}

/* Overlay for mobile */
.overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: 1040;
	display: none;
}

.overlay.show {
	display: block;
}

/* Main content */
.main-area {
	flex: 1;
	display: flex;
	flex-direction: column;
	scroll-behavior: smooth;
	transition: margin-left 0.3s ease;
	margin-left: 0;
}

.topbar {
	background: var(--card);
	margin: 10px;
	border-radius: 12px;
	padding: 0.5rem 1rem;
	box-shadow: var(--soft-shadow);
	display: flex;
	justify-content: space-between;
	align-items: center;
	min-height: 50px;
	flex-wrap: wrap;
}

.topbar .profile {
	display: flex;
	align-items: center;
	gap: 0.5rem;
}

.dropdown-menu {
	border: none;
	border-radius: 12px;
	box-shadow: var(--soft-shadow);
	padding: 0.5rem;
	background: var(--card);
	min-width: 160px;
}

.dropdown-menu .dropdown-item {
	color: #495057;
	border-radius: 10px;
	padding: 0.6rem 0.9rem;
	font-weight: 500;
	display: flex;
	align-items: center;
	gap: 0.5rem;
}

.dropdown-menu .dropdown-item:hover {
	background: linear-gradient(45deg, #0d6efd, #6610f2);
	color: white !important;
	font-weight: 600;
	box-shadow: 0 4px 10px rgba(13, 110, 253, 0.2);
}

.topbar .profile-icon-wrapper {
	font-size: 1.5rem;
	width: 1em;
	height: 1em;
	display: flex;
	align-items: center;
	justify-content: center;
}

.topbar .profile-icon-wrapper img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.content-area {
	margin: 0 10px 10px 10px;
	flex: 1;
}

.card-custom {
	background: var(--card);
	border-radius: 12px;
	padding: 15px;
	box-shadow: var(--soft-shadow);
	margin-bottom: 10px;
}

.profile-img {
	width: 120px;
	height: 120px;
	object-fit: cover;
	border-radius: 50%;
	border: 4px solid var(--accent);
}

.btn {
	border-radius: 10px;
	padding: 0.6rem 1.2rem;
}

.btn-gradient {
	background: linear-gradient(45deg, #0d6efd, #6610f2);
	color: #fff !important;
	font-weight: 600;
	border: none;
}

.btn-gradient:hover {
	opacity: 0.9;
}

/* Responsive adjustments */
@media ( min-width : 992px) {
	.sidebar {
		transform: translateX(0);
	}
	.main-area {
		margin-left: 260px;
	}
	.topbar {
		margin: 20px;
	}
	.content-area {
		margin: 0 20px 20px 20px;
	}
	.card-custom {
		padding: 20px;
	}
}
</style>
</head>
<body>

	<div class="overlay" id="overlay" onclick="closeSidebar()"></div>

	<!-- Sidebar -->
	<div class="sidebar" id="sidebar">
		<div
			class="logo-section d-flex align-items-center justify-content-between">
			<div class="d-flex align-items-center">
				<img
					src="https://img.icons8.com/?size=100&id=8g9gOI6iAhrg&format=png&color=000000"
					width="40">
				<h2 class="fw-bold ms-2">TrustEdge</h2>
			</div>
			<button class="btn p-0 d-lg-none" type="button"
				onclick="closeSidebar()">
				<i class="bi bi-x-lg fs-4 text-dark"></i>
			</button>
		</div>
		<nav class="nav flex-column">
			<a class="nav-link" href="AdminDashboard.jsp"><i
				class="bi bi-speedometer2 me-2"></i>Dashboard</a> <a class="nav-link"
				href="#"><i class="bi bi-people-fill me-2"></i>Users</a> <a
				class="nav-link" href="#"><i class="bi bi-bank2 me-2"></i>Accounts</a>
			<a class="nav-link" href="#"><i class="bi bi-cash me-2"></i>Transactions</a>
			<a class="nav-link active" href="AdminProfile.jsp"><i
				class="bi bi-person-circle me-2"></i>Profile</a>
		</nav>
	</div>

	<!-- Main Area -->
	<div class="main-area">
		<div class="topbar">
			<h4 class="m-0 fw-semibold">Admin Dashboard</h4>
			<div class="d-flex align-items-center gap-3 flex-wrap">
				<div
					class="search-box position-relative d-none d-lg-block flex-grow-1">
					<input type="text" class="form-control rounded-pill px-3"
						placeholder="Search Here...."> <i
						class="bi bi-search position-absolute top-50 end-0 translate-middle-y me-3 text-muted"></i>
				</div>
				<button class="btn p-0 d-lg-none" type="button"
					onclick="toggleSidebar()">
					<i class="bi bi-list fs-2 text-dark"></i>
				</button>
				<a href="#" class="text-dark fs-5 d-none d-lg-block"><i
					class="bi bi-gear-wide-connected"></i></a> <a href="#"
					class="text-dark fs-5 d-none d-lg-block"><i
					class="bi bi-bell-fill"></i></a>
				<div class="dropdown">
					<a class="btn p-0" href="#" role="button" id="userMenu"
						data-bs-toggle="dropdown" aria-expanded="false"> <span
						class="profile-icon-wrapper"> <img
							src="https://cdn-icons-png.flaticon.com/512/9131/9131646.png"
							class="rounded-circle" alt="user">
					</span>
					</a>
					<ul class="dropdown-menu dropdown-menu-end"
						aria-labelledby="userMenu">
						<li><a class="dropdown-item" href="AdminProfile.jsp"><i
								class="bi bi-person-fill"></i> Profile</a></li>
						<li><a class="dropdown-item" href="Settings.jsp"><i
								class="bi bi-gear-fill"></i> Settings</a></li>
						<li><a class="dropdown-item" href="AdminLogOut.jsp"><i
								class="bi bi-box-arrow-right"></i> Logout</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="content-area">
			<div class="card-custom text-center">
				<img src="https://cdn-icons-png.flaticon.com/512/9131/9131646.png"
					class="profile-img mb-3" alt="Admin">
				<h4 class="fw-bold" id="adminName">Nikhil Patil</h4>
				<p class="text-muted" id="adminEmail">nikhilpatil7967@gmail.com</p>
				<p>
					<i class="bi bi-telephone-fill"></i> <span id="adminPhone">+91
						8767901580</span>
				</p>
			</div>

			<div class="d-flex gap-3 justify-content-end mt-2">
				<button class="btn btn-gradient" data-bs-toggle="modal"
					data-bs-target="#editProfileModal">
					<i class="bi bi-pencil-square me-1"></i> Edit Profile
				</button>
				<a href="AdminLogOut.jsp" class="btn btn-outline-danger"> <i
					class="bi bi-box-arrow-right me-1"></i> Logout
				</a>
			</div>
		</div>
	</div>

	<!-- Edit Profile Modal -->
	<div class="modal fade" id="editProfileModal" tabindex="-1"
		aria-labelledby="editProfileModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="editProfileModalLabel">Edit
						Profile</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="editProfileForm">
						<div class="mb-3">
							<label for="name" class="form-label">Name</label> <input
								type="text" class="form-control" id="name" value="Nikhil Patil"
								required>
						</div>
						<div class="mb-3">
							<label for="email" class="form-label">Email</label> <input
								type="email" class="form-control" id="email"
								value="nikhilpatil7967@gmail.com" required>
						</div>
						<div class="mb-3">
							<label for="phone" class="form-label">Phone</label> <input
								type="text" class="form-control" id="phone"
								value="+91 8767901580" required>
						</div>
						<div class="text-end">
							<button type="submit" class="btn btn-gradient">Save
								Changes</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		function toggleSidebar() {
			document.getElementById('sidebar').classList.toggle('show');
			document.getElementById('overlay').classList.toggle('show');
		}
		function closeSidebar() {
			document.getElementById('sidebar').classList.remove('show');
			document.getElementById('overlay').classList.remove('show');
		}

		// Update profile on modal submit
		document
				.getElementById('editProfileForm')
				.addEventListener(
						'submit',
						function(e) {
							e.preventDefault();
							document.getElementById('adminName').textContent = document
									.getElementById('name').value;
							document.getElementById('adminEmail').textContent = document
									.getElementById('email').value;
							document.getElementById('adminPhone').textContent = document
									.getElementById('phone').value;
							const modal = bootstrap.Modal.getInstance(document
									.getElementById('editProfileModal'));
							modal.hide();
							alert('Profile updated successfully!');
						});
	</script>
</body>
</html>
