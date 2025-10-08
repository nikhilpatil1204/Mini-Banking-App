<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Dashboard - TrustEdge</title>
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

.stat-card {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;
	gap: 5px;
}

.stat-card p {
	font-size: 0.9rem;
	margin: 0;
	color: #6c757d;
}

.stat-card h3 {
	color: var(--accent);
	font-weight: 700;
	margin: 0;
	font-size: 1.5rem;
}

.stat-card .icon {
	font-size: 2rem;
	color: var(--accent);
}

.table th {
	background: #f1f3f5;
}

.table td {
	white-space: nowrap;
}

.table-responsive::-webkit-scrollbar {
	height: 8px;
	background-color: transparent;
}

.table-responsive::-webkit-scrollbar-thumb {
	background-color: #c0c0c0;
	border-radius: 10px;
	border: 2px solid var(--card);
}

.table-responsive {
	scrollbar-width: thin;
	scrollbar-color: #c0c0c0 transparent;
}

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
	.stat-card p {
		font-size: 1rem;
	}
	.stat-card h3 {
		font-size: 1.75rem;
	}
	.stat-card .icon {
		font-size: 2rem;
	}
}

@media ( max-width : 991px) {
	.table-responsive {
		overflow-x: auto;
	}
}
</style>
</head>
<body>
	<div class="overlay" id="overlay" onclick="closeSidebar()"></div>

	<%
	final String DB_URL = "jdbc:mysql://localhost:3306/minibankapp";
	final String USER = "root";
	final String PASS = "root";

	int totalUsers = 0, totalAccounts = 0, totalTxns = 0;
	double totalFunds = 0;
	List<Map<String, Object>> userList = new ArrayList<>();
	List<Map<String, Object>> txnList = new ArrayList<>();

	Connection con = null;
	Statement st = null;

	// Handle Delete
	if (request.getParameter("deleteId") != null) {
		int deleteId = Integer.parseInt(request.getParameter("deleteId"));
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(DB_URL, USER, PASS);
			st = con.createStatement();
			st.executeUpdate("DELETE FROM register WHERE r_id=" + deleteId);
			// Alert removed
		} catch (Exception e) {
			// Alert removed
		} finally {
			if (st != null)
		st.close();
			if (con != null)
		con.close();
		}
	}

	// Handle Update
	if (request.getParameter("updateId") != null) {
		int updateId = Integer.parseInt(request.getParameter("updateId"));
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String contact = request.getParameter("contact");
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(DB_URL, USER, PASS);
			st = con.createStatement();
			st.executeUpdate("UPDATE register SET r_name='" + name + "', r_email='" + email + "', r_contact='" + contact
			+ "' WHERE r_id=" + updateId);
			// Alert removed
		} catch (Exception e) {
			// Alert removed
		} finally {
			if (st != null)
		st.close();
			if (con != null)
		con.close();
		}
	}

	// Fetch stats and users
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection(DB_URL, USER, PASS);
		st = con.createStatement();

		ResultSet rs = st.executeQuery("SELECT COUNT(*) AS c FROM register");
		if (rs.next())
			totalUsers = rs.getInt("c");

		rs = st.executeQuery("SELECT COUNT(*) AS c FROM bank_accounts");
		if (rs.next())
			totalAccounts = rs.getInt("c");

		rs = st.executeQuery("SELECT COALESCE(SUM(r_balance),0) AS s FROM bank_accounts");
		if (rs.next())
			totalFunds = rs.getDouble("s");

		rs = st.executeQuery("SELECT COUNT(*) AS c FROM transactions");
		if (rs.next())
			totalTxns = rs.getInt("c");

		rs = st.executeQuery("SELECT r_id, r_name, r_email, r_contact FROM register LIMIT 10");
		while (rs.next()) {
			Map<String, Object> m = new HashMap<>();
			m.put("id", rs.getInt("r_id"));
			m.put("name", rs.getString("r_name"));
			m.put("email", rs.getString("r_email"));
			m.put("contact", rs.getString("r_contact"));
			userList.add(m);
		}

		rs = st.executeQuery(
		"SELECT t_id, t_email, t_amount, t_status, t_date FROM transactions ORDER BY t_date DESC LIMIT 10");
		while (rs.next()) {
			Map<String, Object> m = new HashMap<>();
			m.put("id", rs.getInt("t_id"));
			m.put("email", rs.getString("t_email"));
			m.put("amt", rs.getDouble("t_amount"));
			m.put("status", rs.getString("t_status"));
			m.put("date", rs.getTimestamp("t_date"));
			txnList.add(m);
		}

	} catch (Exception e) {
		// Alert removed
	} finally {
		if (st != null)
			st.close();
		if (con != null)
			con.close();
	}
	%>


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
			<a class="nav-link active" onclick="scrollToSection('stats')"><i
				class="bi bi-speedometer2 me-2"></i>Dashboard</a> <a class="nav-link"
				onclick="scrollToSection('users')"><i
				class="bi bi-people-fill me-2"></i>Users</a> <a class="nav-link"
				onclick="scrollToSection('stats')"><i class="bi bi-bank2 me-2"></i>Accounts</a>
			<a class="nav-link" onclick="scrollToSection('transactions')"><i
				class="bi bi-cash me-2"></i>Transactions</a> <a class="nav-link"
				href="AdminProfile.jsp"><i class="bi bi-person-circle me-2"></i>Profile</a>
		</nav>
	</div>

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
			<!-- Stats -->
			<div id="stats" class="row g-2 mb-2">
				<div class="col-12 col-md-6 col-lg-3">
					<div class="card-custom stat-card">
						<i class="bi bi-people-fill icon"></i>
						<p>Total Users</p>
						<h3><%=totalUsers%></h3>
					</div>
				</div>
				<div class="col-12 col-md-6 col-lg-3">
					<div class="card-custom stat-card">
						<i class="bi bi-bank icon"></i>
						<p>Accounts</p>
						<h3><%=totalAccounts%></h3>
					</div>
				</div>
				<div class="col-12 col-md-6 col-lg-3">
					<div class="card-custom stat-card">
						<i class="bi bi-wallet2 icon"></i>
						<p>Funds</p>
						<h3>
							₹<%=String.format("%,.2f", totalFunds)%></h3>
					</div>
				</div>
				<div class="col-12 col-md-6 col-lg-3">
					<div class="card-custom stat-card">
						<i class="bi bi-cash icon"></i>
						<p>Txns</p>
						<h3><%=totalTxns%></h3>
					</div>
				</div>
			</div>

			<!-- Recent Users Table with Edit/Delete -->
			<div id="users" class="card-custom mb-2">
				<h5 class="fw-bold mb-3">Recent Users</h5>
				<div class="table-responsive">
					<table class="table table-hover align-middle">
						<thead>
							<tr>
								<th>ID</th>
								<th>Name</th>
								<th>Email</th>
								<th>Mobile</th>
								<th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (Map<String, Object> user : userList) {
							%>
							<tr>
								<form method="post">
									<td><%=user.get("id")%> <input type="hidden"
										name="updateId" value="<%=user.get("id")%>"></td>
									<td><input type="text"
										class="form-control form-control-sm" name="name"
										value="<%=user.get("name")%>" required></td>
									<td><input type="email"
										class="form-control form-control-sm" name="email"
										value="<%=user.get("email")%>" required></td>
									<td><input type="text"
										class="form-control form-control-sm" name="contact"
										value="<%=user.get("contact")%>" required></td>
									<td>
										<button type="submit"
											class="btn btn-sm btn-outline-primary mb-1">
											<i class="bi bi-pencil"></i> Update
										</button> <a href="?deleteId=<%=user.get("id")%>"
										class="btn btn-sm btn-outline-danger"
										onclick="return confirm('Are you sure to delete this user?')">
											<i class="bi bi-trash"></i> Delete
									</a>
									</td>
								</form>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>

			<!-- Recent Transactions Table -->
			<div id="transactions" class="card-custom mb-2">
				<h5 class="fw-bold mb-3">Recent Transactions</h5>
				<div class="table-responsive">
					<table class="table table-hover text-center align-middle">
						<thead>
							<tr>
								<th>ID</th>
								<th>Email</th>
								<th>Amount</th>
								<th>Status</th>
								<th>Date</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (Map<String, Object> txn : txnList) {
								double amt = (Double) txn.get("amt");
							%>
							<tr>
								<td><%=txn.get("id")%></td>
								<td><%=txn.get("email")%></td>
								<td class="<%=(amt < 0) ? "text-danger" : "text-success"%>"><%=(amt < 0 ? "-" : "+")%>₹<%=String.format("%,.2f", Math.abs(amt))%>
								</td>
								<td><span
									class="badge bg-<%="SUCCESS".equalsIgnoreCase((String) txn.get("status")) ? "success" : "warning"%>">
										<%=txn.get("status")%>
								</span></td>
								<td><%=txn.get("date")%></td>
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
			document.getElementById('overlay').classList.toggle('show');
		}
		function closeSidebar() {
			document.getElementById('sidebar').classList.remove('show');
			document.getElementById('overlay').classList.remove('show');
		}
		function scrollToSection(id) {
			const section = document.getElementById(id);
			if (section) {
				section.scrollIntoView({
					behavior : 'smooth'
				});
			}
			closeSidebar();
		}
	</script>

</body>
</html>

