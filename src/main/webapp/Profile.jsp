<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Profile - TrustEdge</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

<style>
/* 🎨 Theme Variables */
:root {
	--bg: #f5f7fa;
	--card: #ffffff;
	--muted: #6c757d;
	--accent: #0d6efd;
	--soft-shadow: 0 6px 20px rgba(13, 110, 253, 0.08);
}

/* Layout */
body {
	margin: 0;
	min-height: 100vh;
	display: flex;
	background: var(--bg);
	font-family: Inter, system-ui, -apple-system, 'Segoe UI', Roboto, Arial;
	overflow-x: hidden;
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
	left: -260px;
	transition: left 0.3s ease;
	z-index: 1050;
}

.sidebar.show {
	left: 0;
}

/* Overlay */
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

/* Sidebar items */
.sidebar .logo-section {
	margin-bottom: 1rem;
}

.sidebar .logo-section img {
	vertical-align: middle;
}

.sidebar .divider {
	height: 1px;
	background-color: #dee2e6;
	margin: 0.5rem 0 1rem 0;
}

.sidebar .nav-link {
	color: #495057;
	border-radius: 10px;
	padding: 0.7rem 0.9rem;
	font-weight: 500;
	margin-bottom: 0.3rem;
}

.sidebar .nav-link:hover {
	background: linear-gradient(45deg, #0d6efd, #6610f2);
	color: white !important;
	font-weight: 600;
	box-shadow: 0 4px 10px rgba(13, 110, 253, 0.2);
}

.sidebar .nav-link i, .sidebar .nav-link img {
	font-size: 1.25rem;
	width: 1.25em;
	height: 1.25em;
}

/* Main Area */
.main-area {
	flex: 1;
	display: flex;
	flex-direction: column;
	padding-left: 0;
}

/* Topbar */
.topbar {
	background: var(--card);
	margin: 20px;
	border-radius: 12px;
	padding: 0.5rem 1rem;
	box-shadow: var(--soft-shadow);
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.topbar .profile-overview {
	display: flex;
	align-items: center;
	gap: 0.75rem;
}

.topbar .profile-overview .overview-text {
	font-weight: 500;
	color: #495057;
}

/* Search box */
.search-box input {
	min-width: 200px;
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

/* Correctly resize profile image to match other icons */
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

.topbar .fs-5 {
	font-size: 1.5rem !important;
}

/* Content */
.content-area {
	margin: 0 20px 20px 20px;
	flex: 1;
}

/* Profile Card */
.card {
	border-radius: 16px;
	box-shadow: 0 6px 15px rgba(0, 0, 0, 0.08);
}

.card-body {
	overflow: hidden;
}

.profile-pic {
	border-radius: 50%;
	border: 4px solid var(--accent);
}

.profile-card-header {
	font-size: 1.25rem;
	font-weight: 600;
	color: #343a40;
}

.profile-detail-label {
	font-weight: 500;
	color: #495057;
}

.profile-detail-value {
	font-weight: 600;
	color: #000;
}

/* Buttons */
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

/* Responsive */
@media ( max-width : 992px) {
	.sidebar {
		left: -260px;
		position: fixed;
		height: 100vh;
	}
	body.sidebar-open .sidebar {
		left: 0;
	}
	body.sidebar-open .overlay {
		display: block;
	}
	.main-area {
		margin-left: 0 !important;
	}
	.sidebar .nav-link {
		gap: 0.75rem;
	}
	.topbar {
		flex-wrap: wrap;
		gap: 0.75rem;
	}
	.topbar .profile-overview {
		flex: 1;
		justify-content: center;
	}
	.topbar .d-flex {
		gap: 1rem !important;
	}
	.topbar .d-none.d-md-block, .topbar .d-none.d-lg-block {
		display: none !important;
	}
}

@media ( min-width : 992px) {
	.sidebar {
		position: static;
		box-shadow: var(--soft-shadow);
		height: auto;
	}
	.main-area {
		flex: 1;
	}
	.menu-toggle {
		display: none !important;
	}
}
</style>
</head>
<body>

	<%
	// ✅ Session & DB Variables
	String email = (String) session.getAttribute("r_email");
	String name = "", dob = "", contact = "", address = "", city = "", pincode = "";
	String bankName = "", accNo = "", balance = "0.00", ifsc = "", cardNo = "";
	String accountStatus = "Active";

	if (email != null) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minibankapp", "root", "root")) {

		// Personal Info
		String sql1 = "SELECT r_name, r_dob, r_contact, r_address, r_city, r_pincode FROM register WHERE r_email=?";
		try (PreparedStatement ps1 = con.prepareStatement(sql1)) {
			ps1.setString(1, email);
			try (ResultSet rs1 = ps1.executeQuery()) {
				if (rs1.next()) {
					name = rs1.getString("r_name");
					dob = rs1.getString("r_dob");
					contact = rs1.getString("r_contact");
					address = rs1.getString("r_address");
					city = rs1.getString("r_city");
					pincode = rs1.getString("r_pincode");
				}
			}
		}

		// Bank Info
		String sql2 = "SELECT r_bankname, r_accountno, r_balance, r_ifsc, r_cardno FROM bank_accounts WHERE r_email=?";
		try (PreparedStatement ps2 = con.prepareStatement(sql2)) {
			ps2.setString(1, email);
			try (ResultSet rs2 = ps2.executeQuery()) {
				if (rs2.next()) {
					bankName = rs2.getString("r_bankname");
					accNo = rs2.getString("r_accountno");
					balance = rs2.getString("r_balance");
					ifsc = rs2.getString("r_ifsc");
					cardNo = rs2.getString("r_cardno");
				}
			}
		}

			}
		} catch (Exception e) {
			out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
		}
	} else {
		response.sendRedirect("Login.jsp");
	}

	String currentPage = request.getRequestURI();
	%>

	<div class="overlay" onclick="closeSidebar()"></div>

	<div class="sidebar">
		<div
			class="logo-section d-flex align-items-center justify-content-between">
			<div class="d-flex align-items-center">
				<img
					src="https://img.icons8.com/?size=100&id=8g9gOI6iAhrg&format=png&color=000000"
					alt="Logo" width="40">
				<h2 class="fw-bold ms-2">TrustEdge</h2>
			</div>
			<button class="btn p-0 d-lg-none close-toggle" type="button"
				onclick="closeSidebar()">
				<i class="bi bi-x-lg fs-4 text-dark"></i>
			</button>
		</div>
		<div class="divider"></div>
		<nav class="nav flex-column">
			<a
				class="nav-link <%=currentPage.contains("Home.jsp") ? "active" : ""%>"
				href="Home.jsp"><i class="bi bi-house-fill me-2"></i>Home</a> <a
				class="nav-link <%=currentPage.contains("MyBanks.jsp") ? "active" : ""%>"
				href="MyBanks.jsp"><i class="bi bi-bank2 me-2"></i>My Banks</a> <a
				class="nav-link <%=currentPage.contains("Transaction.jsp") ? "active" : ""%>"
				href="Transaction.jsp"><i class="bi bi-clock-history me-2"></i>Transactions</a>
			<a
				class="nav-link <%=currentPage.contains("Transfer.jsp") ? "active" : ""%>"
				href="Transfer.jsp"><i class="bi bi-arrow-left-right me-2"></i>Transfer</a>
			<a
				class="nav-link <%=currentPage.contains("Connect.jsp") ? "active" : ""%>"
				href="Connect.jsp"><i class="bi bi-plus-circle me-2"></i>Connect
				Bank</a> <a
				class="nav-link <%=currentPage.contains("Profile.jsp") ? "active" : ""%>"
				href="Profile.jsp"><i class="bi bi-person-circle me-2"></i>Profile</a>
		</nav>
	</div>

	<div class="main-area">
		<div class="topbar">
			<div class="d-flex align-items-center">
				<h4 class="overview-text fw-semibold m-0">Profile</h4>
			</div>
			<div class="d-flex align-items-center gap-3">
				<div class="search-box position-relative d-none d-md-block">
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
						<li><a class="dropdown-item" href="Profile.jsp"><i
								class="bi bi-person-circle"></i> Profile</a></li>
						<li><a class="dropdown-item" href="Settings.jsp"><i
								class="bi bi-gear-fill"></i> Settings</a></li>
						<li><a class="dropdown-item" href="LogOut.jsp"><i
								class="bi bi-box-arrow-right"></i> Logout</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="content-area d-flex flex-column gap-4">
			<div class="card border-0">
				<div class="card-body p-4">
					<h5 class="profile-card-header mb-4">Personal Information</h5>
					<div class="row align-items-center mb-4">
						<div class="col-md-auto text-center mb-3 mb-md-0">
							<img
								src="https://cdn-icons-png.flaticon.com/512/9131/9131646.png"
								class="profile-pic" width="100">
						</div>
						<div class="col">
							<div class="row g-3">
								<div class="col-sm-6">
									<label class="profile-detail-label d-block">Full Name</label>
									<p class="profile-detail-value mb-0"><%=name%></p>
								</div>
								<div class="col-sm-6">
									<label class="profile-detail-label d-block">Email</label>
									<p class="profile-detail-value mb-0"><%=email%></p>
								</div>
								<div class="col-sm-6">
									<label class="profile-detail-label d-block">Date of
										Birth</label>
									<p class="profile-detail-value mb-0"><%=dob%></p>
								</div>
								<div class="col-sm-6">
									<label class="profile-detail-label d-block">Contact</label>
									<p class="profile-detail-value mb-0"><%=contact%></p>
								</div>
								<div class="col-12">
									<label class="profile-detail-label d-block">Address</label>
									<p class="profile-detail-value mb-0"><%=address%>,
										<%=city%>,
										<%=pincode%></p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="card border-0">
				<div class="card-body p-4">
					<h5 class="profile-card-header mb-4">Bank Information</h5>
					<div class="row g-3">
						<div class="col-sm-6 col-md-3">
							<label class="profile-detail-label d-block">Bank Name</label>
							<p class="profile-detail-value mb-0"><%=bankName%></p>
						</div>
						<div class="col-sm-6 col-md-3">
							<label class="profile-detail-label d-block">Account
								Number</label>
							<p class="profile-detail-value mb-0"><%=accNo%></p>
						</div>
						<div class="col-sm-6 col-md-3">
							<label class="profile-detail-label d-block">Balance</label>
							<p class="profile-detail-value mb-0">
								₹<%=balance%></p>
						</div>
						<div class="col-sm-6 col-md-3">
							<label class="profile-detail-label d-block">IFSC Code</label>
							<p class="profile-detail-value mb-0"><%=ifsc%></p>
						</div>
						<div class="col-sm-6 col-md-3">
							<label class="profile-detail-label d-block">Card Number</label>
							<p class="profile-detail-value mb-0"><%=cardNo%></p>
						</div>
						<div class="col-sm-6 col-md-3">
							<label class="profile-detail-label d-block">Account
								Status</label>
							<p class="profile-detail-value text-success mb-0"><%=accountStatus%></p>
						</div>
					</div>
				</div>
			</div>

			<div class="d-flex gap-3 justify-content-end mt-2">
				<button class="btn btn-gradient" data-bs-toggle="modal"
					data-bs-target="#editProfileModal">
					<i class="bi bi-pencil-square me-1"></i> Edit Profile
				</button>
				<a href="LogOut.jsp" class="btn btn-outline-danger"> <i
					class="bi bi-box-arrow-right me-1"></i> Logout
				</a>
			</div>

		</div>
	</div>

	<div class="modal fade" id="editProfileModal" tabindex="-1"
		aria-labelledby="editProfileModalLabel">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content border-0 rounded-4 shadow">
				<div class="modal-header border-0 pb-0">
					<h5 class="modal-title fw-bold" id="editProfileModalLabel">Edit
						Profile Information</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<form action="UpdateProfile.jsp" method="post">
					<div class="modal-body">
						<div class="mb-3">
							<label class="form-label fw-semibold">Full Name</label> <input
								type="text" class="form-control" name="fullName"
								value="<%=name%>" required>
						</div>
						<div class="mb-3">
							<label class="form-label fw-semibold">Contact Number</label> <input
								type="text" class="form-control" name="contact"
								value="<%=contact%>">
						</div>
						<div class="mb-3">
							<label class="form-label fw-semibold">Bank Name</label> <input
								type="text" class="form-control" name="bankName"
								value="<%=bankName%>" required>
						</div>
						<div class="mb-3">
							<label class="form-label fw-semibold">Account Number</label> <input
								type="text" class="form-control" name="accountNumber"
								value="<%=accNo%>" required>
						</div>
						<div class="mb-3">
							<label class="form-label fw-semibold">IFSC Code</label> <input
								type="text" class="form-control" name="ifscCode"
								value="<%=ifsc%>" required>
						</div>
						<div class="mb-3">
							<label class="form-label fw-semibold">Card Number</label> <input
								type="text" class="form-control" name="cardNumber"
								value="<%=cardNo%>" required>
						</div>
						<div class="mb-3">
							<label class="form-label fw-semibold">Date of Birth</label> <input
								type="date" class="form-control" name="dob" value="<%=dob%>">
						</div>
						<div class="mb-3">
							<label class="form-label fw-semibold">Address</label>
							<textarea class="form-control" name="address" rows="2"><%=address%></textarea>
						</div>
					</div>
					<div class="modal-footer border-0">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Cancel</button>
						<button type="submit" class="btn btn-gradient">Save
							Changes</button>
					</div>
				</form>
			</div>
		</div>
	</div>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		function toggleSidebar() {
			document.getElementById('sidebar').classList.toggle('show');
			document.querySelector('.overlay').style.display = 'block';
		}
		function closeSidebar() {
			document.getElementById('sidebar').classList.remove('show');
			document.querySelector('.overlay').style.display = 'none';
		}
	</script>
</body>
</html>