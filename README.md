# Mini Banking App

## 🧾 Overview
The **Mini Banking App** is a web-based banking management system developed using **Java**, **JSP**, and **Servlets**.  
It enables users to securely log in using **Google OAuth 2.0**, manage their bank accounts, and perform transactions online.  
The app runs on **Apache Tomcat Server** and stores data in a **MySQL** database.  
It is built as a **Dynamic Web Project** using **Eclipse IDE**.

## 🚀 Main Features
### 1. Secure Authentication
- Login using **Google OAuth 2.0** for enhanced security.
- Session-based authentication ensures secure access control.
- Supports logout functionality with automatic session invalidation.

### 2. Bank Account Management
- View, link, and manage multiple bank accounts.
- Bank list dynamically fetched using the **BankListServlet**.
- Allows account registration and linking through dedicated JSP pages.

### 3. Transaction Management
- Simulated **Deposit** and **Withdrawal** features.
- Perform secure **money transfers** between linked accounts.
- Validates and logs all transactions for tracking.

### 4. Transaction History & Profile
- Displays a detailed transaction history for each user.
- Allows profile updates and personal information editing.
- Dashboard shows account overview and latest transaction data.

### 5. Admin Module
- Admin login with a separate dashboard.
- Admins can view user data, manage banks, and perform administrative operations.

### 6. User-Friendly Interface
- Responsive and modern design using **Bootstrap**.
- Easy navigation between Home, Profile, MyBanks, and Transaction pages.
- Clean layout with properly linked JSP pages and servlets.

## 🛠 Tech Stack

### Frontend
- **HTML5** and **CSS3** for web structure and styling.  
- **JSP (Java Server Pages)** for generating dynamic content.  
- **Bootstrap** for a responsive and user-friendly interface.

### Backend
- **Java Servlets** handle business logic and backend processing.  
- **JSP** integrated with Servlets for dynamic page rendering.  
- **Session Handling** for user authentication and state management.

### Authentication
- **Google OAuth 2.0** used for secure login through Google accounts.  
- **GoogleCallbackServlet** and **GoogleLoginServlet** handle OAuth flow and token verification.

### Database
- **MySQL** database stores user details, bank accounts, and transactions.  
- JDBC used to connect Servlets with MySQL for CRUD operations.  
- Database tables manage users, admins, accounts, and transaction logs.

### Server
- **Apache Tomcat 9.0** acts as the web server for deployment and testing.

### Tools & Build
- **Eclipse IDE** for development as a **Dynamic Web Project**.  
- **Manual Build / WAR Export** used for deploying to Tomcat.

## 📁 Folder Structure
MiniBankApp/
│
├── src/
│ └── main/
│ ├── java/
│ │ └── com/
│ │ └── bankapp/
│ │ └── servlet/
│ │ ├── BankListServlet.java
│ │ ├── GoogleCallbackServlet.java
│ │ ├── GoogleLoginServlet.java
│ │ └── StartBankLinkServlet.java
│ │
│ └── webapp/
│ ├── Images/
│ ├── META-INF/
│ ├── WEB-INF/
│ │ └── web.xml
│ ├── AdminDashboard.jsp
│ ├── AdminLogin.jsp
│ ├── AdminLogOut.jsp
│ ├── AdminProfile.jsp
│ ├── BankLogin.jsp
│ ├── BankRegister.jsp
│ ├── Connect.jsp
│ ├── ForgetPass.jsp
│ ├── Home.jsp
│ ├── index.jsp
│ ├── LinkAcc.jsp
│ ├── Login.jsp
│ ├── LogOut.jsp
│ ├── MyBanks.jsp
│ ├── Privacy.jsp
│ ├── Profile.jsp
│ ├── Register.jsp
│ ├── SelectBank.jsp
│ ├── Transaction.jsp
│ ├── Transfer.jsp
│ ├── TransferProcess.jsp
│ └── UpdateProfile.jsp
│
└── Servers/
└── Apache Tomcat


## ⚡ How It Works
1. User visits the **Login.jsp** page and signs in using **Google OAuth**.  
2. On successful login, the **GoogleCallbackServlet** verifies and fetches user details.  
3. The user is redirected to the **Home.jsp** or **Dashboard** page.  
4. The app loads linked bank accounts using **BankListServlet**.  
5. The user can perform transactions such as deposit, transfer, or withdrawal.  
6. Transaction history and profile updates are managed through JSP pages and backend Servlets.
