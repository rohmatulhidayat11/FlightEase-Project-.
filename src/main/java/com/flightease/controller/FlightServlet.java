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
            if (action != null && action.equals("add")) {
                // LOGIKA TAMBAH JADWAL
                String no = request.getParameter("flight_number");
                int origin = Integer.parseInt(request.getParameter("origin_id"));
                int dest = Integer.parseInt(request.getParameter("destination_id"));
                double price = Double.parseDouble(request.getParameter("price"));

                // FORMAT TANGGAL
                String dateStr = request.getParameter("departure_time"); 

                if (dateStr != null && !dateStr.isEmpty()) {
                    String cleanDate = dateStr.replace("T", " ");

                    if (cleanDate.length() == 16) {
                        cleanDate += ":00";
                    }

                    Flight f = new Flight();
                    f.setFlightNumber(no);
                    f.setDepartureTime(Timestamp.valueOf(cleanDate)); 
                    f.setPrice(price);

                    dao.addFlight(f, origin, dest);
                } else {
                    System.out.println("Error: Tanggal kosong!");
                }

            } else if (action != null && action.equals("delete")) {
                //LOGIKA HAPUS JADWAL
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    int id = Integer.parseInt(idStr);
                    dao.deleteFlight(id);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("index.jsp?halaman=kelola_flights");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
