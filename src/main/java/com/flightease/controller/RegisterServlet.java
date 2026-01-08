package com.flightease.controller;

import com.flightease.dao.UserDAO;
import com.flightease.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String u = request.getParameter("username");
        String p = request.getParameter("password");

        User newUser = new User();
        newUser.setUsername(u);
        newUser.setPassword(p);

        UserDAO dao = new UserDAO();
        if (dao.registerUser(newUser)) {
            response.sendRedirect("login.jsp?status=registered");
        } else {
            response.sendRedirect("register.jsp?status=gagal");
        }
    }
}