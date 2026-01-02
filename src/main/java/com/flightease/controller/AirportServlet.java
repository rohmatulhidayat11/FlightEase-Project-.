/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.flightease.controller;

import com.flightease.dao.AirportDAO;
import com.flightease.model.Airport;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AirportServlet", urlPatterns = {"/AirportServlet"})
public class AirportServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        AirportDAO dao = new AirportDAO();

        if (action != null && action.equals("add")) {
            // --- LOGIKA TAMBAH DATA ---
            String code = request.getParameter("code");
            String name = request.getParameter("name");
            String city = request.getParameter("city");

            Airport a = new Airport();
            a.setCode(code);
            a.setName(name);
            a.setCity(city);

            dao.addAirport(a);

        } else if (action != null && action.equals("delete")) {
            // --- LOGIKA HAPUS DATA ---
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteAirport(id);
        }

        // Balik lagi ke halaman Admin Airports
        response.sendRedirect("index.jsp?halaman=kelola_airports");
    }

    // Agar bisa delete lewat link (GET), kita panggil doPost juga
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
