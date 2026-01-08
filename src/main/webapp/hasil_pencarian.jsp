<%@page import="com.flightease.dao.FlightDAO"%>
<%@page import="com.flightease.model.Flight"%>
<%@page import="com.flightease.dao.AirportDAO"%>
<%@page import="com.flightease.model.Airport"%>
<%@page import="java.util.List"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
    // 1. Ambil Data dari URL
    String originStr = request.getParameter("origin_id");
    String destStr = request.getParameter("destination_id");
    String tanggalStr = request.getParameter("tanggal"); // Format: 2026-01-01

    List<Flight> flightList = null;
    String ruteInfo = "";

    // 2. Panggil DAO jika data lengkap
    if (originStr != null && destStr != null && tanggalStr != null) {
        int originId = Integer.parseInt(originStr);
        int destId = Integer.parseInt(destStr);
        
        FlightDAO fDao = new FlightDAO();
        flightList = fDao.searchFlights(originId, destId, tanggalStr);
        
        // Ambil nama kota buat judul (Opsional, biar cantik)
        AirportDAO aDao = new AirportDAO();
        Airport as = aDao.getAirportById(originId);
        Airport tuj = aDao.getAirportById(destId);
        if(as != null && tuj != null) {
            ruteInfo = as.getCity() + " <i class='bi bi-arrow-right mx-2'></i> " + tuj.getCity();
        }
    }

    // Format Rupiah & Tanggal
    Locale indonesia = new Locale("id", "ID");
    NumberFormat formater = NumberFormat.getCurrencyInstance(indonesia);
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy, HH:mm", indonesia);
%>

<div class="card border-0 shadow-sm rounded-4">
    <div class="card-header bg-white py-3 border-0">
        <h5 class="fw-bold mb-0 text-primary">
            <i class="bi bi-airplane-engines me-2"></i>Hasil Pencarian
        </h5>
        <small class="text-muted"><%= (ruteInfo.isEmpty()) ? "Menampilkan penerbangan tersedia" : ruteInfo %></small>
    </div>
    
    <div class="card-body p-0">
        <% if (flightList == null || flightList.isEmpty()) { %>
            <div class="text-center py-5">
                <div class="mb-3 opacity-25">
                    <i class="bi bi-emoji-frown display-1"></i>
                </div>
                <h4 class="fw-bold text-secondary">Penerbangan Tidak Ditemukan</h4>
                <p class="text-muted">Maaf, tidak ada jadwal terbang pada tanggal <b><%= tanggalStr %></b> untuk rute ini.</p>
                <a href="index.jsp?halaman=home" class="btn btn-outline-primary rounded-pill px-4 mt-2">
                    <i class="bi bi-search me-2"></i>Cari Tanggal Lain
                </a>
            </div>
        <% } else { %>
            <div class="list-group list-group-flush">
                <% for (Flight f : flightList) { %>
                <div class="list-group-item p-4 border-bottom hover-shadow transition">
                    <div class="row align-items-center">
                        <div class="col-md-2 text-center mb-3 mb-md-0">
                            <i class="bi bi-airplane-fill fs-1 text-primary"></i>
                            <div class="small fw-bold text-muted mt-1"><%= f.getFlightNumber() %></div>
                        </div>
                        <div class="col-md-4 mb-3 mb-md-0">
                            <h5 class="fw-bold mb-1"><%= sdf.format(f.getDepartureTime()) %></h5>
                            <span class="badge bg-success bg-opacity-10 text-success">Langsung</span>
                        </div>
                        <div class="col-md-3 text-end mb-3 mb-md-0">
                            <small class="text-muted d-block">Harga per orang</small>
                            <h4 class="fw-bold text-danger mb-0"><%= formater.format(f.getPrice()).replace("Rp", "Rp ") %></h4>
                        </div>
                        <div class="col-md-3 text-end">
                            <a href="index.jsp?halaman=booking&flight_id=<%= f.getId() %>" class="btn btn-primary w-100 fw-bold rounded-3 shadow-sm">
                                PILIH <i class="bi bi-chevron-right ms-1"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        <% } %>
    </div>
</div>