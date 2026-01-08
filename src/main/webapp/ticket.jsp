<%-- 
    Document   : ticket
    Created on : 25 Dec 2025, 17.41.09
    Author     : user
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.flightease.model.Booking"%>
<%
    Booking b = (Booking) request.getAttribute("ticketDetail");
    if (b == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    SimpleDateFormat sdfDate = new SimpleDateFormat("dd MMM yyyy");
    SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm");
%>

<link href="https://fonts.googleapis.com/css2?family=Libre+Barcode+39+Text&display=swap" rel="stylesheet">

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="fw-bold text-dark mb-0"><i class="bi bi-ticket-detailed"></i> E-Boarding Pass</h4>
        <a href="index.jsp?halaman=riwayat" class="btn btn-outline-secondary btn-sm"><i class="bi bi-arrow-left"></i> Kembali</a>
    </div>

    <div class="card border-0 shadow-lg overflow-hidden mx-auto" style="max-width: 800px; border-radius: 20px;">

        <div class="card-header bg-primary text-white p-4 d-flex justify-content-between align-items-center" 
             style="background: linear-gradient(45deg, #005c97, #363795);">
            <div>
                <h3 class="mb-0 fst-italic fw-bold"><i class="bi bi-airplane-engines"></i> FlightEase</h3>
                <small>Boarding Pass</small>
            </div>
            <div class="text-end">
                <h2 class="mb-0 fw-bold"><%= b.getFlight().getFlightNumber()%></h2>
                <span class="badge bg-light text-primary fw-bold">ECONOMY CLASS</span>
            </div>
        </div>

        <div class="card-body p-0">
            <div class="row g-0">

                <div class="col-md-8 p-4 border-end border-2 border-dashed">
                    <div class="row mb-4">
                        <div class="col-6">
                            <small class="text-muted text-uppercase">Nama Penumpang</small>
                            <h5 class="fw-bold text-dark"><%= b.getPassengerName().toUpperCase()%></h5>
                        </div>
                        <div class="col-6">
                            <small class="text-muted text-uppercase">Tanggal Penerbangan</small>
                            <h5 class="fw-bold text-dark"><%= sdfDate.format(b.getFlight().getDepartureTime())%></h5>
                        </div>
                    </div>

                    <div class="row align-items-center bg-light p-3 rounded-3 mb-3">
                        <div class="col-4 text-center">
                            <h2 class="fw-bold text-primary display-5 mb-0"><%= b.getFlight().getOrigin().getCode()%></h2>
                            <small class="text-muted"><%= b.getFlight().getOrigin().getCity()%></small>
                        </div>
                        <div class="col-4 text-center">
                            <i class="bi bi-airplane text-secondary fs-2"></i>
                            <hr class="my-1 border-primary">
                            <small class="text-primary fw-bold"><%= sdfTime.format(b.getFlight().getDepartureTime())%></small>
                        </div>
                        <div class="col-4 text-center">
                            <h2 class="fw-bold text-primary display-5 mb-0"><%= b.getFlight().getDestination().getCode()%></h2>
                            <small class="text-muted"><%= b.getFlight().getDestination().getCity()%></small>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <small class="text-muted"><i class="bi bi-geo-alt-fill"></i> Terminal & Gate info will be available at airport.</small>
                        </div>
                    </div>
                </div>

                <div class="col-md-4 p-4 bg-light d-flex flex-column justify-content-center align-items-center text-center">

                    <div class="mb-3 w-100">
                        <small class="text-muted text-uppercase">Seat / Kursi</small>
                        <h1 class="fw-bold text-dark display-4">12F</h1>
                    </div>

                    <div class="mb-3 w-100">
                        <small class="text-muted text-uppercase">Boarding Time</small>
                        <h4 class="fw-bold text-danger">
                            <%= sdfTime.format(new java.util.Date(b.getFlight().getDepartureTime().getTime() - 30 * 60000))%>
                        </h4>
                    </div>

                    <div style="font-family: 'Libre Barcode 39 Text', cursive; font-size: 40px; transform: scaleY(1.5);">
                        *<%= b.getId()%>FB<%= b.getFlight().getFlightNumber().replace("-", "")%>*
                    </div>
                    <small class="text-muted mt-2">Scan this at gate</small>

                </div>
            </div>
        </div>

        <div class="card-footer bg-white text-center py-3 border-top">
            <button onclick="window.print()" class="btn btn-primary fw-bold px-4 rounded-pill shadow-sm">
                <i class="bi bi-printer-fill"></i> CETAK TIKET / SIMPAN PDF
            </button>
        </div>
    </div>
</div>

<style>
    @media print {
        body * {
visibility: hidden;
}
        .card, .card * {
visibility: visible;
}
        .card {
position: absolute;
left: 0;
top: 0;
width: 100%;
margin: 0;
shadow: none !important;
border: 1px solid #000;
}
        .btn {
display: none;
} 
    }
</style>