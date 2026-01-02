<%-- 
    Document   : admin_bookings
    Created on : 25 Dec 2025, 20.15.45
    Author     : user
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.flightease.model.Booking"%>
<%@page import="java.util.List"%>
<%@page import="com.flightease.dao.BookingDAO"%>
<%
    // Ambil SEMUA data booking
    BookingDAO dao = new BookingDAO();
    List<Booking> list = dao.getAllBookings();
    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>

<div class="card shadow border-0">
    <div class="card-header bg-success text-white">
        <h5 class="mb-0"><i class="bi bi-cash-stack"></i> Laporan Semua Transaksi Masuk</h5>
    </div>
    <div class="card-body p-0">
        <div class="table-responsive">
            <table class="table table-striped table-hover mb-0 align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Tanggal Transaksi</th>
                        <th>Akun & Penumpang</th>
                        <th>Rute Penerbangan</th>
                        <th>Total Omset</th>
                    </tr>
                </thead>
                <tbody>
                    <% if (list != null && !list.isEmpty()) { %>
                    <% for (Booking b : list) {%>
                    <tr>
                        <td class="fw-bold">#<%= b.getId()%></td>
                        <td><%= sdf.format(b.getBookingDate())%></td>
                        <td>
                            <i class="bi bi-person-fill"></i> <%= b.getPassengerName()%>
                        </td>
                        <td>
                            <span class="badge bg-primary"><%= b.getFlight().getFlightNumber()%></span><br>
                            <small><%= b.getFlight().getOrigin().getCity()%> &rarr; <%= b.getFlight().getDestination().getCity()%></small>
                        </td>
                        <td class="fw-bold text-success">
                            <%= b.getFormattedPrice()%>
                        </td>
                    </tr>
                    <% } %>
                    <% } else { %>
                    <tr>
                        <td colspan="5" class="text-center py-4">Belum ada data transaksi masuk.</td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
        </div>
    </div>
</div>
