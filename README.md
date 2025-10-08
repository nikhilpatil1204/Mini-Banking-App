# Mini Banking App

## Overview
The Mini Banking App is a web-based banking management system built using **Java**, **JSP**, and **Servlets**.  
It allows users to log in securely using Google, view bank details, check balances, and manage transactions.  
The project runs on the **Apache Tomcat Server** and uses **Google OAuth 2.0** for authentication.

## 🚀 Features
- Secure user authentication using **Google Login (OAuth 2.0)**
- Fetch and display bank details dynamically using Servlets
- Deposit and withdrawal simulation
- Transaction history tracking
- JSP-based responsive interface with Bootstrap
- Backend powered by Servlets and Java logic

## 🛠 Tech Stack

| Layer | Technology Used |
|-------|------------------|
| Frontend | HTML, CSS, JSP, Bootstrap |
| Backend | Java, Servlets |
| Authentication | Google OAuth 2.0 |
| Server | Apache Tomcat |
| Database | MySQL / Local Data |
| Build Tool | Manual / Maven (based on setup) |

## 📁 Folder Structure 

MiniBankingApp/
│
├─ src/                # Java source files
│   ├─ main/
│   │   ├─ java/       # Java classes
│   │   └─ webapp/     # JSP, HTML, CSS, JS
│   │       ├─ WEB-INF/
│   │       │   └─ web.xml
│   │       ├─ jsp/
│   │       │   ├─ login.jsp
│   │       │   ├─ dashboard.jsp
│   │       │   └─ ...
│   │       ├─ css/
│   │       ├─ js/
│   │       └─ images/
│
├─ lib/                # Any external libraries (JARs)
├─ build/              # Compiled files (usually ignored in Git)
├─ .gitignore
├─ pom.xml or build.gradle  # If using Maven/Gradle
└─ README.md


