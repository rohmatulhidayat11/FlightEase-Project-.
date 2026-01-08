<%@page import="com.flightease.dao.FlightDAO"%>
<%@page import="com.flightease.model.Flight"%>
<%@page import="com.flightease.model.User"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
    // 1. Ambil ID Penerbangan dari URL
    String idStr = request.getParameter("flight_id");
    Flight flight = null;
    
    // 2. Ambil Detail Penerbangan dari Database
    if(idStr != null) {
        FlightDAO fDao = new FlightDAO();
        flight = fDao.getFlightById(Integer.parseInt(idStr));
    }

    // Jika penerbangan tidak ditemukan, kembalikan ke home
    if(flight == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Format Rupiah & Tanggal
    Locale indonesia = new Locale("id", "ID");
    NumberFormat formater = NumberFormat.getCurrencyInstance(indonesia);
    SimpleDateFormat sdfDate = new SimpleDateFormat("dd MMMM yyyy", indonesia);
    SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm", indonesia);
    
    // Ambil User Login (Untuk isi otomatis nama pemesan)
    User userBooking = (User) session.getAttribute("user");
%>

<div class="row g-4 fade-in">
    <div class="col-lg-7">
        <div class="card border-0 shadow-sm rounded-4">
            <div class="card-header bg-white py-3 border-0">
                <h5 class="fw-bold mb-0 text-primary"><i class="bi bi-person-lines-fill me-2"></i>Data Penumpang</h5>
            </div>
            <div class="card-body p-4">
                <form action="BookingServlet" method="POST">
                    <input type="hidden" name="flight_id" value="<%= flight.getId() %>">
                    
                    <div class="alert alert-info small border-0 bg-info bg-opacity-10 text-info mb-4">
                        <i class="bi bi-info-circle-fill me-1"></i> 
                        Pastikan nama penumpang sesuai dengan KTP/Paspor.
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold small text-muted">TITLE</label>
                        <div class="btn-group w-100" role="group">
                            <input type="radio" class="btn-check" name="title" id="t1" value="Mr" checked>
                            <label class="btn btn-outline-primary" for="t1">Tuan (Mr)</label>
                            
                            <input type="radio" class="btn-check" name="title" id="t2" value="Mrs">
                            <label class="btn btn-outline-primary" for="t2">Nyonya (Mrs)</label>
                            
                            <input type="radio" class="btn-check" name="title" id="t3" value="Ms">
                            <label class="btn btn-outline-primary" for="t3">Nona (Ms)</label>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold small text-muted">NAMA LENGKAP</label>
                        <input type="text" name="passenger_name" class="form-control form-control-lg bg-light" 
                               placeholder="Contoh: Budi Santoso" 
                               value="<%= (userBooking != null) ? userBooking.getFullname() : "" %>" required>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-3 fw-bold rounded-3 shadow-sm" onclick="return confirm('Lanjutkan pembayaran?')">
                        LANJUTKAN KE PEMBAYARAN <i class="bi bi-credit-card-2-front ms-2"></i>
                    </button>
                    <a href="index.jsp?halaman=home" class="btn btn-link text-decoration-none w-100 mt-2 text-muted">Batal</a>
                </form>
            </div>
        </div>
    </div>

    <div class="col-lg-5">
        <div class="card border-0 shadow-sm rounded-4 bg-primary text-white" 
             style="background: linear-gradient(135deg, #0d6efd, #0043a8);">
            <div class="card-body p-4 position-relative overflow-hidden">
                <i class="bi bi-airplane-engines-fill position-absolute text-white opacity-25" 
                   style="font-size: 10rem; right: -30px; bottom: -30px; transform: rotate(-15deg);"></i>
                
                <h5 class="fw-bold mb-4 border-bottom border-white border-opacity-25 pb-3">Ringkasan Penerbangan</h5>
                
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <div class="display-6 fw-bold"><%= flight.getOrigin().getCode() %></div>
                        <div class="small opacity-75"><%= flight.getOrigin().getCity() %></div>
                    </div>
                    <div class="text-center">
                        <i class="bi bi-airplane h3 mb-0"></i>
                        <div class="small opacity-50"><%= flight.getFlightNumber() %></div>
                    </div>
                    <div class="text-end">
                        <div class="display-6 fw-bold"><%= flight.getDestination().getCode() %></div>
                        <div class="small opacity-75"><%= flight.getDestination().getCity() %></div>
                    </div>
                </div>

                <div class="bg-white bg-opacity-10 rounded-3 p-3 mb-4">
                    <div class="d-flex justify-content-between mb-2">
                        <span class="opacity-75"><i class="bi bi-calendar-event me-2"></i>Tanggal</span>
                        <span class="fw-bold"><%= sdfDate.format(flight.getDepartureTime()) %></span>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span class="opacity-75"><i class="bi bi-clock me-2"></i>Jam</span>
                        <span class="fw-bold"><%= sdfTime.format(flight.getDepartureTime()) %> WIB</span>
                    </div>
                </div>

                <div class="mt-4 pt-3 border-top border-white border-opacity-25">
                    <small class="opacity-75 d-block mb-1">Total Pembayaran</small>
                    <h2 class="fw-bold mb-0"><%= formater.format(flight.getPrice()).replace("Rp", "Rp ") %></h2>
                </div>
            </div>
        </div>
    </div>
</div>