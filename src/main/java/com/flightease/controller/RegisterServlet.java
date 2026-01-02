/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Tangkap inputan dari form
        String u = request.getParameter("username");
        String p = request.getParameter("password");

        // 2. Masukkan ke object User
        User newUser = new User();
        newUser.setUsername(u);
        newUser.setPassword(p);
        // Role tidak perlu di-set dari form, karena di DAO sudah otomatis 'user'

        // 3. Panggil DAO
        UserDAO dao = new UserDAO();
        boolean sukses = dao.registerUser(newUser);

        // 4. Redirect sesuai hasil
        if (sukses) {
            // Jika sukses, lempar ke Login dengan pesan sukses
            response.sendRedirect("login.jsp?status=registered");
        } else {
            // Jika gagal (misal username kembar), balikin ke register
            response.sendRedirect("register.jsp?status=gagal");
        }
    }
}
