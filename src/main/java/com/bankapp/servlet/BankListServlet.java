package com.bankapp.servlet;


import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/BankListServlet")
public class BankListServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String[] banks = { 
            "State Bank of India (SBI)", 
            "HDFC Bank", 
            "ICICI Bank", 
            "Axis Bank", 
            "Kotak Mahindra Bank",
            "Punjab National Bank (PNB)",
            "Bank of Baroda",
            "Union Bank of India",
            "Canara Bank",
            "Indian Bank",
            "IDBI Bank",
            "Yes Bank",
            "IndusInd Bank",
            "Federal Bank",
            "Bandhan Bank",
            "IDFC FIRST Bank",
            "South Indian Bank",
            "RBL Bank",
            "Central Bank of India",
            "UCO Bank"
        };

        request.setAttribute("banks", banks);
        RequestDispatcher rd = request.getRequestDispatcher("Connect.jsp");
        rd.forward(request, response);
    }
}
