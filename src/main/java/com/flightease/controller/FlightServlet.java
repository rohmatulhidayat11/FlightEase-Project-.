package com.flightease.controller;

import com.flightease.dao.FlightDAO;
import com.flightease.model.Flight;
import java.io.IOException;
import java.sql.Timestamp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "FlightServlet", urlPatterns = {"/FlightServlet"})
public class FlightServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        FlightDAO dao = new FlightDAO();

        try {
            if ("add".equals(action)) {
                // LOGIKA TAMBAH
                String no = request.getParameter("flight_number");
                int originId = Integer.parseInt(request.getParameter("origin_id"));
                int destId = Integer.parseInt(request.getParameter("destination_id"));
                double price = Double.parseDouble(request.getParameter("price"));
                
                String dateStr = request.getParameter("departure_time");
                if (dateStr != null && !dateStr.isEmpty()) {
                    String cleanDate = dateStr.replace("T", " ");
                    if (cleanDate.length() == 16) cleanDate += ":00";

                    Flight f = new Flight();
                    f.setFlightNumber(no);
                    f.setDepartureTime(Timestamp.valueOf(cleanDate));
                    f.setPrice(price);
                    
                    if(dao.addFlight(f, originId, destId)){
                        response.sendRedirect("index.jsp?halaman=kelola_flights&status=sukses_tambah");
                    } else {
                        response.sendRedirect("index.jsp?halaman=kelola_flights&status=gagal");
                    }
                }

            } else if ("delete".equals(action)) {
                // LOGIKA HAPUS (DIPERBAIKI)
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    boolean sukses = dao.deleteFlight(id);
                    
                    if (sukses) {
                        response.sendRedirect("index.jsp?halaman=kelola_flights&status=sukses_hapus");
                    } else {
                        // Gagal karena sudah ada yang booking
                        response.sendRedirect("index.jsp?halaman=kelola_flights&status=gagal_hapus_fk");
                    }
                } catch (NumberFormatException e) {
                    response.sendRedirect("index.jsp?halaman=kelola_flights&status=error");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?halaman=kelola_flights&status=error");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}