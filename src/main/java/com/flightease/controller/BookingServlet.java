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

@WebServlet(name = "BookingServlet", urlPatterns = {"/BookingServlet"})
public class BookingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String flightIdStr = request.getParameter("flight_id");
            String title = request.getParameter("title");
            String passengerName = request.getParameter("passenger_name");

            if (flightIdStr == null || passengerName == null) {
                response.sendRedirect("index.jsp");
                return;
            }

            int flightId = Integer.parseInt(flightIdStr);
            FlightDAO fDao = new FlightDAO();
            Flight flight = fDao.getFlightById(flightId);
            
            if (flight == null) {
                response.sendRedirect("index.jsp");
                return;
            }

            // Set Data Booking
            Booking booking = new Booking();
            booking.setUserId(user.getId());
            booking.setFlightId(flightId);
            booking.setTotalPrice(flight.getPrice());
            booking.setBookingDate(new Timestamp(System.currentTimeMillis()));
            booking.setStatus("confirmed");

            // Set Data Penumpang
            Passenger passenger = new Passenger();
            passenger.setName(passengerName);
            passenger.setTitle(title);

            // Simpan
            BookingDAO bookingDao = new BookingDAO();
            boolean sukses = bookingDao.createBooking(booking, passenger); 

            if (sukses) {
                response.sendRedirect("index.jsp?halaman=riwayat&status=sukses");
            } else {
                response.sendRedirect("index.jsp?halaman=home&status=gagal_booking");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?status=error_server");
        }
    }
}