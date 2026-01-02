/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.flightease.config;

import java.sql.Connection;
import java.sql.DriverManager;

public class KoneksiDB {

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver");
            // Sesuaikan nama database, user, dan password
            String url = "jdbc:postgresql://localhost:5432/db_flightease";
            String user = "postgres";
            String pass = "123"; // GANTI DENGAN PASSWORD ASLI

            conn = DriverManager.getConnection(url, user, pass);
        } catch (Exception e) {
            System.out.println("Koneksi Error: " + e.getMessage());
        }
        return conn;
    }

    // Main method untuk tes koneksi (Klik Kanan -> Run File)
    public static void main(String[] args) {
        if (getConnection() != null) {
            System.out.println("Koneksi Berhasil!");
        }
    }
}
