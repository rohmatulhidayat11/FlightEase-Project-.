<%-- 
    Document   : booking
    Created on : 25 Dec 2025, 17.25.15
    Author     : user
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.flightease.model.Flight"%>
<%
    Flight f = (Flight) request.getAttribute("flightDetail");
    if (f == null) {
        response.sendRedirect("index.jsp"); 
        return;
    }
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy, HH:mm");
%>

<div class="row">
    <div class="col-md-4">
        <div class="card shadow-sm border-0 mb-3">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0"><i class="bi bi-ticket-perforated"></i> Detail Penerbangan</h5>
            </div>
            <div class="card-body">
                <h3 class="text-primary fw-bold"><%= f.getFlightNumber()%></h3>
                <p class="text-muted mb-4">Economy Class</p>

                <div class="timeline">
                    <div class="mb-3">
                        <small class="text-muted d-block">Berangkat</small>
                        <strong><%= f.getOrigin().getCity()%> (<%= f.getOrigin().getCode()%>)</strong>
                        <div class="text-success"><%= sdf.format(f.getDepartureTime())%></div>
                    </div>
                    <div class="mb-3">
                        <i class="bi bi-arrow-down text-secondary"></i>
                    </div>
                    <div>
                        <small class="text-muted d-block">Tiba</small>
                        <strong><%= f.getDestination().getCity()%> (<%= f.getDestination().getCode()%>)</strong>
                    </div>
                </div>

                <hr>
                <div class="d-flex justify-content-between align-items-center">
                    <span>Total Harga:</span>
                    <h4 class="text-danger fw-bold m-0"><%= f.getFormattedPrice()%></h4>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-8">
        <div class="card shadow border-0">
            <div class="card-header bg-white py-3">
                <h5 class="mb-0 text-dark">Data Penumpang</h5>
            </div>
            <div class="card-body p-4">
                <form action="BookingProcessServlet" method="POST">
                    <input type="hidden" name="flight_id" value="<%= f.getId()%>">

                    <div class="mb-3">
                        <label class="form-label">Nama Lengkap (Sesuai KTP)</label>
                        <input type="text" name="passenger_name" class="form-control" required placeholder="Contoh: Budi Santoso">
                    </div>

                    <div class="mb-4">
                        <label class="form-label">Nomor Identitas (NIK / Paspor)</label>
                        <input type="text" name="identity_number" class="form-control" required placeholder="Contoh: 3201123456789000">
                    </div>

                    <div class="alert alert-info small">
                        <i class="bi bi-info-circle-fill"></i> Pastikan data yang Anda masukkan benar. Tiket elektronik akan diterbitkan setelah pembayaran.
                    </div>

                    <div class="d-flex justify-content-end">
                        <a href="index.jsp" class="btn btn-secondary me-2">Batal</a>
                        <button type="submit" class="btn btn-success fw-bold px-4">
                            KONFIRMASI & PESAN <i class="bi bi-check-lg"></i>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>