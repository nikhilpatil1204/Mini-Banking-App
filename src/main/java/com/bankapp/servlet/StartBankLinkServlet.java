package com.bankapp.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/StartBankLinkServlet")
public class StartBankLinkServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Simulate redirect to DigiLocker (mock)
        response.sendRedirect("BankListServlet");
    }
}
