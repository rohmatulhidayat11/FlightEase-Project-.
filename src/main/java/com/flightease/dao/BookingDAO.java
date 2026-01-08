package com.flightease.dao;

import com.flightease.config.KoneksiDB;
import com.flightease.model.Booking;
import com.flightease.model.Passenger;
import java.sql.*;

public class BookingDAO {

    // 1. SIMPAN BOOKING & PENUMPANG (TRANSAKSI)
    public boolean createBooking(Booking b, Passenger p) {
        Connection conn = null;
        PreparedStatement psBooking = null;
        PreparedStatement psPassenger = null;
        ResultSet rs = null;

        try {
            conn = KoneksiDB.getConnection();
            // Matikan auto-commit agar data tersimpan sekaligus (Atomicity)
            conn.setAutoCommit(false);

            // A. INSERT KE TABEL BOOKINGS
            String sqlBooking = "INSERT INTO bookings (user_id, flight_id, booking_date, total_price, status) VALUES (?, ?, ?, ?, ?)";
            // RETURN_GENERATED_KEYS penting untuk mengambil ID booking yang baru dibuat
            psBooking = conn.prepareStatement(sqlBooking, Statement.RETURN_GENERATED_KEYS);
            
            psBooking.setInt(1, b.getUserId());
            psBooking.setInt(2, b.getFlightId());
            psBooking.setTimestamp(3, b.getBookingDate());
            psBooking.setDouble(4, b.getTotalPrice());
            psBooking.setString(5, b.getStatus());
            
            int affectedRows = psBooking.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Gagal menyimpan booking.");
            }

            // Ambil ID Booking yang baru saja terbentuk
            int bookingId = 0;
            rs = psBooking.getGeneratedKeys();
            if (rs.next()) {
                bookingId = rs.getInt(1); // ID Booking
            } else {
                throw new SQLException("Gagal mengambil ID booking.");
            }

            // B. INSERT KE TABEL PASSENGERS
            String sqlPassenger = "INSERT INTO passengers (booking_id, name, title) VALUES (?, ?, ?)";
            psPassenger = conn.prepareStatement(sqlPassenger);
            psPassenger.setInt(1, bookingId);
            psPassenger.setString(2, p.getName());
            psPassenger.setString(3, p.getTitle());
            psPassenger.executeUpdate();

            // C. COMMIT TRANSAKSI
            conn.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback(); // Batalkan semua jika error
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            // Tutup resource manual karena pakai transaction
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (psBooking != null) psBooking.close(); } catch (Exception e) {}
            try { if (psPassenger != null) psPassenger.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
    // Method Tambahan: AMBIL RIWAYAT BOOKING BERDASARKAN USER
    public java.util.List<Booking> getBookingsByUserId(int userId) {
        java.util.List<Booking> list = new java.util.ArrayList<>();
        // Kita JOIN dengan tabel flights dan airports supaya datanya lengkap
        String sql = "SELECT b.*, f.flight_number, f.departure_time, "
                   + "ao.code AS origin_code, ad.code AS dest_code "
                   + "FROM bookings b "
                   + "JOIN flights f ON b.flight_id = f.id "
                   + "JOIN airports ao ON f.origin_id = ao.id "
                   + "JOIN airports ad ON f.destination_id = ad.id "
                   + "WHERE b.user_id = ? ORDER BY b.booking_date DESC";

        try (java.sql.Connection conn = KoneksiDB.getConnection();
             java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            java.sql.ResultSet rs = ps.executeQuery();
            
            while(rs.next()) {
                Booking b = new Booking();
                b.setId(rs.getInt("id"));
                b.setBookingDate(rs.getTimestamp("booking_date"));
                b.setTotalPrice(rs.getDouble("total_price"));
                b.setStatus(rs.getString("status"));
                
                // Set Data Flight Ringkas (untuk ditampilkan di tabel)
                com.flightease.model.Flight f = new com.flightease.model.Flight();
                f.setFlightNumber(rs.getString("flight_number"));
                f.setDepartureTime(rs.getTimestamp("departure_time"));
                
                // Set Rute (Asal & Tujuan)
                com.flightease.model.Airport origin = new com.flightease.model.Airport();
                origin.setCode(rs.getString("origin_code"));
                f.setOrigin(origin);
                
                com.flightease.model.Airport dest = new com.flightease.model.Airport();
                dest.setCode(rs.getString("dest_code"));
                f.setDestination(dest);
                
                b.setFlight(f); // Masukkan flight ke booking
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}