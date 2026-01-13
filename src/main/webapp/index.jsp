<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.flightease.model.User"%>

<%
    User user = (User) session.getAttribute("user");
    String halaman = request.getParameter("halaman");

    if (user == null) {
%>
        <jsp:include page="landing.jsp" />
<%
    } else {
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Dashboard - FlightEase</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
</head>
<body>

<%-- ================= ADMIN ================= --%>
<% if ("admin".equals(user.getRole())) { %>

<div class="d-flex">
    <div style="width:280px">
        <jsp:include page="sidebar.jsp"/>
    </div>

    <div class="flex-grow-1 p-4">

        <% if (halaman == null || halaman.equals("home")) { %>
            <jsp:include page="admin_home.jsp"/>
        <% } else if (halaman.equals("kelola_users")) { %>
            <jsp:include page="admin_users.jsp"/>
        <% } else if (halaman.equals("kelola_airports")) { %>
            <jsp:include page="admin_airports.jsp"/>
        <% } else if (halaman.equals("edit_airport")) { %>
            <jsp:include page="edit_airport.jsp"/>
        <% } else if (halaman.equals("kelola_flights")) { %>
            <jsp:include page="admin_flights.jsp"/>
        <% } else if (halaman.equals("edit_flight")) { %>
            <jsp:include page="edit_flight.jsp"/>
        <% } else if (halaman.equals("laporan_bookings")) { %>
            <jsp:include page="admin_bookings.jsp"/>
        <% } else if (halaman.equals("database_schema")) { %>
            <jsp:include page="admin_database.jsp"/>
        <% } %>

    </div>
</div>

<%-- ================= USER ================= --%>
<% } else { %>

<jsp:include page="navbar.jsp"/>

<div class="container mt-4">

    <% if (halaman == null || halaman.equals("home")) { %>
        <jsp:include page="home.jsp"/>
    <% } else if (halaman.equals("cari_hasil")) { %>
        <jsp:include page="hasil_pencarian.jsp"/>
    <% } else if (halaman.equals("booking")) { %>
        <jsp:include page="booking.jsp"/>
    <% } else if (halaman.equals("riwayat")) { %>
        <jsp:include page="riwayat.jsp"/>
    <% } else if (halaman.equals("ticket")) {

        String idStr = request.getParameter("id");
        if (idStr != null) {
            com.flightease.dao.BookingDAO bDao = new com.flightease.dao.BookingDAO();
            com.flightease.model.Booking tiket =
                    bDao.getBookingById(Integer.parseInt(idStr));
            request.setAttribute("ticketDetail", tiket);
        }
    %>
        <jsp:include page="ticket.jsp"/>
    <% } %>

</div>

<% } %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%
    }
%>
