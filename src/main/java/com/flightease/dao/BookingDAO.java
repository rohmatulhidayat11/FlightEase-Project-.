/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.flightease.dao;

import com.flightease.config.KoneksiDB;
import java.sql.*;
import com.flightease.model.Booking;
import com.flightease.model.Flight;
import com.flightease.model.Airport;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // Method Simpan Pemesanan
    public boolean simpanPemesanan(int userId, int flightId, double totalPrice, String pName, String pIdentity) {
        boolean sukses = false;
        Connection conn = null;
        PreparedStatement psBooking = null;
        PreparedStatement psPassenger = null;
        ResultSet rs = null;

        try {
            conn = KoneksiDB.getConnection();
            conn.setAutoCommit(false);

            // Insert ke Tabel BOOKINGS
            String sqlBooking = "INSERT INTO bookings (user_id, flight_id, booking_date, total_price) VALUES (?, ?, CURRENT_TIMESTAMP, ?) RETURNING id";
            psBooking = conn.prepareStatement(sqlBooking);
            psBooking.setInt(1, userId);
            psBooking.setInt(2, flightId);
            psBooking.setDouble(3, totalPrice);

            rs = psBooking.executeQuery();

            int bookingId = 0;
            if (rs.next()) {
                bookingId = rs.getInt("id");
            }

            // Insert ke Tabel PASSENGERS
            String sqlPassenger = "INSERT INTO passengers (booking_id, name, identity_number) VALUES (?, ?, ?)";
            psPassenger = conn.prepareStatement(sqlPassenger);
            psPassenger.setInt(1, bookingId);
            psPassenger.setString(2, pName);
            psPassenger.setString(3, pIdentity);
            psPassenger.executeUpdate();

            conn.commit(); // Transaksi sukses
            sukses = true;

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
            }
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
            }
            try {
                if (psBooking != null) {
                    psBooking.close();
                }
            } catch (Exception e) {
            }
            try {
                if (psPassenger != null) {
                    psPassenger.close();
                }
            } catch (Exception e) {
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
            }
        }
        return sukses;
    }

    // Method Ambil Riwayat User
    public List<Booking> getUserHistory(int userId) {
        List<Booking> list = new ArrayList<>();

        String sql = "SELECT b.id, b.booking_date, b.total_price, "
                + "p.name AS passenger_name, "
                + "f.flight_number, f.departure_time, "
                + "ao.city AS origin_city, ao.code AS origin_code, "
                + "ad.city AS dest_city, ad.code AS dest_code "
                + "FROM bookings b "
                + "JOIN flights f ON b.flight_id = f.id "
                + "JOIN airports ao ON f.origin_id = ao.id "
                + "JOIN airports ad ON f.destination_id = ad.id "
                + "JOIN passengers p ON b.id = p.booking_id "
                + "WHERE b.user_id = ? "
                + "ORDER BY b.booking_date DESC";

        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Booking b = new Booking();
                b.setId(rs.getInt("id"));
                b.setBookingDate(rs.getTimestamp("booking_date"));
                b.setTotalPrice(rs.getDouble("total_price"));
                b.setPassengerName(rs.getString("passenger_name"));

                Flight f = new Flight();
                f.setFlightNumber(rs.getString("flight_number"));
                f.setDepartureTime(rs.getTimestamp("departure_time"));

                Airport origin = new Airport();
                origin.setCity(rs.getString("origin_city"));
                origin.setCode(rs.getString("origin_code"));
                f.setOrigin(origin);

                Airport dest = new Airport();
                dest.setCity(rs.getString("dest_city"));
                dest.setCode(rs.getString("dest_code"));
                f.setDestination(dest);

                b.setFlight(f);
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Method Ambil Detail Booking (Untuk Tiket)
    public Booking getBookingById(int bookingId) {
        Booking b = null;
        String sql = "SELECT b.id, b.booking_date, b.total_price, "
                + "p.name AS passenger_name, p.identity_number, "
                + "f.flight_number, f.departure_time, "
                + "ao.city AS origin_city, ao.code AS origin_code, ao.name AS origin_name, "
                + "ad.city AS dest_city, ad.code AS dest_code, ad.name AS dest_name "
                + "FROM bookings b "
                + "JOIN flights f ON b.flight_id = f.id "
                + "JOIN airports ao ON f.origin_id = ao.id "
                + "JOIN airports ad ON f.destination_id = ad.id "
                + "JOIN passengers p ON b.id = p.booking_id "
                + "WHERE b.id = ?";

        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                b = new Booking();
                b.setId(rs.getInt("id"));
                b.setBookingDate(rs.getTimestamp("booking_date"));
                b.setPassengerName(rs.getString("passenger_name"));

                Flight f = new Flight();
                f.setFlightNumber(rs.getString("flight_number"));
                f.setDepartureTime(rs.getTimestamp("departure_time"));

                Airport origin = new Airport();
                origin.setCity(rs.getString("origin_city"));
                origin.setCode(rs.getString("origin_code"));
                origin.setName(rs.getString("origin_name"));
                f.setOrigin(origin);

                Airport dest = new Airport();
                dest.setCity(rs.getString("dest_city"));
                dest.setCode(rs.getString("dest_code"));
                dest.setName(rs.getString("dest_name"));
                f.setDestination(dest);

                b.setFlight(f);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return b;
    }
    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.id, b.booking_date, b.total_price, "
                + "u.username, "
                + // Tambah ambil username
                "p.name AS passenger_name, "
                + "f.flight_number, f.departure_time, "
                + "ao.city AS origin_city, ad.city AS dest_city "
                + "FROM bookings b "
                + "JOIN users u ON b.user_id = u.id "
                + // Join ke Users
                "JOIN flights f ON b.flight_id = f.id "
                + "JOIN airports ao ON f.origin_id = ao.id "
                + "JOIN airports ad ON f.destination_id = ad.id "
                + "JOIN passengers p ON b.id = p.booking_id "
                + "ORDER BY b.booking_date DESC";

        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Booking b = new Booking();
                b.setId(rs.getInt("id"));
                b.setBookingDate(rs.getTimestamp("booking_date"));
                b.setTotalPrice(rs.getDouble("total_price"));
                b.setPassengerName(rs.getString("passenger_name") + " (Akun: " + rs.getString("username") + ")");

                Flight f = new Flight();
                f.setFlightNumber(rs.getString("flight_number"));
                f.setDepartureTime(rs.getTimestamp("departure_time"));

                Airport origin = new Airport();
                origin.setCity(rs.getString("origin_city"));
                f.setOrigin(origin);

                Airport dest = new Airport();
                dest.setCity(rs.getString("dest_city"));
                f.setDestination(dest);

                b.setFlight(f);
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
} 
