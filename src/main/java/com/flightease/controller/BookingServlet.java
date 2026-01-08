package com.flightease.controller;

import com.flightease.dao.BookingDAO;
import com.flightease.dao.FlightDAO;
import com.flightease.model.Booking;
import com.flightease.model.Flight;
import com.flightease.model.Passenger;
import com.flightease.model.User;
import java.io.IOException;
import java.sql.Timestamp;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// PENTING: Nama dan URL Pattern harus "BookingServlet" agar terbaca oleh booking.jsp
@WebServlet(name = "BookingServlet", urlPatterns = {"/BookingServlet"})
public class BookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Cek User Login
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Jika session habis/belum login, lempar ke login
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // 2. Tangkap Data dari Form (booking.jsp)
            // Pastikan "name" di input HTML sama dengan parameter di sini
            String flightIdStr = request.getParameter("flight_id");
            String title = request.getParameter("title");             // Tuan/Nyonya
            String passengerName = request.getParameter("passenger_name"); // Nama Penumpang

            // Validasi sederhana
            if (flightIdStr == null || passengerName == null) {
                response.sendRedirect("index.jsp");
                return;
            }

            int flightId = Integer.parseInt(flightIdStr);

            // 3. Ambil Data Penerbangan (Untuk dapat harganya)
            FlightDAO fDao = new FlightDAO();
            Flight flight = fDao.getFlightById(flightId);
            
            if (flight == null) {
                response.sendRedirect("index.jsp");
                return;
            }

            // 4. Siapkan Objek BOOKING (Tabel bookings)
            Booking booking = new Booking();
            booking.setUserId(user.getId());                // ID User yang sedang login
            booking.setFlightId(flightId);                  // ID Penerbangan
            booking.setTotalPrice(flight.getPrice());       // Harga Tiket
            booking.setBookingDate(new Timestamp(System.currentTimeMillis())); // Waktu Sekarang
            booking.setStatus("confirmed");                 // Status langsung OK

            // 5. Siapkan Objek PASSENGER (Tabel passengers)
            Passenger passenger = new Passenger();
            passenger.setName(passengerName);
            passenger.setTitle(title);

            // 6. Simpan ke Database menggunakan BookingDAO yang baru
            BookingDAO bookingDao = new BookingDAO();
            // Method ini menyimpan ke tabel bookings DAN passengers sekaligus
            boolean sukses = bookingDao.createBooking(booking, passenger); 

            // 7. Redirect sesuai hasil
            if (sukses) {
                // Berhasil -> Ke Halaman Riwayat
                response.sendRedirect("index.jsp?halaman=riwayat&status=sukses");
            } else {
                // Gagal -> Balik ke Home dengan pesan error
                response.sendRedirect("index.jsp?halaman=home&status=gagal_booking");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?status=error_server");
        }
    }
}