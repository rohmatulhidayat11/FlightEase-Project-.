<%@page import="com.flightease.dao.DashboardDAO"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Map"%>
<%@page import="java.time.Year"%>
<%
    
    DashboardDAO dao = new DashboardDAO();
    int totalUsers = dao.getTotalUsers();
    int totalFlights = dao.getTotalFlights();
    int totalBookings = dao.getTotalBookings();
    double totalRevenue = dao.getTotalRevenue();

    Map<Integer, Double> monthlyData = dao.getMonthlyRevenue();
    int currentYear = Year.now().getValue();

    Locale indonesia = new Locale("id", "ID");
    NumberFormat formater = NumberFormat.getCurrencyInstance(indonesia);
%>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
    /* Styling Khusus Dashboard */
    .stat-card {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        border: none;
        overflow: hidden;
    }
    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.08) !important;
    }
    .icon-box-lg {
        width: 60px; height: 60px;
        border-radius: 16px;
        display: flex; align-items: center; justify-content: center;
        font-size: 1.8rem;
    }
    .chart-header {
        display: flex; justify-content: space-between; align-items: center;
    }
</style>

<div class="d-flex justify-content-between align-items-center mb-4 fade-in">
    <div>
        <h3 class="fw-bold text-dark mb-1">Dashboard Overview</h3>
        <p class="text-muted mb-0">Ringkasan performa bisnis tahun <%= currentYear%></p>
    </div>
    <a href="index.jsp?halaman=laporan_bookings" class="btn btn-primary rounded-pill px-4 shadow-sm fw-bold">
        <i class="bi bi-file-earmark-spreadsheet me-2"></i>Laporan Lengkap
    </a>
</div>

<div class="row g-4 mb-4">
    <div class="col-md-6 col-xl-3">
        <div class="card stat-card shadow-sm h-100">
            <div class="card-body p-4">
                <div class="d-flex align-items-start justify-content-between">
                    <div>
                        <span class="text-muted fw-bold small text-uppercase">Total Pendapatan</span>
                        <h4 class="fw-bold text-dark mt-2 mb-1"><%= formater.format(totalRevenue).replace("Rp", "Rp ").replace(",00", "") %></h4>
                        <span class="badge bg-success bg-opacity-10 text-success rounded-pill px-2">
                            <i class="bi bi-arrow-up-right"></i> +12.5%
                        </span>
                    </div>
                    <div class="icon-box-lg bg-success bg-opacity-10 text-success">
                        <i class="bi bi-wallet2"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-xl-3">
        <div class="card stat-card shadow-sm h-100">
            <div class="card-body p-4">
                <div class="d-flex align-items-start justify-content-between">
                    <div>
                        <span class="text-muted fw-bold small text-uppercase">Total Transaksi</span>
                        <h3 class="fw-bold text-dark mt-2 mb-1"><%= totalBookings %></h3>
                        <small class="text-muted">Tiket Terjual</small>
                    </div>
                    <div class="icon-box-lg bg-primary bg-opacity-10 text-primary">
                        <i class="bi bi-cart-check"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-xl-3">
        <div class="card stat-card shadow-sm h-100">
            <div class="card-body p-4">
                <div class="d-flex align-items-start justify-content-between">
                    <div>
                        <span class="text-muted fw-bold small text-uppercase">Pengguna</span>
                        <h3 class="fw-bold text-dark mt-2 mb-1"><%= totalUsers %></h3>
                        <small class="text-muted">Akun Terdaftar</small>
                    </div>
                    <div class="icon-box-lg bg-warning bg-opacity-10 text-warning">
                        <i class="bi bi-people"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-md-6 col-xl-3">
        <div class="card stat-card shadow-sm h-100">
            <div class="card-body p-4">
                <div class="d-flex align-items-start justify-content-between">
                    <div>
                        <span class="text-muted fw-bold small text-uppercase">Penerbangan</span>
                        <h3 class="fw-bold text-dark mt-2 mb-1"><%= totalFlights %></h3>
                        <small class="text-muted">Jadwal Aktif</small>
                    </div>
                    <div class="icon-box-lg bg-danger bg-opacity-10 text-danger">
                        <i class="bi bi-airplane"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row g-4">
    <div class="col-lg-8">
        <div class="card border-0 shadow-sm rounded-4 h-100">
            <div class="card-header bg-white border-0 pt-4 px-4 chart-header">
                <div>
                    <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-graph-up-arrow text-primary me-2"></i>Analisis Pendapatan</h5>
                    <small class="text-muted">Grafik pertumbuhan omset bulanan</small>
                </div>
                <select class="form-select form-select-sm w-auto bg-light border-0 fw-bold text-secondary cursor-pointer">
                    <option selected>Tahun <%= currentYear %></option>
                    <option>Tahun <%= currentYear - 1 %></option>
                </select>
            </div>
            <div class="card-body px-4 pb-4">
                <div style="position: relative; height: 350px; width: 100%;">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <div class="col-lg-4">
        <div class="card border-0 shadow-sm rounded-4 h-100">
            <div class="card-header bg-white border-0 pt-4 px-4">
                <h5 class="fw-bold mb-0">Status Sistem</h5>
            </div>
            <div class="card-body px-4">
                <div class="d-flex align-items-center mb-4 p-3 rounded-3 bg-light">
                    <div class="flex-shrink-0">
                         <div class="rounded-circle bg-success p-3 text-white shadow-sm">
                             <i class="bi bi-database-check"></i>
                         </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="mb-0 fw-bold">Database Server</h6>
                        <small class="text-success fw-bold"><i class="bi bi-circle-fill me-1" style="font-size: 8px;"></i> Online & Stabil</small>
                    </div>
                </div>

                <div class="d-flex align-items-center mb-4 p-3 rounded-3 bg-light">
                    <div class="flex-shrink-0">
                         <div class="rounded-circle bg-info p-3 text-white shadow-sm">
                             <i class="bi bi-ticket-perforated"></i>
                         </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="mb-1 fw-bold">Target Penjualan</h6>
                        <div class="progress" style="height: 8px;">
                            <div class="progress-bar bg-info progress-bar-striped progress-bar-animated" role="progressbar" style="width: 85%"></div>
                        </div>
                        <div class="d-flex justify-content-between mt-1">
                            <small class="text-muted">Tercapai</small>
                            <small class="fw-bold text-info">85%</small>
                        </div>
                    </div>
                </div>

                <div class="alert alert-primary border-0 bg-primary bg-opacity-10 shadow-sm rounded-3" role="alert">
                    <div class="d-flex">
                        <i class="bi bi-lightbulb-fill text-primary me-2 fs-5"></i>
                        <div>
                            <small class="fw-bold text-primary">Tips Admin:</small><br>
                            <small class="text-muted">Lakukan rekap data setiap akhir bulan untuk akurasi laporan keuangan.</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // Data dari Java (JSP)
    const labels = ["Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Agu", "Sep", "Okt", "Nov", "Des"];
    const dataPendapatan = [
        <%= monthlyData.get(1)%>, <%= monthlyData.get(2)%>, <%= monthlyData.get(3)%>,
        <%= monthlyData.get(4)%>, <%= monthlyData.get(5)%>, <%= monthlyData.get(6)%>,
        <%= monthlyData.get(7)%>, <%= monthlyData.get(8)%>, <%= monthlyData.get(9)%>,
        <%= monthlyData.get(10)%>, <%= monthlyData.get(11)%>, <%= monthlyData.get(12)%>
    ];

    const ctx = document.getElementById('revenueChart').getContext('2d');
    
    
    let gradient = ctx.createLinearGradient(0, 0, 0, 400);
    gradient.addColorStop(0, 'rgba(13, 110, 253, 0.5)'); // Biru Transparan Atas
    gradient.addColorStop(1, 'rgba(13, 110, 253, 0.0)'); // Putih/Bening Bawah

    new Chart(ctx, {
        type: 'line', 
        data: {
            labels: labels,
            datasets: [{
                label: 'Pendapatan (Rp)',
                data: dataPendapatan,
                backgroundColor: gradient,
                borderColor: '#0d6efd', 
                borderWidth: 3,
                pointBackgroundColor: '#fff',
                pointBorderColor: '#0d6efd',
                pointBorderWidth: 2,
                pointRadius: 4,
                pointHoverRadius: 7,
                fill: true, 
                tension: 0.4 
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false }, 
                tooltip: {
                    backgroundColor: '#1e293b',
                    titleFont: { family: 'Poppins', size: 13 },
                    bodyFont: { family: 'Poppins', size: 13 },
                    padding: 12,
                    displayColors: false,
                    callbacks: {
                        label: function(context) {
                            return ' ' + new Intl.NumberFormat('id-ID', { style: 'currency', currency: 'IDR' }).format(context.raw);
                        }
                    }
                }
            },
            interaction: {
                intersect: false,
                mode: 'index',
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { borderDash: [5, 5], color: '#f1f5f9' }, 
                    ticks: {
                        font: { family: 'Poppins', size: 11 },
                        callback: function(value) {
                            return (value / 1000000) + ' Jt'; 
                        }
                    }
                },
                x: {
                    grid: { display: false },
                    ticks: { font: { family: 'Poppins', size: 11 } }
                }
            }
        }
    });
</script>