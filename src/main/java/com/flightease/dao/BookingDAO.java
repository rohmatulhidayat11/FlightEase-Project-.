package com.flightease.dao;

import com.flightease.config.KoneksiDB;
import com.flightease.model.Airport;
import com.flightease.model.Booking;
import com.flightease.model.Flight;
import com.flightease.model.Passenger;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    
    private Booking mapRowToBooking(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setId(rs.getInt("id"));
        b.setUserId(rs.getInt("user_id"));
        b.setFlightId(rs.getInt("flight_id"));
        b.setBookingDate(rs.getTimestamp("booking_date"));
        b.setTotalPrice(rs.getDouble("total_price"));
        b.setStatus(rs.getString("status"));

        // Map Flight
        Flight f = new Flight();
        f.setId(rs.getInt("flight_id")); // ID Flight dari tabel booking
        f.setFlightNumber(rs.getString("flight_number"));
        f.setDepartureTime(rs.getTimestamp("departure_time"));
        // Map Airport Asal
        Airport orig = new Airport();
        orig.setCity(rs.getString("origin_city"));
        orig.setCode(rs.getString("origin_code"));
        f.setOrigin(orig);
        // Map Airport Tujuan
        Airport dest = new Airport();
        dest.setCity(rs.getString("dest_city"));
        dest.setCode(rs.getString("dest_code"));
        f.setDestination(dest);
        b.setFlight(f);

        // Map Passenger (Jika ada kolomnya di query)
        try {
            // Cek apakah kolom passenger_name ada di result set
            String pName = rs.getString("passenger_name");
            if (pName != null) {
                Passenger p = new Passenger();
                p.setName(pName);
                p.setTitle(rs.getString("passenger_title"));
                b.setPassenger(p);
            }
        } catch (SQLException e) {
            
        }

        return b;
    }

    
    public boolean createBooking(Booking b, Passenger p) {
        Connection conn = null;
        PreparedStatement ps1 = null, ps2 = null;
        ResultSet rs = null;
        try {
            conn = KoneksiDB.getConnection();
            conn.setAutoCommit(false); 

            // Insert Booking
            String sql1 = "INSERT INTO bookings (user_id, flight_id, booking_date, total_price, status) VALUES (?, ?, ?, ?, ?)";
            ps1 = conn.prepareStatement(sql1, Statement.RETURN_GENERATED_KEYS);
            ps1.setInt(1, b.getUserId());
            ps1.setInt(2, b.getFlightId());
            ps1.setTimestamp(3, b.getBookingDate());
            ps1.setDouble(4, b.getTotalPrice());
            ps1.setString(5, b.getStatus());
            ps1.executeUpdate();

            rs = ps1.getGeneratedKeys();
            int bookingId = 0;
            if (rs.next()) bookingId = rs.getInt(1);
            else throw new SQLException("Gagal ambil ID Booking");

            // Insert Passenger
            String sql2 = "INSERT INTO passengers (booking_id, name, title) VALUES (?, ?, ?)";
            ps2 = conn.prepareStatement(sql2);
            ps2.setInt(1, bookingId);
            ps2.setString(2, p.getName());
            ps2.setString(3, p.getTitle());
            ps2.executeUpdate();

            conn.commit(); // Simpan
            return true;
        } catch (Exception e) {
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) {}
            e.printStackTrace();
            return false;
        } finally {
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }

    
    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        
        String sql = "SELECT b.*, "
                   + "f.flight_number, f.departure_time, "
                   + "ao.code AS origin_code, ao.city AS origin_city, "
                   + "ad.code AS dest_code, ad.city AS dest_city, "
                   + "p.name AS passenger_name, p.title AS passenger_title "
                   + "FROM bookings b "
                   + "JOIN flights f ON b.flight_id = f.id "
                   + "JOIN airports ao ON f.origin_id = ao.id "
                   + "JOIN airports ad ON f.destination_id = ad.id "
                   + "JOIN passengers p ON b.id = p.booking_id "
                   + "ORDER BY b.booking_date DESC";

        try (Connection conn = KoneksiDB.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRowToBooking(rs));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    
    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, "
                   + "f.flight_number, f.departure_time, "
                   + "ao.code AS origin_code, ao.city AS origin_city, "
                   + "ad.code AS dest_code, ad.city AS dest_city, "
                   + "p.name AS passenger_name, p.title AS passenger_title "
                   + "FROM bookings b "
                   + "JOIN flights f ON b.flight_id = f.id "
                   + "JOIN airports ao ON f.origin_id = ao.id "
                   + "JOIN airports ad ON f.destination_id = ad.id "
                   + "JOIN passengers p ON b.id = p.booking_id "
                   + "WHERE b.user_id = ? ORDER BY b.booking_date DESC";

        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRowToBooking(rs));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    
    public Booking getBookingById(int id) {
        Booking b = null;
        String sql = "SELECT b.*, "
                   + "f.flight_number, f.departure_time, "
                   + "ao.code AS origin_code, ao.city AS origin_city, "
                   + "ad.code AS dest_code, ad.city AS dest_city, "
                   + "p.name AS passenger_name, p.title AS passenger_title "
                   + "FROM bookings b "
                   + "JOIN flights f ON b.flight_id = f.id "
                   + "JOIN airports ao ON f.origin_id = ao.id "
                   + "JOIN airports ad ON f.destination_id = ad.id "
                   + "JOIN passengers p ON b.id = p.booking_id "
                   + "WHERE b.id = ?";

        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                b = mapRowToBooking(rs);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return b;
    }
}