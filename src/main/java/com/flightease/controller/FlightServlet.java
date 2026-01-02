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
                // --- LOGIKA TAMBAH JADWAL ---
                String no = request.getParameter("flight_number");
                int origin = Integer.parseInt(request.getParameter("origin_id"));
                int dest = Integer.parseInt(request.getParameter("destination_id"));
                double price = Double.parseDouble(request.getParameter("price"));

                // --- PERBAIKAN FORMAT TANGGAL ---
                String dateStr = request.getParameter("departure_time"); // Dapatnya: "2026-01-01T13:54"

                // Cek apakah user mengisi tanggal atau kosong
                if (dateStr != null && !dateStr.isEmpty()) {
                    // Ubah "T" jadi spasi
                    String cleanDate = dateStr.replace("T", " ");

                    // Jika detiknya tidak ada, tambahkan ":00"
                    if (cleanDate.length() == 16) {
                        cleanDate += ":00";
                    }

                    Flight f = new Flight();
                    f.setFlightNumber(no);
                    f.setDepartureTime(Timestamp.valueOf(cleanDate)); // Masukkan Timestamp yang sudah bersih
                    f.setPrice(price);

                    dao.addFlight(f, origin, dest);
                } else {
                    System.out.println("Error: Tanggal kosong!");
                }

            } else if (action != null && action.equals("delete")) {
                // --- LOGIKA HAPUS JADWAL ---
                String idStr = request.getParameter("id");
                if (idStr != null) {
                    int id = Integer.parseInt(idStr);
                    dao.deleteFlight(id);
                }
            }
        } catch (Exception e) {
            // Jika ada error, print ke Output Netbeans biar ketahuan kenapa
            e.printStackTrace();
        }

        // Balik lagi ke halaman Admin Flights
        response.sendRedirect("index.jsp?halaman=kelola_flights");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
