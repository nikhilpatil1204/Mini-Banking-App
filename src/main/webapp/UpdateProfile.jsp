<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
// ✅ Use the implicit session object
String email = (String) session.getAttribute("r_email");
if (email == null) {
	response.sendRedirect("Login.jsp"); // Redirect if session expired
	return;
}

// Get form parameters
String fullName = request.getParameter("fullName");
String contact = request.getParameter("contact");
String bankName = request.getParameter("bankName");
String accountNumber = request.getParameter("accountNumber");
String ifscCode = request.getParameter("ifscCode");
String cardNumber = request.getParameter("cardNumber");
String dob = request.getParameter("dob");
String address = request.getParameter("address");

try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/minibankapp", "root", "root")) {

		// Update personal info
		String sql1 = "UPDATE register SET r_name=?, r_contact=?, r_dob=?, r_address=? WHERE r_email=?";
		try (PreparedStatement ps1 = con.prepareStatement(sql1)) {
	ps1.setString(1, fullName);
	ps1.setString(2, contact);
	ps1.setString(3, dob);
	ps1.setString(4, address);
	ps1.setString(5, email);
	ps1.executeUpdate();
		}

		// Update bank info
		String sql2 = "UPDATE bank_accounts SET r_bankname=?, r_accountno=?, r_ifsc=?, r_cardno=? WHERE r_email=?";
		try (PreparedStatement ps2 = con.prepareStatement(sql2)) {
	ps2.setString(1, bankName);
	ps2.setString(2, accountNumber);
	ps2.setString(3, ifscCode);
	ps2.setString(4, cardNumber);
	ps2.setString(5, email);
	ps2.executeUpdate();
		}
	}

	// Update session variables
	session.setAttribute("r_name", fullName);
	session.setAttribute("r_contact", contact);
	session.setAttribute("r_dob", dob);
	session.setAttribute("r_address", address);

	// Redirect back to Profile.jsp with success
	response.sendRedirect("Profile.jsp?update=success");

} catch (Exception e) {
	out.println("<script>alert('Error: " + e.getMessage() + "'); window.location.href='Profile.jsp';</script>");
}
%>
