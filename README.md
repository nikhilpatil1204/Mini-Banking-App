# 🏦 Mini Banking App

## 📋 Overview
The **Mini Banking App** is a web-based banking management system built using **Java**, **JSP**, and **Servlets**.  
It allows users to perform basic banking operations such as viewing account details, checking balances, and managing transactions.  
The project also integrates **Google OAuth Login** and connects to a backend server to fetch bank data dynamically.

## 🚀 Features
- 🔐 **User Authentication**
  - Login using **Google Account (OAuth 2.0)**
  - Secure session handling using Servlets
- 🏦 **Bank Management**
  - Fetches real-time bank data from Servlet APIs
  - Displays user bank accounts and balances
- 💳 **Transactions**
  - Deposit and withdrawal simulation
  - Transaction history display
- ⚙️ **Backend**
  - Built using **JSP** and **Servlets**
  - Hosted on **Apache Tomcat Server**
- 🌐 **Frontend**
  - JSP pages with Bootstrap styling
  - Responsive and user-friendly UI

## 🧰 Tech Stack

| Layer | Technology Used |
|-------|------------------|
| Frontend | HTML, CSS, JSP, Bootstrap |
| Backend | Java, Servlets |
| Authentication | Google OAuth 2.0 |
| Server | Apache Tomcat |
| Database (if any) | MySQL / Local Data |
| Build Tool | Manual Setup / Maven (as per use) |

## Folder structure

Mini-Banking-App/
│
├── src/
│   ├── com.bank.servlet/
│   │   ├── GoogleLoginServlet.java
│   │   ├── FetchBankServlet.java
│   │   └── ...
│
├── WebContent/
│   ├── index.jsp
│   ├── home.jsp
│   ├── WEB-INF/
│   │   └── web.xml
│
├── lib/
│   ├── gson.jar
│   ├── servlet-api.jar
│
└── README.md


