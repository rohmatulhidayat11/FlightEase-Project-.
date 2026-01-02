/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.flightease.controller;

import com.flightease.dao.BookingDAO;
import com.flightease.dao.FlightDAO;
import com.flightease.model.Flight;
import com.flightease.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "BookingProcessServlet", urlPatterns = {"/BookingProcessServlet"})
public class BookingProcessServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Ambil User dari Session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Ambil Data Form
        int flightId = Integer.parseInt(request.getParameter("flight_id"));
        String pName = request.getParameter("passenger_name");
        String pIdentity = request.getParameter("identity_number");

        // 3. Ambil Harga Tiket (Biar aman, ambil dari DB lagi, jangan dari hidden form)
        FlightDAO fDao = new FlightDAO();
        Flight f = fDao.getFlightById(flightId);
        double totalPrice = f.getPrice(); // Asumsi 1 penumpang dulu

        // 4. Simpan ke Database
        BookingDAO bookingDao = new BookingDAO();
        boolean sukses = bookingDao.simpanPemesanan(user.getId(), flightId, totalPrice, pName, pIdentity);

        if (sukses) {
            // Redirect ke halaman sukses / riwayat
            response.sendRedirect("index.jsp?halaman=riwayat&status=sukses");
        } else {
            response.sendRedirect("index.jsp?halaman=booking_form&flight_id=" + flightId + "&error=gagal");
        }
    }
}
