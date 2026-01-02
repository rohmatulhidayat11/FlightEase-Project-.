<%-- 
    Document   : sidebar
    Created on : 25 Dec 2025, 16.01.24
    Author     : user
--%>

<%@page import="com.flightease.model.User"%>
<%
    User userSide = (User) session.getAttribute("user");
    String userRole = (userSide != null) ? userSide.getRole() : "";
%>

<div class="card shadow-sm border-0 mb-3 text-center">
    <div class="card-body bg-light">
        <i class="bi bi-person-circle display-4 text-secondary"></i>
        <h5 class="mt-2 mb-0"><%= (userSide != null) ? userSide.getUsername() : "Tamu"%></h5>
        <small class="text-muted"><%= userRole.toUpperCase()%></small>
    </div>
</div>

<div class="card shadow-sm border-0">
    <div class="card-header bg-custom-orange fw-bold py-3">
        <i class="bi bi-grid-fill"></i> Menu Utama
    </div>
    <div class="list-group list-group-flush">

        <a href="index.jsp?halaman=home" class="list-group-item list-group-item-action py-3 border-bottom">
            <i class="bi bi-house-door-fill text-primary me-2"></i> Beranda
        </a>

        <% if (userRole.equals("admin")) { %>
        <div class="list-group-item bg-light fw-bold small text-muted text-uppercase mt-2">
            Administrasi (Database)
        </div>

        <a href="index.jsp?halaman=kelola_users" class="list-group-item list-group-item-action py-2">
            <i class="bi bi-people-fill text-dark me-2"></i> Users
        </a>
        <a href="index.jsp?halaman=kelola_airports" class="list-group-item list-group-item-action py-2">
            <i class="bi bi-geo-alt-fill text-danger me-2"></i> Airports
        </a>
        <a href="index.jsp?halaman=kelola_flights" class="list-group-item list-group-item-action py-2">
            <i class="bi bi-airplane-fill text-info me-2"></i> Flights
        </a>
        <a href="index.jsp?halaman=laporan_bookings" class="list-group-item list-group-item-action py-2">
            <i class="bi bi-receipt text-success me-2"></i> Bookings
        </a>
        <% } %>

        <% if (userRole.equals("user")) { %>
        <div class="list-group-item bg-light fw-bold small text-muted text-uppercase mt-2">
            Area Pelanggan
        </div>

        <a href="index.jsp?halaman=home" class="list-group-item list-group-item-action py-2">
            <i class="bi bi-ticket-perforated-fill text-success me-2"></i> Pesan Tiket
        </a>
        <a href="index.jsp?halaman=riwayat" class="list-group-item list-group-item-action py-2">
            <i class="bi bi-clock-history text-warning me-2"></i> Riwayat Transaksi
        </a>
        <% }%>

        <a href="LogoutServlet" class="list-group-item list-group-item-action py-3 text-danger mt-2 border-top">
            <i class="bi bi-box-arrow-left me-2"></i> Logout
        </a>
    </div>
</div>