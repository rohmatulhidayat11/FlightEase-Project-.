/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.flightease.dao;

import com.flightease.config.KoneksiDB;
import com.flightease.model.Airport;
import com.flightease.model.Flight;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FlightDAO {

    // Fungsi Pencarian Penerbangan
    public List<Flight> searchFlights(int originId, int destId, String dateStr) {
        List<Flight> list = new ArrayList<>();
        String sql = "SELECT f.id, f.flight_number, f.departure_time, f.price, "
                + "ao.city AS origin_city, ao.code AS origin_code, "
                + "ad.city AS dest_city, ad.code AS dest_code "
                + "FROM flights f "
                + "JOIN airports ao ON f.origin_id = ao.id "
                + "JOIN airports ad ON f.destination_id = ad.id "
                + "WHERE f.origin_id = ? AND f.destination_id = ? "
                + "AND CAST(f.departure_time AS DATE) = CAST(? AS DATE) "
                + "ORDER BY f.departure_time ASC";

        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, originId);
            ps.setInt(2, destId);
            ps.setString(3, dateStr);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Flight f = new Flight();
                f.setId(rs.getInt("id"));
                f.setFlightNumber(rs.getString("flight_number"));
                f.setDepartureTime(rs.getTimestamp("departure_time"));
                f.setPrice(rs.getDouble("price"));
                Airport origin = new Airport();
                origin.setCity(rs.getString("origin_city"));
                origin.setCode(rs.getString("origin_code"));
                f.setOrigin(origin);
                Airport dest = new Airport();
                dest.setCity(rs.getString("dest_city"));
                dest.setCode(rs.getString("dest_code"));
                f.setDestination(dest);

                list.add(f);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public Flight getFlightById(int id) {
        Flight f = null;
        String sql = "SELECT f.id, f.flight_number, f.departure_time, f.price, "
                + "ao.city AS origin_city, ao.code AS origin_code, "
                + "ad.city AS dest_city, ad.code AS dest_code "
                + "FROM flights f "
                + "JOIN airports ao ON f.origin_id = ao.id "
                + "JOIN airports ad ON f.destination_id = ad.id "
                + "WHERE f.id = ?";

        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                f = new Flight();
                f.setId(rs.getInt("id"));
                f.setFlightNumber(rs.getString("flight_number"));
                f.setDepartureTime(rs.getTimestamp("departure_time"));
                f.setPrice(rs.getDouble("price"));

                Airport origin = new Airport();
                origin.setCity(rs.getString("origin_city"));
                origin.setCode(rs.getString("origin_code"));
                f.setOrigin(origin);

                Airport dest = new Airport();
                dest.setCity(rs.getString("dest_city"));
                dest.setCode(rs.getString("dest_code"));
                f.setDestination(dest);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    public List<Flight> getAllFlights() {
        List<Flight> list = new ArrayList<>();
        String sql = "SELECT f.id, f.flight_number, f.departure_time, f.price, "
                + "ao.city AS origin_city, ao.code AS origin_code, "
                + "ad.city AS dest_city, ad.code AS dest_code "
                + "FROM flights f "
                + "JOIN airports ao ON f.origin_id = ao.id "
                + "JOIN airports ad ON f.destination_id = ad.id "
                + "ORDER BY f.departure_time DESC";

        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Flight f = new Flight();
                f.setId(rs.getInt("id"));
                f.setFlightNumber(rs.getString("flight_number"));
                f.setDepartureTime(rs.getTimestamp("departure_time"));
                f.setPrice(rs.getDouble("price"));

                Airport origin = new Airport();
                origin.setCity(rs.getString("origin_city"));
                origin.setCode(rs.getString("origin_code"));
                f.setOrigin(origin);

                Airport dest = new Airport();
                dest.setCity(rs.getString("dest_city"));
                dest.setCode(rs.getString("dest_code"));
                f.setDestination(dest);

                list.add(f);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public boolean addFlight(Flight f, int originId, int destId) {
        String sql = "INSERT INTO flights (flight_number, origin_id, destination_id, departure_time, price) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, f.getFlightNumber());
            ps.setInt(2, originId);
            ps.setInt(3, destId);
            ps.setTimestamp(4, f.getDepartureTime());
            ps.setDouble(5, f.getPrice());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean deleteFlight(int id) {
        String sql = "DELETE FROM flights WHERE id = ?";
        try (Connection conn = KoneksiDB.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    } 
}
