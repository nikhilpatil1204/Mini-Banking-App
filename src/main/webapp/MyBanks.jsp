<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>MyBanks - TrustEdge</title>
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

body {
	margin: 0;
	height: 100vh;
	display: flex;
	background: var(--bg);
	font-family: Inter, system-ui, -apple-system, 'Segoe UI', Roboto, Arial;
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

.sidebar .nav-link:hover, .sidebar .nav-link.active {
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

/* --- Topbar --- */
.main-area {
	flex: 1;
	display: flex;
	flex-direction: column;
	overflow-y: auto;
}

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

.search-box input {
	min-width: 200px;
}

/* Dropdown */
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

/* Content */
.content-area {
	margin: 0 20px 20px 20px;
	flex: 1;
	display: flex;
	flex-direction: column;
}

/* Bank Cards */
.cards-wrapper {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
}

.card-ui {
	flex: 1 1 300px;
	max-width: 350px;
	height: 220px;
	border-radius: 20px;
	background: linear-gradient(135deg, #6a11cb, #2575fc);
	color: white;
	padding: 20px;
	box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.2);
	position: relative;
}

.card-ui .bank-name {
	font-size: 1rem;
	font-weight: 600;
}

.card-ui .balance {
	font-size: 1.1rem;
	font-weight: 700;
	margin-top: 10px;
}

.card-ui .chip {
	width: 40px;
	opacity: 0.9;
	position: absolute;
	top: 20px;
	right: 20px;
}

.card-ui .card-number-heading {
	font-size: 0.75rem;
	letter-spacing: 1px;
	opacity: 0.8;
	margin-top: 15px;
}

.card-ui .card-number {
	font-size: 1.3rem;
	letter-spacing: 2px;
	margin: 5px 0 20px 0;
}

.card-ui .details {
	display: flex;
	justify-content: space-between;
	font-size: 0.85rem;
}

.card-ui .details div div:first-child {
	font-size: 0.7rem;
	opacity: 0.8;
}

.card-ui .address-box {
	font-size: 0.65rem;
	margin-top: 12px;
	word-break: break-all;
}

/* Responsive Styles */
@media ( max-width : 992px) {
	.sidebar {
		left: -260px;
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
		flex-wrap: nowrap;
		gap: 0.75rem;
	}
	.topbar .profile-overview {
		flex: none;
		justify-content: flex-start;
	}
	.topbar .d-flex {
		gap: 1rem !important;
	}
	.topbar .overview-text {
		display: block !important;
	}
	.topbar .search-box, .topbar .d-md-block {
		display: none !important;
	}
}

@media ( min-width : 992px) {
	.sidebar {
		position: static;
		box-shadow: var(--soft-shadow);
	}
	.main-area {
		flex: 1;
	}
	.menu-toggle {
		display: none !important;
	}
	.topbar .d-flex .d-none.d-md-block {
		display: block !important;
	}
}
</style>
</head>
<body>
	<div class="overlay" onclick="closeSidebar()"></div>
	<%
	String email = (String) session.getAttribute("r_email");
	String name = (String) session.getAttribute("r_name");
	String currentPage = request.getRequestURI();
	%>

	<div class="sidebar" id="sidebar">
		<div
			class="logo-section d-flex align-items-center justify-content-between">
			<div class="d-flex align-items-center">
				<img
					src="https://img.icons8.com/?size=100&id=8g9gOI6iAhrg&format=png&color=000000"
					alt="Logo" width="40">
				<h2 class="fw-bold ms-2">TrustEdge</h2>
			</div>
			<button class="btn p-0 d-lg-none" type="button"
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
				href="Profile.jsp"><i class="bi bi-person-fill me-2"></i>Profile</a>
		</nav>
	</div>

	<div class="main-area">
		<div class="topbar">
			<div class="d-flex align-items-center">
				<div class="profile-overview d-flex align-items-center">
					<h4 class="overview-text fw-semibold m-0">My Banks</h4>
				</div>
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
				<a href="#" class="text-dark fs-5 d-none d-md-block"><i
					class="bi bi-gear-wide-connected"></i></a> <a href="#"
					class="text-dark fs-5 d-none d-md-block"><i
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

		<div class="content-area">
			<div class="m-2">
				<h3>My Bank Accounts</h3>
				<p>Effortlessly fetching your bank activities</p>
			</div>

			<div class="cards-wrapper">
				<%
				boolean hasData = false;
				if (email != null) {
					try {
						Class.forName("com.mysql.cj.jdbc.Driver");
						Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minibankapp", "root", "root");

						PreparedStatement psBank = con
						.prepareStatement("SELECT r_bankname, r_cardno, r_expiry, r_ifsc FROM bank_accounts WHERE r_email=?");
						psBank.setString(1, email);
						ResultSet rs = psBank.executeQuery();

						while (rs.next()) {
					hasData = true;
					String bankName = rs.getString("r_bankname");
					String cardNo = rs.getString("r_cardno");
					String expiry = rs.getString("r_expiry");
					String ifsc = rs.getString("r_ifsc");

					// Mask card number
					String masked = "•••• •••• •••• " + cardNo.substring(cardNo.length() - 4);
				%>
				<div class="card-ui">
					<div class="bank-name"><%=bankName%></div>
					<img
						src="https://img.icons8.com/ios-filled/50/ffffff/sim-card-chip.png"
						class="chip">
					<div class="card-number-heading">CARD NUMBER</div>
					<div class="card-number"><%=masked%></div>
					<div class="details">
						<div>
							<div>VALID UPTO</div>
							<div><%=expiry%></div>
						</div>
						<div>
							<div>CARD HOLDER</div>
							<div><%=name != null ? name : "----"%></div>
						</div>
					</div>
					<div class="address-box"><%=ifsc%></div>
				</div>
				<%
				} // end while
				con.close();
				} catch (Exception e) {
				e.printStackTrace();
				}
				}

				if (!hasData) {
				%>
				<div class="card-ui">
					<div class="bank-name">No Bank Linked</div>
					<div class="card-number-heading">CARD NUMBER</div>
					<div class="card-number">•••• •••• •••• ••••</div>
					<div class="details">
						<div>
							<div>VALID UPTO</div>
							<div>MM/YY</div>
						</div>
						<div>
							<div>CARD HOLDER</div>
							<div>----</div>
						</div>
					</div>
					<div class="address-box">IFSC Code</div>
				</div>
				<%
				}
				%>
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