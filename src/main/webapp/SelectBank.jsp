<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Select Your Bank</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background: #f8f9fa;
	font-family: Arial, sans-serif;
	margin: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.bank-container {
	width: 90%;
	max-width: 900px;
	height: 90vh; /* Fixed height to prevent page scroll */
	max-height: 900px;
	background: #fff;
	border-radius: 0;
	padding: 30px;
	box-shadow: none;
	position: relative;
	display: flex;
	flex-direction: column;
}

/* For tablets and desktops */
@media ( min-width : 768px) {
	.bank-container {
		border-radius: 12px;
		box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
	}
}

.bank-container h3 {
	font-weight: bold;
	margin-bottom: 20px;
	text-align: center;
}

.search-box {
	margin-bottom: 20px;
}

.search-box input {
	border-radius: 8px;
	padding: 10px;
	width: 100%;
	border: 1px solid #ddd;
}

.bank-grid {
	flex: 1;
	height: 100%; /* Take up remaining height */
	display: grid;
	grid-template-columns: repeat(1, 1fr);
	/* Default to 1 column on mobile */
	gap: 20px;
	overflow-y: auto;
	padding-right: 10px;
}

/* 2 cards per row on tablet */
@media ( min-width : 768px) {
	.bank-grid {
		grid-template-columns: repeat(2, 1fr);
	}
}

/* 3 cards per row on laptop */
@media ( min-width : 1024px) {
	.bank-grid {
		grid-template-columns: repeat(3, 1fr);
	}
}

/* 💻 Custom small white scrollbar 🤍 */
.bank-grid::-webkit-scrollbar {
	width: 6px;
}

.bank-grid::-webkit-scrollbar-track {
	background: transparent;
}

.bank-grid::-webkit-scrollbar-thumb {
	background-color: #f0f0f0;
	border-radius: 3px;
	border: none;
}

.bank-grid::-webkit-scrollbar-thumb:hover {
	background-color: #e0e0e0;
}

.bank-card {
	border-radius: 12px;
	padding: 30px 15px;
	background: #fff;
	text-align: center;
	cursor: pointer;
	transition: 0.3s;
	height: 180px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
}

.bank-card:hover {
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.15);
	transform: scale(1.05);
}

.bank-card img {
	height: 65px;
	width: auto;
	max-width: 100px;
	object-fit: contain;
	margin-bottom: 12px;
}

.bank-name {
	font-size: 16px;
	font-weight: 600;
	color: #333;
	word-wrap: break-word;
}

.close-btn, .back-btn {
	position: absolute;
	top: 15px;
	font-size: 20px;
	cursor: pointer;
	border: none;
	background: transparent;
	color: #666;
}

.close-btn {
	right: 15px;
}

.back-btn {
	left: 15px;
}
</style>
<script>
	function filterBanks() {
		let input = document.getElementById("bankSearch").value.toLowerCase();
		let forms = document.querySelectorAll(".bank-grid form");
		forms.forEach(form => {
			let name = form.querySelector(".bank-name").innerText.toLowerCase();
			form.style.display = name.includes(input) ? "block" : "none";
		});
	}
	function goBack() {
		window.history.back();
	}
	function closePage() {
		window.location.href = "index.jsp";
	}
</script>
</head>
<body>
	<div class="bank-container">
		<button class="back-btn" onclick="goBack()">&#8592;</button>
		<button class="close-btn" onclick="closePage()">&#10006;</button>

		<h3>Select Your Bank</h3>
		<div class="search-box">
			<input type="text" id="bankSearch" onkeyup="filterBanks()"
				placeholder="Search for your bank...">
		</div>
		<div class="bank-grid">
			<%
			Map<String, String> bankLogos = new HashMap<>();
			bankLogos.put("State Bank of India (SBI)", "Images/SBI logo.svg");
			bankLogos.put("HDFC Bank", "Images/HDFC Bank logo.jpeg");
			bankLogos.put("ICICI Bank", "Images/ICICI Bank logo.svg");
			bankLogos.put("Axis Bank", "Images/Axis Bank logo.svg");
			bankLogos.put("Kotak Mahindra Bank", "Images/Kotak Bank Logo.svg");
			bankLogos.put("Punjab National Bank (PNB)", "Images/Punjab National Bank logo.png");
			bankLogos.put("Bank of Baroda", "Images/Bank of Baroda logo.svg");
			bankLogos.put("Union Bank of India", "Images/Union Bank Logo.png");
			bankLogos.put("Canara Bank", "Images/Canara Bank logo.png");
			bankLogos.put("Indian Bank", "Images/Indian Bank Logo.png");
			bankLogos.put("IDBI Bank", "Images/IDBI Bank logo.png");
			bankLogos.put("Yes Bank", "Images/YES Bank logo.svg");
			bankLogos.put("IndusInd Bank", "Images/Indusind Bank logo.jpeg");
			bankLogos.put("Federal Bank", "Images/Fedral Bank logo.jpeg");
			bankLogos.put("Bandhan Bank", "Images/Bandhan Bank logo.png");
			bankLogos.put("IDFC FIRST Bank", "Images/IDFC Bank logo.png");
			bankLogos.put("South Indian Bank", "Images/South Indian Bank logo.png");
			bankLogos.put("RBL Bank", "Images/RBL Bank logo.jpg");
			bankLogos.put("Central Bank of India", "Images/Central bank of India logo.png");
			bankLogos.put("UCO Bank", "Images/Uco Bank.png");

			String[] banks = bankLogos.keySet().toArray(new String[0]);
			Arrays.sort(banks);

			for (String bank : banks) {
				String logoUrl = bankLogos.getOrDefault(bank, "https://img.icons8.com/color/96/bank.png");
			%>
			<form action="BankRegister.jsp" method="post" style="margin: 0;">
				<input type="hidden" name="bankName" value="<%=bank%>">
				<div class="bank-card" onclick="this.closest('form').submit()">
					<img src="<%=logoUrl%>" alt="<%=bank%> Logo">
					<div class="bank-name"><%=bank%></div>
				</div>
			</form>
			<%
			}
			%>
		</div>
	</div>
</body>
</html>