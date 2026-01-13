package com.flightease.dao;

import com.flightease.config.KoneksiDB;
import com.flightease.model.Airport;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AirportDAO {

    public List<Airport> getAllAirports() {
        List<Airport> list = new ArrayList<>();
        String sql = "SELECT * FROM airports ORDER BY city ASC";
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Airport a = new Airport();
                a.setId(rs.getInt("id"));
                a.setCode(rs.getString("code"));
                a.setName(rs.getString("name"));
                a.setCity(rs.getString("city"));
                list.add(a);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean addAirport(Airport a) {
        String sql = "INSERT INTO airports (code, name, city) VALUES (?, ?, ?)";
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, a.getCode());
            ps.setString(2, a.getName());
            ps.setString(3, a.getCity());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Airport getAirportById(int id) {
        Airport a = null;
        String sql = "SELECT * FROM airports WHERE id = ?";

        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                a = new Airport();
                a.setId(rs.getInt("id"));
                a.setCode(rs.getString("code"));
                a.setName(rs.getString("name"));
                a.setCity(rs.getString("city"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }

    public boolean deleteAirport(int id) {
        String sql = "DELETE FROM airports WHERE id = ?";
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ===== METHOD UPDATE (YANG BARU) =====
    public boolean updateAirport(Airport a) {
        String sql = "UPDATE airports SET code=?, name=?, city=? WHERE id=?";
        try (Connection conn = KoneksiDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, a.getCode());
            ps.setString(2, a.getName());
            ps.setString(3, a.getCity());
            ps.setInt(4, a.getId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
