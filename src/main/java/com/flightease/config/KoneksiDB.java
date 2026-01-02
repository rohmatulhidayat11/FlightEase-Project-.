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
            String url = "jdbc:postgresql://localhost:5432/db_flightease";
            String user = "postgres";
            String pass = "123"; 

            conn = DriverManager.getConnection(url, user, pass);
        } catch (Exception e) {
            System.out.println("Koneksi Error: " + e.getMessage());
        }
        return conn;
    }
    public static void main(String[] args) {
        if (getConnection() != null) {
            System.out.println("Koneksi Berhasil!");
        }
    }
}
