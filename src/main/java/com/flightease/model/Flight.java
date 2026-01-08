package com.flightease.model;

import java.sql.Timestamp;

public class Flight {
    private int id;
    private String flightNumber;
    private Airport origin;      // Relasi ke object Airport
    private Airport destination; // Relasi ke object Airport
    private Timestamp departureTime;
    private double price;

    public Flight() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getFlightNumber() { return flightNumber; }
    public void setFlightNumber(String flightNumber) { this.flightNumber = flightNumber; }
    public Airport getOrigin() { return origin; }
    public void setOrigin(Airport origin) { this.origin = origin; }
    public Airport getDestination() { return destination; }
    public void setDestination(Airport destination) { this.destination = destination; }
    public Timestamp getDepartureTime() { return departureTime; }
    public void setDepartureTime(Timestamp departureTime) { this.departureTime = departureTime; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    
    // Helper untuk format harga di JSP
    public String getFormattedPrice() {
        return String.format("Rp %,.0f", price);
    }
}