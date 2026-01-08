package com.flightease.model;
import java.sql.Timestamp;

public class Booking {
    private int id;
    private int userId;
    private int flightId;
    private Timestamp bookingDate;
    private double totalPrice;
    private String status;
    
    // Relasi (Join)
    private Flight flight; 
    private Passenger passenger; // Tambahan untuk menyimpan data penumpang

    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getFlightId() { return flightId; }
    public void setFlightId(int flightId) { this.flightId = flightId; }
    
    public Timestamp getBookingDate() { return bookingDate; }
    public void setBookingDate(Timestamp bookingDate) { this.bookingDate = bookingDate; }
    
    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public Flight getFlight() { return flight; }
    public void setFlight(Flight flight) { this.flight = flight; }

    public Passenger getPassenger() { return passenger; }
    public void setPassenger(Passenger passenger) { this.passenger = passenger; }

    // Helper untuk JSP admin_bookings.jsp
    public String getPassengerName() {
        return (passenger != null) ? passenger.getName() : "Unknown";
    }
    
    public String getFormattedPrice() {
        return String.format("Rp %,.0f", totalPrice);
    }
}