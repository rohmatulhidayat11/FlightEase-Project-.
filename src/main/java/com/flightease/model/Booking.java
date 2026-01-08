package com.flightease.model;
import java.sql.Timestamp;

public class Booking {
    private int id;
    private int userId;
    private int flightId;
    private Timestamp bookingDate;
    private double totalPrice;
    private String status;
    
    // Tambahan untuk join tabel (biar enak nampilin di riwayat)
    private Flight flight; 

    // Getter Setter Standar
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
}