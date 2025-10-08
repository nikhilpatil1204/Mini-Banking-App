<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Transactions - TrustEdge</title>
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
	overflow-y: auto;
}

.card-custom {
	background: #fff;
	border-radius: 12px;
	padding: 20px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.table th {
	background: #f1f3f5;
}

.table td.amount-positive {
	color: #198754 !important;
	font-weight: 600;
}

.table td.amount-negative {
	color: #dc3545 !important;
	font-weight: 600;
}

.category-badge {
	padding: 5px 10px;
	border-radius: 12px;
	font-size: 0.85rem;
}

/* Responsive */
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
}
</style>
</head>
<body>
	<div class="overlay" onclick="closeSidebar()"></div>
	<%
	String email = (String) session.getAttribute("r_email");
	double balance = 0.0;

	if (email != null) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minibankapp", "root", "root");

			PreparedStatement psBal = con.prepareStatement("SELECT SUM(t_amount) as bal FROM transactions WHERE t_email=?");
			psBal.setString(1, email);
			ResultSet rsBal = psBal.executeQuery();
			if (rsBal.next()) {
		balance = rsBal.getDouble("bal");
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
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
				<h4 class="overview-text fw-semibold m-0">Transaction History</h4>
			</div>

			<div class="d-flex align-items-center gap-3">
				<div class="search-box position-relative d-none d-lg-block">
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
								class="bi bi-person-fill"></i> Profile</a></li>
						<li><a class="dropdown-item" href="Settings.jsp"><i
								class="bi bi-gear-fill"></i> Settings</a></li>
						<li><a class="dropdown-item" href="LogOut.jsp"><i
								class="bi bi-box-arrow-right"></i> Logout</a></li>
					</ul>
				</div>
			</div>
		</div>

		<div class="content-area">
			<div class="card-custom">
				<div
					class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
					<div>
						<h3 class="mb-1">Bank Account</h3>
						<p class="text-muted mb-0">Linked Account Transactions</p>
					</div>
					<div>
						<h4 class="fw-bold text-primary mb-0">
							Current Balance: ₹<%=balance%>
						</h4>
					</div>
				</div>

				<div class="table-responsive">
					<table class="table text-center table-hover">
						<thead>
							<tr>
								<th>Transaction</th>
								<th>Amount</th>
								<th>Status</th>
								<th>Date</th>
								<th>Channel</th>
								<th>Category</th>
							</tr>
						</thead>
						<tbody>
							<%
							if (email != null) {
								try {
									Class.forName("com.mysql.cj.jdbc.Driver");
									Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minibankapp", "root", "root");
									PreparedStatement psTxn = con
									.prepareStatement("SELECT * FROM transactions WHERE t_email=? ORDER BY t_date DESC");
									psTxn.setString(1, email);
									ResultSet rsTxn = psTxn.executeQuery();
									while (rsTxn.next()) {
								String Tname = rsTxn.getString("t_name");
								double Amt = rsTxn.getDouble("t_amount");
								String Status = rsTxn.getString("t_status");
								Timestamp Date = rsTxn.getTimestamp("t_date");
								String Channel = rsTxn.getString("t_channel");
								String Category = rsTxn.getString("t_category");
							%>
							<tr>
								<td><%=Tname%></td>
								<td class="<%=Amt < 0 ? "amount-negative" : "amount-positive"%>">
									<%=Amt < 0 ? "-₹" + Math.abs(Amt) : "+₹" + Amt%>
								</td>
								<td><span class="badge bg-success"><%=Status%></span></td>
								<td><%=Date%></td>
								<td><%=Channel%></td>
								<td><span class="category-badge"><%=Category%></span></td>
							</tr>
							<%
							}
							con.close();
							} catch (Exception e) {
							e.printStackTrace();
							}
							} else {
							%>
							<tr>
								<td colspan="6" class="text-center text-muted">No user
									logged in.</td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
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