<%-- 
    Document   : home
    Created on : 25 Dec 2025, 15.57.02
    Author     : user
--%>

<%@page import="java.util.List"%>
<%@page import="com.flightease.dao.AirportDAO"%>
<%@page import="com.flightease.model.Airport"%>
<%@page import="com.flightease.model.User"%>

<%
    User u = (User) session.getAttribute("user");

  
    AirportDAO airportDao = new AirportDAO();
    List<Airport> listAirports = airportDao.getAllAirports();
%>

<div class="card shadow border-0" style="border-top: 5px solid #17a2b8;">
    <div class="card-body p-5">
        <h2 class="fw-light mb-4">
            Selamat Datang di <span class="fw-bold" style="color: #17a2b8;">FlightEase Travel!</span>
        </h2>

        <div class="alert alert-light border-start border-4 border-warning shadow-sm">
            <p class="lead mb-0">Halo, <strong><%= (u != null) ? u.getUsername() : "Tamu"%></strong>! Mau terbang ke mana hari ini?</p>
        </div>

        <div class="card mt-4 bg-light border-0 rounded-3">
            <div class="card-body p-4">
                <h5 class="card-title mb-4 text-secondary"><i class="bi bi-search"></i> Cari Penerbangan</h5>

                <form action="index.jsp" method="GET">
                    <input type="hidden" name="halaman" value="cari_hasil">

                    <div class="row g-3">
                        <div class="col-md-4">
                            <label class="form-label fw-bold small text-muted">Dari</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white"><i class="bi bi-geo-alt-fill text-danger"></i></span>
                                <select name="origin_id" class="form-select" required>
                                    <option value="" selected disabled>Pilih Kota Asal...</option>
                                    <% for (Airport a : listAirports) {%>
                                    <option value="<%= a.getId()%>">
                                        <%= a.getCity()%> (<%= a.getCode()%>) - <%= a.getName()%>
                                    </option>
                                    <% } %>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label fw-bold small text-muted">Ke</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white"><i class="bi bi-geo-alt-fill text-success"></i></span>
                                <select name="destination_id" class="form-select" required>
                                    <option value="" selected disabled>Pilih Kota Tujuan...</option>
                                    <% for (Airport a : listAirports) {%>
                                    <option value="<%= a.getId()%>">
                                        <%= a.getCity()%> (<%= a.getCode()%>) - <%= a.getName()%>
                                    </option>
                                    <% }%>
                                </select>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <label class="form-label fw-bold small text-muted">Tanggal Berangkat</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white"><i class="bi bi-calendar-event text-primary"></i></span>
                                <input type="date" name="tanggal" class="form-control" required>
                            </div>
                        </div>

                        <div class="col-12 mt-4">
                            <button type="submit" class="btn btn-warning w-100 fw-bold text-white shadow-sm py-2" style="background-color: #fd7e14; border: none;">
                                <i class="bi bi-airplane-engines me-2"></i> CARI TIKET SEKARANG
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="row text-center mt-5">
            <div class="col-md-4">
                <i class="bi bi-cash-coin fs-1 text-success"></i>
                <h5 class="mt-2">Harga Terbaik</h5>
            </div>
            <div class="col-md-4">
                <i class="bi bi-shield-check fs-1 text-primary"></i>
                <h5 class="mt-2">Aman & Terpercaya</h5>
            </div>
            <div class="col-md-4">
                <i class="bi bi-headset fs-1 text-danger"></i>
                <h5 class="mt-2">Layanan 24/7</h5>
            </div>
        </div>
    </div>
</div>