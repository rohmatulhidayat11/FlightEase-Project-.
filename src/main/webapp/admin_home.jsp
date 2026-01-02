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

    // Ambil data pendapatan bulanan
    Map<Integer, Double> monthlyData = dao.getMonthlyRevenue();
    int currentYear = Year.now().getValue();

    // Format Rupiah
    Locale indonesia = new Locale("id", "ID");
    NumberFormat formater = NumberFormat.getCurrencyInstance(indonesia);
%>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div class="mb-4">
    <h3 class="fw-bold text-dark">Dashboard Admin</h3>
    <p class="text-muted">Selamat datang kembali, Admin! Berikut ringkasan tahun <%= currentYear%>.</p>
</div>

<div class="row g-3 mb-4">
    <div class="col-md-6 col-lg-3">
        <div class="card bg-success text-white h-100 shadow-sm border-0">
            <div class="card-body d-flex justify-content-between align-items-center">
                <div>
                    <h6 class="text-uppercase mb-1" style="font-size: 0.8rem; opacity: 0.8;">Total Pendapatan</h6>
                    <h4 class="fw-bold mb-0"><%= formater.format(totalRevenue).replace("Rp", "Rp ")%></h4>
                </div>
                <i class="bi bi-cash-coin fs-1 opacity-50"></i>
            </div>
        </div>
    </div>
    <div class="col-md-6 col-lg-3">
        <div class="card bg-primary text-white h-100 shadow-sm border-0">
            <div class="card-body d-flex justify-content-between align-items-center">
                <div>
                    <h6 class="text-uppercase mb-1" style="font-size: 0.8rem; opacity: 0.8;">Total Transaksi</h6>
                    <h3 class="fw-bold mb-0"><%= totalBookings%></h3>
                </div>
                <i class="bi bi-cart-check fs-1 opacity-50"></i>
            </div>
        </div>
    </div>
    <div class="col-md-6 col-lg-3">
        <div class="card bg-warning text-dark h-100 shadow-sm border-0">
            <div class="card-body d-flex justify-content-between align-items-center">
                <div>
                    <h6 class="text-uppercase mb-1" style="font-size: 0.8rem; opacity: 0.8;">Pengguna Terdaftar</h6>
                    <h3 class="fw-bold mb-0"><%= totalUsers%></h3>
                </div>
                <i class="bi bi-people-fill fs-1 opacity-50"></i>
            </div>
        </div>
    </div>
    <div class="col-md-6 col-lg-3">
        <div class="card bg-danger text-white h-100 shadow-sm border-0">
            <div class="card-body d-flex justify-content-between align-items-center">
                <div>
                    <h6 class="text-uppercase mb-1" style="font-size: 0.8rem; opacity: 0.8;">Jadwal Aktif</h6>
                    <h3 class="fw-bold mb-0"><%= totalFlights%></h3>
                </div>
                <i class="bi bi-airplane-fill fs-1 opacity-50"></i>
            </div>
        </div>
    </div>
</div>

<div class="card border-0 shadow-sm">
    <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
        <h6 class="mb-0 fw-bold"><i class="bi bi-graph-up-arrow text-success"></i> Grafik Pendapatan Bulanan (<%= currentYear%>)</h6>
        <a href="index.jsp?halaman=laporan_bookings" class="btn btn-outline-primary btn-sm">Lihat Detail <i class="bi bi-arrow-right"></i></a>
    </div>
    <div class="card-body">
        <canvas id="revenueChart" style="max-height: 400px;"></canvas>
    </div>
</div>

<script>
    // 1. Siapkan Data dari JSP (Java) ke JavaScript
    const labels = ["Jan", "Feb", "Mar", "Apr", "Mei", "Jun", "Jul", "Agu", "Sep", "Okt", "Nov", "Des"];
    const dataPendapatan = [
    <%= monthlyData.get(1)%>, <%= monthlyData.get(2)%>, <%= monthlyData.get(3)%>,
    <%= monthlyData.get(4)%>, <%= monthlyData.get(5)%>, <%= monthlyData.get(6)%>,
    <%= monthlyData.get(7)%>, <%= monthlyData.get(8)%>, <%= monthlyData.get(9)%>,
    <%= monthlyData.get(10)%>, <%= monthlyData.get(11)%>, <%= monthlyData.get(12)%>
    ];

    // 2. Konfigurasi Chart.js
    const ctx = document.getElementById('revenueChart').getContext('2d');
    const revenueChart = new Chart(ctx, {
        type: 'bar', // Jenis grafik: Batang
        data: {
            labels: labels, // Label sumbu X (Bulan)
            datasets: [{
                    label: 'Pendapatan (Rp)',
                    data: dataPendapatan, // Data sumbu Y (Nilai Rupiah)
                    backgroundColor: 'rgba(25, 135, 84, 0.6)', // Warna batang (Hijau transparan)
                    borderColor: 'rgba(25, 135, 84, 1)', // Warna garis pinggir
                    borderWidth: 1,
                    borderRadius: 5 // Biar batangnya agak bulat
                }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        // Format angka di sumbu Y jadi Rupiah (biar rapi)
                        callback: function (value, index, values) {
                            return 'Rp ' + value.toLocaleString('id-ID');
                        }
                    }
                }
            },
            plugins: {
                tooltip: {
                    callbacks: {
                        // Format tooltip saat mouse di-hover
                        label: function (context) {
                            let label = context.dataset.label || '';
                            if (label) {
                                label += ': ';
                            }
                            if (context.parsed.y !== null) {
                                label += new Intl.NumberFormat('id-ID', {style: 'currency', currency: 'IDR'}).format(context.parsed.y);
                            }
                            return label;
                        }
                    }
                }
            }
        }
    });
</script>