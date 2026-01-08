package com.flightease.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class KoneksiDB {
    
    // Sesuaikan dengan settingan PostgreSQL Anda
    private static final String URL = "jdbc:postgresql://localhost:5432/db_flightease";
    private static final String USER = "postgres"; 
    private static final String PASSWORD = "123";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Koneksi Gagal: " + e.getMessage());
        }
        return conn;
    }
}