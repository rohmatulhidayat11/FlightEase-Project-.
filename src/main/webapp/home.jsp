<%@page import="com.flightease.model.User"%>
<%@page import="com.flightease.dao.AirportDAO"%>
<%@page import="com.flightease.model.Airport"%>
<%@page import="java.util.List"%>
<%
    
    User userHome = (User) session.getAttribute("user");
    String namaUser = (userHome != null) ? userHome.getUsername() : "Traveler";

    AirportDAO aDao = new AirportDAO();
    List<Airport> airports = aDao.getAllAirports();
%>

<style>
    .dashboard-header {
        background: linear-gradient(to right, #0d6efd, #0dcaf0);
        color: white;
        padding: 40px 30px;
        border-radius: 20px;
        margin-bottom: -30px; 
        padding-bottom: 60px;
    }
    .search-panel {
        background: white;
        border-radius: 20px;
        padding: 30px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        position: relative;
    }
</style>

<div class="dashboard-header shadow-sm">
    <div class="row align-items-center">
        <div class="col-md-8">
            <h2 class="fw-bold mb-1">Halo, <%= namaUser %>! ?</h2>
            <p class="mb-0 opacity-75">Siap menjelajahi destinasi baru hari ini?</p>
        </div>
        <div class="col-md-4 text-end d-none d-md-block">
            <i class="bi bi-cloud-sun fs-1 opacity-50"></i>
        </div>
    </div>
</div>

<div class="search-panel mx-3">
    <h5 class="fw-bold text-dark mb-4"><i class="bi bi-airplane-engines text-primary me-2"></i>Cari Penerbangan</h5>
    
    <form action="index.jsp" method="GET">
        <input type="hidden" name="halaman" value="cari_hasil">
        
        <div class="row g-3">
            <div class="col-md-4">
                <label class="form-label small fw-bold text-muted">DARI</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-geo-alt-fill text-primary"></i></span>
                    <select name="origin_id" class="form-select bg-light border-start-0" required>
                        <option value="" disabled selected>Pilih Kota Asal</option>
                        <% for(Airport a : airports) { %>
                            <option value="<%= a.getId() %>"><%= a.getCity() %> (<%= a.getCode() %>)</option>
                        <% } %>
                    </select>
                </div>
            </div>

            <div class="col-md-4">
                <label class="form-label small fw-bold text-muted">KE TUJUAN</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-geo-fill text-danger"></i></span>
                    <select name="destination_id" class="form-select bg-light border-start-0" required>
                        <option value="" disabled selected>Pilih Kota Tujuan</option>
                        <% for(Airport a : airports) { %>
                            <option value="<%= a.getId() %>"><%= a.getCity() %> (<%= a.getCode() %>)</option>
                        <% } %>
                    </select>
                </div>
            </div>

            <div class="col-md-4">
                <label class="form-label small fw-bold text-muted">TANGGAL</label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-calendar-event text-success"></i></span>
                    <input type="date" name="tanggal" class="form-control bg-light border-start-0" required>
                </div>
            </div>

            <div class="col-12 mt-4">
                <button type="submit" class="btn btn-primary w-100 py-3 fw-bold shadow-sm">
                    CARI JADWAL PENERBANGAN <i class="bi bi-arrow-right ms-2"></i>
                </button>
            </div>
        </div>
    </form>
</div>

<div class="row g-3 mt-4 mx-1">
    <div class="col-md-4">
        <div class="p-3 bg-white rounded-4 shadow-sm border border-light d-flex align-items-center">
            <div class="bg-warning bg-opacity-10 text-warning p-3 rounded-circle me-3">
                <i class="bi bi-ticket-perforated-fill fs-4"></i>
            </div>
            <div>
                <h6 class="fw-bold mb-0">Promo Spesial</h6>
                <small class="text-muted">Diskon hingga 20%</small>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="p-3 bg-white rounded-4 shadow-sm border border-light d-flex align-items-center">
            <div class="bg-success bg-opacity-10 text-success p-3 rounded-circle me-3">
                <i class="bi bi-shield-check-fill fs-4"></i>
            </div>
            <div>
                <h6 class="fw-bold mb-0">Perjalanan Aman</h6>
                <small class="text-muted">Asuransi perjalanan gratis</small>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="p-3 bg-white rounded-4 shadow-sm border border-light d-flex align-items-center">
            <div class="bg-danger bg-opacity-10 text-danger p-3 rounded-circle me-3">
                <i class="bi bi-heart-fill fs-4"></i>
            </div>
            <div>
                <h6 class="fw-bold mb-0">Destinasi Favorit</h6>
                <small class="text-muted">Rekomendasi terbaik</small>
            </div>
        </div>
    </div>
</div>