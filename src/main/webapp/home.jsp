<%@page import="com.flightease.dao.AirportDAO"%>
<%@page import="com.flightease.model.Airport"%>
<%@page import="java.util.List"%>
<%
    AirportDAO aDao = new AirportDAO();
    List<Airport> airports = aDao.getAllAirports();
%>

<div class="card border-0 shadow-sm rounded-4 p-4 mt-3">
    <div class="row align-items-center">
        <div class="col-md-5">
            <h2 class="fw-bold text-primary mb-3">Mau Terbang ke Mana?</h2>
            <p class="text-muted">Cari jadwal penerbangan terbaik untuk perjalananmu.</p>
            
            <form action="index.jsp" method="GET">
                <input type="hidden" name="halaman" value="cari_hasil">
                
                <div class="mb-3">
                    <label class="fw-bold small text-muted">Dari Kota</label>
                    <select name="origin_id" class="form-select form-select-lg bg-light border-0" required>
                        <option value="" disabled selected>Pilih Asal...</option>
                        <% for(Airport a : airports) { %>
                            <option value="<%= a.getId() %>"><%= a.getCity() %> (<%= a.getCode() %>)</option>
                        <% } %>
                    </select>
                </div>
                
                <div class="mb-3">
                    <label class="fw-bold small text-muted">Ke Kota</label>
                    <select name="destination_id" class="form-select form-select-lg bg-light border-0" required>
                        <option value="" disabled selected>Pilih Tujuan...</option>
                        <% for(Airport a : airports) { %>
                            <option value="<%= a.getId() %>"><%= a.getCity() %> (<%= a.getCode() %>)</option>
                        <% } %>
                    </select>
                </div>
                
                <div class="mb-4">
                    <label class="fw-bold small text-muted">Tanggal Berangkat</label>
                    <input type="date" name="tanggal" class="form-control form-control-lg bg-light border-0" required>
                </div>
                
                <button type="submit" class="btn btn-primary w-100 py-3 fw-bold rounded-3 shadow-sm">
                    CARI TIKET SEKARANG <i class="bi bi-arrow-right ms-2"></i>
                </button>
            </form>
        </div>
        
        <div class="col-md-7 d-none d-md-block text-center">
            <img src="https://img.freepik.com/free-vector/airplane-flight-concept-illustration_114360-353.jpg" class="img-fluid" style="max-height: 400px;" alt="Travel Illustration">
        </div>
    </div>
</div>