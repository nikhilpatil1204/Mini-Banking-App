<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Logout - TrustEdge</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body {
    background-color: #f8f9fa;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto,
        "Helvetica Neue", Arial, sans-serif;
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100vh;
    margin: 0;
}
.logout-box {
    background: #fff;
    padding: 2rem;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    text-align: center;
    max-width: 400px;
}
h2 {
    color: #dc3545;
    font-weight: 700;
    margin-bottom: 1rem;
}
</style>
</head>
<body>

<div class="logout-box">
    <h2>Logged Out</h2>
    <p class="text-muted">You have been logged out successfully.<br>Redirecting to Login page...</p>
    <a href="Login.jsp" class="btn btn-primary mt-3">Go to Login</a>
</div>

<!-- Toast -->
<div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 1100;">
    <div id="logoutToast" class="toast align-items-center text-bg-primary border-0" role="alert">
        <div class="d-flex">
            <div class="toast-body">
                <span class="fw-bold">✓</span> You have been logged out successfully.
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"></button>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function() {
    let toast = new bootstrap.Toast(document.getElementById('logoutToast'), { delay: 3000 });
    toast.show();
    setTimeout(() => { window.location.href = "index.jsp"; }, 3000);
});
</script>

<%
   // ✅ Invalidate session at the bottom
   if (session != null) {
       session.invalidate();
   }
%>

</body>
</html>
