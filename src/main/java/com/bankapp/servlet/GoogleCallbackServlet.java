package com.bankapp.servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.net.*;

/*import com.google.api.client.json.JsonParser;
import com.google.gson.*;*/

import com.google.gson.JsonParser;
import com.google.gson.JsonObject;

@WebServlet("/oauth2callback")
public class GoogleCallbackServlet extends HttpServlet {
    private static final String CLIENT_ID = "850079745940-2bpmimgbcivhrt8vu2csnqn2fda5r6lc.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";
    
    private static final String REDIRECT_URI = "http://localhost:8080/MiniBankApp/oauth2callback";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");

        // Step 1: Exchange code for access token
        String urlParameters = "code=" + code
                + "&client_id=" + CLIENT_ID
                + "&client_secret=" + CLIENT_SECRET
                + "&redirect_uri=" + REDIRECT_URI
                + "&grant_type=authorization_code";

        URL url = new URL("https://oauth2.googleapis.com/token");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setDoOutput(true);
        conn.setRequestMethod("POST");
        conn.getOutputStream().write(urlParameters.getBytes());

        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine;
        StringBuffer resp = new StringBuffer();
        while ((inputLine = in.readLine()) != null) {
            resp.append(inputLine);
        }
        in.close();

        JsonObject json = JsonParser.parseString(resp.toString()).getAsJsonObject();
        String accessToken = json.get("access_token").getAsString();

        // Step 2: Use token to fetch user info
        URL userInfoUrl = new URL("https://www.googleapis.com/oauth2/v2/userinfo?access_token=" + accessToken);
        HttpURLConnection userInfoConn = (HttpURLConnection) userInfoUrl.openConnection();
        BufferedReader userIn = new BufferedReader(new InputStreamReader(userInfoConn.getInputStream()));

        String userLine;
        StringBuffer userResp = new StringBuffer();
        while ((userLine = userIn.readLine()) != null) {
            userResp.append(userLine);
        }
        userIn.close();

        JsonObject userJson = JsonParser.parseString(userResp.toString()).getAsJsonObject();
        String email = userJson.get("email").getAsString();
        String name = userJson.get("name").getAsString();

        // Step 3: Store in session and redirect
        HttpSession session = request.getSession();
        session.setAttribute("email", email);
        session.setAttribute("name", name);

        response.sendRedirect("Connect.jsp");
    }
}
