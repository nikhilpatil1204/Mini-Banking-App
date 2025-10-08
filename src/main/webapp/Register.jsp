<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign Up - TrustEdge</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<style>
body {
	background-color: #f8f9fa;
	font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
		"Helvetica Neue", Arial, sans-serif;
	margin: 0;
}

.signup-container {
	width: 100%;
	max-width: 650px;
	margin: 0 auto;
	background: #fff;
	padding: 2rem 1.5rem;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	border-radius: 0;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
}

/* Tablet and larger */
@media ( min-width : 768px) {
	.signup-container {
		margin: 2.5rem auto;
		border-radius: 12px;
		min-height: auto;
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

h2 {
	font-weight: 700;
	font-size: 1.8rem;
	color: #007bff;
}

.text-muted {
	color: #6c757d !important;
}

.form-label {
	font-weight: 600;
	color: #333;
}

.form-control, .form-select {
	border-radius: 8px;
	padding: 0.75rem 1rem;
	border-color: #ced4da;
}

.form-control:focus, .form-select:focus {
	box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.25);
	border-color: #80bdff;
}

.error-msg {
	color: #dc3545;
	font-size: 0.85em;
	margin-top: 4px;
}

.btn-custom {
	background: linear-gradient(to right, #007bff, #1e90ff);
	color: #fff;
	border: none;
	padding: 0.75rem 1.5rem;
	border-radius: 8px;
	font-weight: 600;
	font-size: 1rem;
	transition: background 0.3s ease, transform 0.2s ease;
}
</style>
</head>
<body>
	<div class="signup-container">
		<div class="brand-logo">
			<img
				src="https://img.icons8.com/?size=100&id=8g9gOI6iAhrg&format=png&color=000000"
				alt="Logo">
			<h3>TrustEdge</h3>
		</div>

		<h2>Sign Up</h2>
		<p class="text-muted">Please enter your details to create an
			account.</p>

		<form id="signupForm" method="post" class="mt-4">
			<div class="mb-3">
				<label class="form-label">Name</label> <input type="text"
					name="r_name" class="form-control"
					placeholder="Enter your full name" required>
				<div class="error-msg" id="nameError"></div>
			</div>

			<div class="mb-3">
				<label class="form-label">Date of Birth</label> <input type="date"
					name="r_dob" class="form-control" required>
				<div class="error-msg" id="dobError"></div>
			</div>

			<div class="mb-3">
				<label class="form-label">Contact</label> <input type="tel"
					name="r_contact" class="form-control"
					placeholder="e.g., 9876543210" required>
				<div class="error-msg" id="contactError"></div>
			</div>

			<div class="mb-3">
				<label class="form-label">Email</label> <input type="email"
					name="r_email" class="form-control" placeholder="Emter Your Email Address"
					required>
				<div class="error-msg" id="emailError"></div>
			</div>

			<div class="mb-3">
				<label class="form-label">Password</label> <input type="password"
					name="r_password" class="form-control"
					placeholder="Create a strong password" required>
				<div class="error-msg" id="passwordError"></div>
			</div>

			<div class="mb-3">
				<label class="form-label">Address</label> <input type="text"
					name="r_address" class="form-control"
					placeholder="Enter your street address" required>
				<div class="error-msg" id="addressError"></div>
			</div>

			<div class="row g-3">
				<div class="col-md-4">
					<label class="form-label">Country</label> <select id="country"
						name="r_country" class="form-select" required>
						<option value="">Select Country</option>
					</select>
					<div class="error-msg" id="countryError"></div>
				</div>
				<div class="col-md-4">
					<label class="form-label">State</label> <select id="state"
						name="r_state" class="form-select" required>
						<option value="">Select State</option>
					</select>
					<div class="error-msg" id="stateError"></div>
				</div>
				<div class="col-md-4">
					<label class="form-label">City</label> <select id="city"
						name="r_city" class="form-select" required>
						<option value="">Select City</option>
					</select>
					<div class="error-msg" id="cityError"></div>
				</div>
			</div>

			<div class="mb-3 mt-3">
				<label class="form-label">Pin Code</label> <input type="text"
					name="r_pincode" class="form-control" placeholder="e.g., 411041"
					required>
				<div class="error-msg" id="pincodeError"></div>
			</div>

			<div class="d-grid mt-4">
				<button type="submit" name="register" class="btn btn-custom btn-lg">Sign
					Up</button>
			</div>

			<p class="text-center mt-3">
				Already have an account? <a href="Login.jsp">Sign in</a>
			</p>
		</form>
	</div>


	<div class="toast-container position-fixed top-0 end-0 p-3"
		style="z-index: 1100;">
		<div id="successToast"
			class="toast align-items-center text-bg-success border-0"
			role="alert">
			<div class="d-flex">
				<div class="toast-body">
					<span class="fw-bold">✓</span> Registration Successful! Redirecting
					to login...
				</div>
				<button type="button" class="btn-close btn-close-white me-2 m-auto"
					data-bs-dismiss="toast"></button>
			</div>
		</div>
	</div>

	<%
	if (request.getParameter("register") != null) {
		String Name = request.getParameter("r_name");
		String DOB = request.getParameter("r_dob");
		String Contact = request.getParameter("r_contact");
		String Email = request.getParameter("r_email");
		String Password = request.getParameter("r_password");
		String Address = request.getParameter("r_address");
		String Country = request.getParameter("r_country");
		String State = request.getParameter("r_state");
		String City = request.getParameter("r_city");
		String PinCode = request.getParameter("r_pincode");

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minibankapp", "root", "root");
			Statement st = con.createStatement();
			st.executeUpdate(
			"insert into register (r_name, r_dob, r_contact, r_email, r_password, r_address, r_country, r_state, r_city, r_pincode) "
					+ "values ('" + Name + "', '" + DOB + "','" + Contact + "','" + Email + "', '" + Password
					+ "', '" + Address + "', '" + Country + "', '" + State + "', '" + City + "', '" + PinCode
					+ "')");


			out.println(
			"<script>window.onload = function(){ let toastEl = document.getElementById('successToast'); let toast = new bootstrap.Toast(toastEl, { delay: 4000 }); toast.show(); setTimeout(()=>{ window.location='Login.jsp'; }, 4200); }</script>");

		} catch (Exception e) {
			out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
		}
	}
	%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

	<script>
fetch("https://countriesnow.space/api/v0.1/countries")
  .then(res => res.json())
  .then(data => {
    let countrySelect = document.getElementById("country");
    data.data.forEach(c => {
      let opt = document.createElement("option");
      opt.value = c.country;
      opt.textContent = c.country;
      countrySelect.appendChild(opt);
    });
  });

document.getElementById("country").addEventListener("change", function() {
  let country = this.value;
  let stateSelect = document.getElementById("state");
  let citySelect = document.getElementById("city");

  stateSelect.innerHTML = "<option value=''>Select State</option>";
  citySelect.innerHTML = "<option value=''>Select City</option>";

  if(country){
    fetch("https://countriesnow.space/api/v0.1/countries/states", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ country: country })
    })
    .then(res => res.json())
    .then(data => {
      data.data.states.forEach(s => {
        let opt = document.createElement("option");
        opt.value = s.name;
        opt.textContent = s.name;
        stateSelect.appendChild(opt);
      });
    });
  }
});

document.getElementById("state").addEventListener("change", function() {
  let country = document.getElementById("country").value;
  let state = this.value;
  let citySelect = document.getElementById("city");

  citySelect.innerHTML = "<option value=''>Select City</option>";

  if(state){
    fetch("https://countriesnow.space/api/v0.1/countries/state/cities", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ country: country, state: state })
    })
    .then(res => res.json())
    .then(data => {
      data.data.forEach(city => {
        let opt = document.createElement("option");
        opt.value = city;
        opt.textContent = city;
        citySelect.appendChild(opt);
      });
    });
  }
});
</script>

	<script>
document.getElementById("signupForm").addEventListener("submit", function (e) {
    let valid = true;
    document.querySelectorAll(".error-msg").forEach(el => el.textContent = "");

    if (this.r_name.value.trim().length < 2) {
        document.getElementById("nameError").textContent = "Please enter a valid name.";
        valid = false;
    }
    if (!this.r_dob.value) {
        document.getElementById("dobError").textContent = "Please select your DOB.";
        valid = false;
    }
    if (!/^[0-9]{10}$/.test(this.r_contact.value.trim())) {
        document.getElementById("contactError").textContent = "Enter a valid 10-digit number.";
        valid = false;
    }
    let emailPattern = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;
    if (!emailPattern.test(this.r_email.value.trim())) {
        document.getElementById("emailError").textContent = "Enter a valid email address.";
        valid = false;
    }
    if (this.r_password.value.length < 8) {
        document.getElementById("passwordError").textContent = "Password must be at least 8 characters.";
        valid = false;
    }
    if (!this.r_address.value.trim()) {
        document.getElementById("addressError").textContent = "Address is required.";
        valid = false;
    }
    if (!this.r_country.value) {
        document.getElementById("countryError").textContent = "Select your country.";
        valid = false;
    }
    if (!this.r_state.value) {
        document.getElementById("stateError").textContent = "Select your state.";
        valid = false;
    }
    if (!this.r_city.value) {
        document.getElementById("cityError").textContent = "Select your city.";
        valid = false;
    }
    if (!/^[0-9]{6}$/.test(this.r_pincode.value.trim())) {
        document.getElementById("pincodeError").textContent = "Enter a valid 6-digit pincode.";
        valid = false;
    }
    if (!valid) e.preventDefault();
});
</script>
</body>
</html>