<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.flightease.dao.FlightDAO"%>
<%@page import="com.flightease.dao.AirportDAO"%>
<%@page import="com.flightease.model.Flight"%>
<%@page import="com.flightease.model.Airport"%>
<%@page import="java.util.List"%>

<%
    String idStr = request.getParameter("id");
    Flight flight = null;

    if (idStr != null) {
        int id = Integer.parseInt(idStr);
        FlightDAO fDao = new FlightDAO();
        flight = fDao.getFlightById(id);
    }

    if (flight == null) {
%>
    <h3>Data flight tidak ditemukan.</h3>
<%
        return;
    }

    AirportDAO aDao = new AirportDAO();
    List<Airport> airports = aDao.getAllAirports();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Flight</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-4">
    <h4 class="mb-3">Edit Jadwal Penerbangan</h4>

    <form action="FlightServlet" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= flight.getId() %>">

        <div class="mb-2">
            <label class="fw-bold">No. Penerbangan</label>
            <input type="text" name="flight_number"
                   class="form-control"
                   value="<%= flight.getFlightNumber() %>" required>
        </div>

        <div class="mb-2">
            <label class="fw-bold">Dari</label>
            <select name="origin_id" class="form-select" required>
                <% for(Airport a : airports) { %>
                    <option value="<%= a.getId() %>"
                        <%= a.getId() == flight.getOrigin().getId() ? "selected" : "" %>>
                        <%= a.getCity() %> (<%= a.getCode() %>)
                    </option>
                <% } %>
            </select>
        </div>

        <div class="mb-2">
            <label class="fw-bold">Ke</label>
            <select name="destination_id" class="form-select" required>
                <% for(Airport a : airports) { %>
                    <option value="<%= a.getId() %>"
                        <%= a.getId() == flight.getDestination().getId() ? "selected" : "" %>>
                        <%= a.getCity() %> (<%= a.getCode() %>)
                    </option>
                <% } %>
            </select>
        </div>

        <div class="mb-2">
            <label class="fw-bold">Waktu Berangkat</label>
            <input type="datetime-local"
                   name="departure_time"
                   class="form-control"
                   required>
        </div>

        <div class="mb-3">
