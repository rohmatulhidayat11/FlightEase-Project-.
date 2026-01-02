/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.flightease.controller;

import com.flightease.dao.UserDAO;
import com.flightease.model.User;
import java.io.IOException;

// PERHATIKAN: Ganti 'javax' menjadi 'jakarta'
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Ambil data dari form login.jsp
        String u = request.getParameter("username");
        String p = request.getParameter("password");

        // 2. Panggil DAO untuk cek ke database
        UserDAO dao = new UserDAO();
        User user = dao.cekLogin(u, p);

        // 3. Logika Redirect
        if (user != null) {
            // LOGIN SUKSES: Simpan data user di Session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Redirect ke halaman dashboard (nanti kita buat)
            response.sendRedirect("index.jsp");
        } else {
            // LOGIN GAGAL: Balikin ke login.jsp
            response.sendRedirect("login.jsp?status=gagal");
        }
    }
}
