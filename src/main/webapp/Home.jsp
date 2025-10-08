<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.servlet.http.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Home - TrustEdge</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
	rel="stylesheet">

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
	display: flex;
	background: var(--bg);
	font-family: Inter, system-ui, -apple-system, 'Segoe UI', Roboto, Arial;
	height: 100vh;
	overflow: hidden;
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

/* Main area */
.main-area {
	flex: 1;
	display: flex;
	flex-direction: column;
	overflow-y: auto;
	-webkit-overflow-scrolling: touch;
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
	flex-wrap: wrap;
}

.topbar .profile-overview {
	display: flex;
	align-items: center;
	gap: 0.75rem;
}

.topbar .overview-text {
	font-weight: 500;
	color: #495057;
}

/* Search box */
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
	color: #fff !important;
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

/* Content area */
.content-area {
	margin: 20px;
}

/* Card */
.card-custom {
	background: #fff;
	border-radius: 12px;
	padding: 20px;
	box-shadow: var(--soft-shadow);
	margin-bottom: 20px;
}

/* Bank card stack */
.card-stack {
	position: relative;
	height: 300px;
}

.card-stack .card-ui {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	max-width: 350px;
	min-height: 220px;
	border-radius: 20px;
	background: linear-gradient(135deg, #6a11cb, #2575fc);
	color: white;
	padding: 20px;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	transition: all 0.3s;
}

.card-stack .card-ui:nth-child(1) {
	z-index: 2;
}

.card-stack .card-ui:nth-child(2) {
	top: 40px;
	z-index: 1;
}

.card-ui .bank-name {
	font-size: 1rem;
	font-weight: 600;
}

.card-ui .chip {
	width: 40px;
	position: absolute;
	top: 20px;
	right: 20px;
}

.card-ui .card-number-heading {
	font-size: 0.75rem;
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

.card-ui .address-box {
	font-size: 0.7rem;
	margin-top: 12px;
}

/* Categories */
.card-custom h5 {
	font-size: 1.1rem;
	color: #333;
	margin-bottom: 1rem;
}

.card-custom .list-group-item {
	border: none;
	padding: 0.75rem 0.5rem;
	font-size: 0.95rem;
	background: transparent;
}

.card-custom .list-group-item:hover {
	background: #f8f9fa;
	border-radius: 8px;
}

.card-custom .bi-circle-fill {
	font-size: 0.7rem;
	vertical-align: middle;
}

.card-custom .fw-semibold {
	color: #0d6efd;
	font-weight: 600;
}

/* Table responsiveness */
.table-responsive {
	max-height: 400px;
	overflow-y: auto;
}

.table th, .table td {
	white-space: nowrap;
}

/* Responsive adjustments */
@media ( max-width : 992px) {
	.sidebar {
		left: -260px;
	}
	.sidebar.active {
		left: 0;
	}
	.main-area {
		margin-left: 0;
	}
	.row.g-4 {
		flex-direction: column;
	}
	.col-md-8, .col-md-4 {
		width: 100%;
	}
	.card-stack .card-ui {
		position: relative !important;
		top: auto !important;
		left: auto !important;
		margin-bottom: 15px;
	}

	/* Topbar styles for mobile/tablet */
	.topbar .overview-text {
		font-size: 1rem;
	}
	.topbar {
		justify-content: space-between;
	}
	/* Hide search and extra icons on small screens */
	.topbar .search-box, .topbar .d-none.d-lg-block {
		display: none !important;
	}
}

@media ( min-width : 992px) {
	.sidebar {
		position: static;
	}
	.topbar .menu-toggle {
		display: none !important;
	}
	/* Hide the mobile close button on desktop */
	.sidebar .close-toggle {
		display: none !important;
	}
}

@media ( max-width : 576px) {
	.topbar .overview-text {
		font-size: 1rem;
	}
	.card-ui .card-number {
		font-size: 1.1rem;
	}
	.card-ui .details {
		flex-direction: column;
		gap: 0.5rem;
	}
	.card-custom h5 {
		font-size: 1rem;
	}
	.table th, .table td {
		font-size: 0.8rem;
	}
	.topbar {
		padding: 1rem;
	}
	.card-stack {
        height: auto; /* Allow cards to stack without overflowing */
    }
}
</style>
</head>
<body>
	<%
	String email = (String) session.getAttribute("r_email");
	String name = (String) session.getAttribute("r_name");
	String balance = "0.00";

	if (email != null) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minibankapp", "root", "root");

			// Total balance
			PreparedStatement psBal = con
			.prepareStatement("SELECT COALESCE(SUM(t_amount),0) as total FROM transactions WHERE t_email=?");
			psBal.setString(1, email);
			ResultSet rsBal = psBal.executeQuery();
			if (rsBal.next())
		balance = rsBal.getString("total");
			rsBal.close();
			psBal.close();

			// Update balance
			PreparedStatement psUpd = con.prepareStatement("UPDATE bank_accounts SET r_balance=? WHERE r_email=?");
			psUpd.setString(1, balance);
			psUpd.setString(2, email);
			psUpd.executeUpdate();
			psUpd.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
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
				<h4 class="overview-text fw-semibold m-0">Home Dashboard</h4>
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
			<div class="row g-4">
				<div class="col-md-8">
					<div class="card-custom mb-3">
						<h5 class="fw-bold mb-2">Account Balance</h5>
						<h3 class="text-primary">
							₹<%=balance%></h3>
					</div>

					<div class="card-custom">
						<h5 class="fw-bold mb-3">Transactions</h5>
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
											boolean hasTxn = false;
											while (rsTxn.next()) {
										hasTxn = true;
										String Tname = rsTxn.getString("t_name");
										double Amt = rsTxn.getDouble("t_amount");
										String Status = rsTxn.getString("t_status");
										Timestamp Date = rsTxn.getTimestamp("t_date");
										String Channel = rsTxn.getString("t_channel");
										String Category = rsTxn.getString("t_category");
									%>
									<tr>
										<td><%=Tname%></td>
										<td class="<%=Amt < 0 ? "text-danger" : "text-success"%>"><%=Amt < 0 ? "-₹" : "₹"%><%=Math.abs(Amt)%></td>
										<td><span class="badge bg-success"><%=Status%></span></td>
										<td><%=Date%></td>
										<td><%=Channel%></td>
										<td><span class="category-badge"><%=Category%></span></td>
									</tr>
									<%
									}
									if (!hasTxn) {
									%>
									<tr>
										<td colspan="6" class="text-muted fw-semibold">No
											Transactions Found</td>
									</tr>
									<%
									}
									rsTxn.close();
									psTxn.close();
									con.close();
									} catch (Exception e) {
									e.printStackTrace();
									}
									} else {
									%>
									<tr>
										<td colspan="6" class="text-muted fw-semibold">No User
											Logged In</td>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
						</div>
					</div>
				</div>

				<div class="col-md-4">
					<div class="card-custom position-relative">
						<h5
							class="fw-bold mb-3 d-flex justify-content-between align-items-center">
							My Bank <a href="SelectBank.jsp"
								class="btn btn-sm btn-dark rounded-circle"><i
								class="bi bi-plus-lg"></i></a>
						</h5>
						<div class="card-stack">
							<%
							boolean showDefault = true;
							if (email != null) {
								try {
									Class.forName("com.mysql.cj.jdbc.Driver");
									Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minibankapp", "root", "root");
									PreparedStatement psBank = con.prepareStatement(
									"SELECT r_bankname,r_cardno,r_expiry,r_ifsc FROM bank_accounts WHERE r_email=? LIMIT 2");
									psBank.setString(1, email);
									ResultSet rs = psBank.executeQuery();
									int count = 0;
									while (rs.next()) {
								showDefault = false;
								count++;
								String bankName = rs.getString("r_bankname");
								String cardNo = rs.getString("r_cardno");
								String expiry = rs.getString("r_expiry");
								String ifsc = rs.getString("r_ifsc");
								String masked = "•••• •••• •••• " + cardNo.substring(cardNo.length() - 4);
							%>
							<div class="card-ui"
								style="position:absolute; top:<%=(count - 1) * 40%>px; left:<%=(count - 1) * 20%>px; z-index:<%=2 - (count - 1)%>;">
								<div>
									<div class="bank-name"><%=bankName%></div>
									<img
										src="https://img.icons8.com/ios-filled/50/ffffff/sim-card-chip.png"
										class="chip">
									<div class="card-number-heading">CARD NUMBER</div>
									<div class="card-number"><%=masked%></div>
								</div>
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
							}
							rs.close();
							psBank.close();
							con.close();
							} catch (Exception e) {
							e.printStackTrace();
							}
							}
							if (showDefault) {
							%>
							<div class="card-ui"
								style="position: absolute; top: 0; left: 0; z-index: 2;">
								<div class="bank-name">No Bank Linked</div>
								<img
									src="https://img.icons8.com/ios-filled/50/ffffff/sim-card-chip.png"
									class="chip">
								<div class="card-number-heading">CARD NUMBER</div>
								<div class="card-number">•••• •••• •••• ••••</div>
								<div class="details">
									<div>
										<div>VALID UPTO</div>
										<div>--/--</div>
									</div>
									<div>
										<div>CARD HOLDER</div>
										<div>----</div>
									</div>
								</div>
								<div class="address-box">----</div>
							</div>
							<%
							}
							%>
						</div>
					</div>

					<div class="card-custom">
						<h5 class="fw-bold mb-3">Spending Categories</h5>
						<ul class="list-group list-group-flush">
							<%
							if (email != null) {
								try {
									Class.forName("com.mysql.cj.jdbc.Driver");
									Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minibankapp", "root", "root");
									PreparedStatement psCat = con.prepareStatement("SELECT t_category, COUNT(*) as txn_count "
									+ "FROM transactions WHERE t_email=? " + "GROUP BY t_category " + "ORDER BY txn_count DESC LIMIT 5");
									psCat.setString(1, email);
									ResultSet rsCat = psCat.executeQuery();
									boolean hasCat = false;
									while (rsCat.next()) {
								hasCat = true;
								String catName = rsCat.getString("t_category");
								int count = rsCat.getInt("txn_count");
							%>
							<li
								class="list-group-item d-flex justify-content-between align-items-center">
								<span><i class="bi bi-circle-fill me-2"></i><%=catName%></span>
								<span class="fw-semibold"><%=count%> times</span>
							</li>
							<%
							}
							if (!hasCat) {
							%>
							<li class="list-group-item text-muted text-center">No
								Categories Found</li>
							<%
							}
							rsCat.close();
							psCat.close();
							con.close();
							} catch (Exception e) {
							e.printStackTrace();
							}
							} else {
							%>
							<li class="list-group-item text-muted text-center">No User
								Logged In</li>
							<%
							}
							%>
						</ul>
					</div>

				</div>

			</div>

		</div>

	</div>



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		function toggleSidebar() {
			document.querySelector('.sidebar').classList.toggle('active');
			document.querySelector('.overlay').style.display = document
					.querySelector('.sidebar').classList.contains('active') ? 'block'
					: 'none';
		}

		function closeSidebar() {
			document.querySelector('.sidebar').classList.remove('active');
			document.querySelector('.overlay').style.display = 'none';
		}
	</script>
</body>
</html>