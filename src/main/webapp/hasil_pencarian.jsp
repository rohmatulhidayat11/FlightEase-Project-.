<%-- 
    Document   : hasil_pencarian
    Created on : 25 Dec 2025, 16.46.45
    Author     : user
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.flightease.model.Flight"%>
<%@page import="java.util.List"%>
<%
    // Ambil data hasil pencarian yang dikirim dari index.jsp
    List<Flight> results = (List<Flight>) request.getAttribute("daftarPenerbangan");
    SimpleDateFormat sdfJam = new SimpleDateFormat("HH:mm");
    SimpleDateFormat sdfTgl = new SimpleDateFormat("dd MMMM yyyy");
%>

<div class="card shadow border-0 mt-3">
    <div class="card-header bg-white py-3">
        <h5 class="mb-0 fw-bold text-primary"><i class="bi bi-airplane"></i> Hasil Pencarian Penerbangan</h5>
    </div>
    <div class="card-body p-0">

        <% if (results == null || results.isEmpty()) { %>
        <div class="text-center py-5">
            <i class="bi bi-emoji-frown display-1 text-muted"></i>
            <h4 class="mt-3 text-muted">Maaf, penerbangan tidak ditemukan.</h4>
            <p>Coba cari tanggal lain atau rute yang berbeda.</p>
            <a href="index.jsp" class="btn btn-outline-primary">Cari Ulang</a>
        </div>
        <% } else { %>

        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="bg-light">
                    <tr>
                        <th class="ps-4">Maskapai</th>
                        <th>Jadwal</th>
                        <th>Rute</th>
                        <th>Harga /org</th>
                        <th class="text-end pe-4">Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Flight f : results) {%>
                    <tr>
                        <td class="ps-4">
                            <div class="fw-bold text-dark"><%= f.getFlightNumber()%></div>
                            <small class="text-muted">Economy</small>
                        </td>
                        <td>
                            <div class="fw-bold fs-5"><%= sdfJam.format(f.getDepartureTime())%></div>
                            <small class="text-muted"><%= sdfTgl.format(f.getDepartureTime())%></small>
                        </td>
                        <td>
                            <div class="d-flex align-items-center">
                                <span class="fw-bold"><%= f.getOrigin().getCity()%></span>
                                <i class="bi bi-arrow-right mx-2 text-primary"></i>
                                <span class="fw-bold"><%= f.getDestination().getCity()%></span>
                            </div>
                            <small class="text-muted"><%= f.getOrigin().getCode()%> ? <%= f.getDestination().getCode()%></small>
                        </td>
                        <td class="text-danger fw-bold fs-5">
                            <%= f.getFormattedPrice()%>
                        </td>
                        <td class="text-end pe-4">
                            <a href="index.jsp?halaman=booking_form&flight_id=<%= f.getId()%>" class="btn btn-warning text-white fw-bold">
                                Pilih <i class="bi bi-check-circle-fill"></i>
                            </a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        <% }%>
    </div>
</div>
