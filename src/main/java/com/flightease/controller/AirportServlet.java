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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        AirportDAO dao = new AirportDAO();

        if ("add".equals(action)) {
            Airport a = new Airport();
            a.setCode(request.getParameter("code"));
            a.setName(request.getParameter("name"));
            a.setCity(request.getParameter("city"));
            dao.addAirport(a);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.deleteAirport(id);
        }
        response.sendRedirect("index.jsp?halaman=kelola_airports");
    }
}