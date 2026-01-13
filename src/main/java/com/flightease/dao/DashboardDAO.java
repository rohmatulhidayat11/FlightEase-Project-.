package com.flightease.dao;

import com.flightease.config.KoneksiDB;
import java.sql.*;
import java.util.Map;
import java.util.HashMap;
import java.time.Year;

public class DashboardDAO {

    private int getCount(String sql) {
        int count = 0;
        try (Connection conn = KoneksiDB.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return count;
    }

    public int getTotalUsers() { return getCount("SELECT COUNT(*) FROM users"); }
    public int getTotalFlights() { return getCount("SELECT COUNT(*) FROM flights"); }
    public int getTotalBookings() { return getCount("SELECT COUNT(*) FROM bookings"); }

    public double getTotalRevenue() {
        double total = 0;
        try (Connection conn = KoneksiDB.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery("SELECT SUM(total_price) FROM bookings")) {
            if (rs.next()) total = rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return total;
    }

    public Map<Integer, Double> getMonthlyRevenue() {
        Map<Integer, Double> data = new HashMap<>();
        for (int i = 1; i <= 12; i++) data.put(i, 0.0); // Inisialisasi 0

        int currentYear = Year.now().getValue();
        
        String sql = "SELECT EXTRACT(MONTH FROM booking_date) AS bulan, SUM(total_price) AS total "
                   + "FROM bookings WHERE EXTRACT(YEAR FROM booking_date) = ? GROUP BY bulan";

        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, currentYear);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                data.put(rs.getInt("bulan"), rs.getDouble("total"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return data;
    }
}