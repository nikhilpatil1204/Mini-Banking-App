<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bank Login Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: #f8f9fa;
            font-family: Arial, sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }
        .confirm-container {
            background: #fff;
            width: 90%;
            max-width: 500px;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
            position: relative;
            text-align: center;
        }
        .close-btn, .back-btn {
            position: absolute;
            top: 15px;
            font-size: 20px;
            cursor: pointer;
            border: none;
            background: transparent;
        }
        .close-btn { right: 15px; }
        .back-btn { left: 15px; }
        .bank-title {
            font-size: 22px;
            font-weight: bold;
            margin-top: 20px;
        }
        .checklist {
            margin-top: 25px;
            text-align: left;
        }
        .checklist .form-check {
            margin-bottom: 15px;
            font-size: 16px;
        }
        .continue-btn {
            margin-top: 30px;
        }
    </style>
    <script>
        function goBack() {
            window.history.back();
        }
        function closePage() {
            window.location.href = "index.jsp";
        }
    </script>
</head>
<body>
    <%
        String bankName = request.getParameter("bankName");
        if (bankName == null) bankName = "Your Bank";
    %>
    <div class="confirm-container">
        <button class="back-btn" onclick="goBack()">&#8592;</button>
        <button class="close-btn" onclick="closePage()">&#10006;</button>

        <img src="https://img.icons8.com/color/96/bank.png" alt="Bank Icon" height="60">
        <div class="bank-title">Log in at <%= bankName %></div>
        <p class="text-muted">After logging into <%= bankName %>, make sure you check all these boxes:</p>

        <div class="checklist">
            <div class="form-check">
                <input class="form-check-input" type="checkbox" checked disabled>
                <label class="form-check-label">Checking or savings account</label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="checkbox" checked disabled>
                <label class="form-check-label">Account and routing number</label>
            </div>
        </div>

        <div class="continue-btn">
            <a href="https://www.<%= bankName.replaceAll(" ", "").toLowerCase() %>.com" 
               target="_blank" class="btn btn-dark btn-lg w-100">
                Continue to log in
            </a>
        </div>
    </div>
</body>
</html>
