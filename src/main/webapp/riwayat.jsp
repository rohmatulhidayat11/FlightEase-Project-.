<%@page import="com.flightease.dao.BookingDAO"%>
<%@page import="com.flightease.model.Booking"%>
<%@page import="com.flightease.model.User"%>
<%@page import="java.util.List"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
    // Cek Login
    User userRiwayat = (User) session.getAttribute("user");
    if(userRiwayat == null) return; 

    // Ambil Data Riwayat dari Database
    BookingDAO bDao = new BookingDAO();
    List<Booking> myBookings = bDao.getBookingsByUserId(userRiwayat.getId());

    // Format Data
    Locale id = new Locale("id", "ID");
    NumberFormat fmt = NumberFormat.getCurrencyInstance(id);
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, HH:mm", id);
%>

<div class="card border-0 shadow-sm rounded-4">
    <div class="card-header bg-white py-3 border-0 d-flex justify-content-between align-items-center">
        <h5 class="fw-bold mb-0 text-primary"><i class="bi bi-clock-history me-2"></i>Riwayat Pesanan</h5>
        <span class="badge bg-primary rounded-pill"><%= myBookings.size() %> Tiket</span>
    </div>
    <div class="card-body p-0">
        
        <% if (request.getParameter("status") != null && request.getParameter("status").equals("sukses")) { %>
            <div class="alert alert-success m-3 border-0 bg-success bg-opacity-10 text-success">
                <i class="bi bi-check-circle-fill me-2"></i>Pembayaran Berhasil! Tiket Anda telah terbit.
            </div>
        <% } %>

        <% if (myBookings.isEmpty()) { %>
            <div class="text-center py-5">
                <p class="text-muted">Belum ada riwayat pemesanan.</p>
                <a href="index.jsp" class="btn btn-sm btn-primary">Pesan Sekarang</a>
            </div>
        <% } else { %>
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="bg-light">
                        <tr>
                            <th class="ps-4">ID Booking</th>
                            <th>Penerbangan</th>
                            <th>Rute</th>
                            <th>Jadwal Terbang</th>
                            <th>Total Harga</th>
                            <th>Status</th>
                            <th class="text-end pe-4">Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Booking b : myBookings) { %>
                        <tr>
                            <td class="ps-4 fw-bold">#<%= b.getId() %></td>
                            <td>
                                <span class="badge bg-light text-dark border"><i class="bi bi-airplane me-1"></i> <%= b.getFlight().getFlightNumber() %></span>
                            </td>
                            <td>
                                <%= b.getFlight().getOrigin().getCode() %> <i class="bi bi-arrow-right mx-1 small text-muted"></i> <%= b.getFlight().getDestination().getCode() %>
                            </td>
                            <td><%= sdf.format(b.getFlight().getDepartureTime()) %></td>
                            <td class="fw-bold text-dark"><%= fmt.format(b.getTotalPrice()).replace("Rp", "Rp ") %></td>
                            <td>
                                <span class="badge bg-success bg-opacity-10 text-success px-3 py-2 rounded-pill">
                                    <%= b.getStatus().toUpperCase() %>
                                </span>
                            </td>
                            <td class="text-end pe-4">
                                <a href="index.jsp?halaman=ticket&id=<%= b.getId() %>" class="btn btn-sm btn-outline-primary rounded-pill">
                                    <i class="bi bi-ticket-perforated me-1"></i> E-Tiket
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } %>
    </div>
</div>