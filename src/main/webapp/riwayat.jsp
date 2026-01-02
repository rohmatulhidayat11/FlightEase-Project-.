<%-- 
    Document   : riwayat
    Created on : 25 Dec 2025, 17.36.58
    Author     : user
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.flightease.model.Booking"%>
<%@page import="java.util.List"%>
<%
    List<Booking> history = (List<Booking>) request.getAttribute("listHistory");
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, HH:mm");
%>

<div class="card shadow border-0">
    <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
        <h5 class="mb-0 fw-bold text-primary"><i class="bi bi-clock-history"></i> Riwayat Transaksi</h5>
        <span class="badge bg-primary rounded-pill"><%= (history != null) ? history.size() : 0%> Pesanan</span>
    </div>

    <div class="card-body p-0">
        <% if (history == null || history.isEmpty()) { %>
        <div class="text-center py-5">
            <i class="bi bi-receipt-cutoff display-1 text-muted"></i>
            <h5 class="mt-3 text-muted">Belum ada riwayat pesanan.</h5>
            <a href="index.jsp" class="btn btn-outline-primary mt-2">Pesan Tiket Sekarang</a>
        </div>
        <% } else { %>
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="bg-light text-secondary">
                    <tr>
                        <th class="ps-4">ID Booking</th>
                        <th>Tanggal Pesan</th>
                        <th>Detail Penerbangan</th>
                        <th>Penumpang</th>
                        <th>Total Bayar</th>
                        <th class="text-center">Status</th>
                        <th class="text-center">Aksi</th> </tr>
                </thead>
                <tbody>
                    <% for (Booking b : history) {%>
                    <tr>
                        <td class="ps-4 fw-bold text-primary">#<%= b.getId()%></td>
                        <td>
                            <small class="text-muted"><%= sdf.format(b.getBookingDate())%></small>
                        </td>
                        <td>
                            <div class="fw-bold"><%= b.getFlight().getFlightNumber()%></div>
                            <small>
                                <%= b.getFlight().getOrigin().getCity()%> 
                                <i class="bi bi-arrow-right-short text-primary"></i> 
                                <%= b.getFlight().getDestination().getCity()%>
                            </small>
                            <br>
                            <small class="text-muted fst-italic">
                                Berangkat: <%= sdf.format(b.getFlight().getDepartureTime())%>
                            </small>
                        </td>
                        <td>
                            <i class="bi bi-person"></i> <%= b.getPassengerName()%>
                        </td>
                        <td class="fw-bold text-success">
                            <%= b.getFormattedPrice()%>
                        </td>
                        <td class="text-center">
                            <span class="badge bg-success">LUNAS</span>
                        </td>
                        <td class="text-center">
                            <a href="index.jsp?halaman=ticket&id=<%= b.getId()%>" class="btn btn-sm btn-outline-primary fw-bold rounded-pill">
                                <i class="bi bi-qr-code"></i> E-Tiket
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