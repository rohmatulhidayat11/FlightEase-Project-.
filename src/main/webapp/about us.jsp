<%-- 
    Document   : about us
    Created on : 8 Jan 2026, 14.27.34
    Author     : zaidaansalman
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Tentang Kami - FlightEase</title>
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&display=swap" rel="stylesheet">

        <style>
            body { font-family: 'Plus Jakarta Sans', sans-serif; background-color: #fcfcfc; }
            
            .hero-about {
                background: linear-gradient(rgba(13, 110, 253, 0.85), rgba(0, 79, 177, 0.9)), 
                            url('https://images.unsplash.com/photo-1436491865332-7a61a109c0f3?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
                background-size: cover;
                background-position: center;
                padding: 120px 0;
                border-radius: 0 0 50px 50px;
                color: white;
            }

            .stat-card {
                border: none;
                border-radius: 20px;
                transition: all 0.3s ease;
                background: #ffffff;
            }

            .stat-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 30px rgba(0,0,0,0.1) !important;
            }

            .icon-box {
                width: 60px;
                height: 60px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 15px;
                background: rgba(13, 110, 253, 0.1);
                color: #0d6efd;
                font-size: 1.5rem;
                margin-bottom: 20px;
            }

            .mission-img {
                border-radius: 30px;
                box-shadow: 20px 20px 60px rgba(0,0,0,0.05);
            }

            .team-card img {
                width: 140px;
                height: 140px;
                object-fit: cover;
                border-radius: 50%;
                border: 5px solid #fff;
                box-shadow: 0 10px 20px rgba(0,0,0,0.1);
                transition: 0.3s;
            }
            
            .team-card:hover img {
                transform: scale(1.05);
                border-color: #0d6efd;
            }
        </style>
    </head>
    <body>

        <div class="container-fluid p-0">
            <section class="hero-about text-center mb-5">
                <div class="container">
                    <h1 class="display-3 fw-800 mb-3">Terbang Lebih Jauh bersama FlightEase</h1>
                    <p class="lead opacity-75 mx-auto" style="max-width: 700px;">
                        Kami hadir untuk menyederhanakan perjalanan Anda. Menghubungkan mimpi ke destinasi melalui teknologi pencarian tiket tercepat dan termurah.
                    </p>
                </div>
            </section>

            <div class="container my-5">
                <div class="row g-4 text-center mb-5">
                    <div class="col-md-4">
                        <div class="card stat-card shadow-sm p-4 text-center">
                            <h2 class="fw-bold text-primary">500k+</h2>
                            <p class="text-muted mb-0 fw-semibold">Tiket Terjual</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stat-card shadow-sm p-4 text-center">
                            <h2 class="fw-bold text-primary">120+</h2>
                            <p class="text-muted mb-0 fw-semibold">Maskapai Partner</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stat-card shadow-sm p-4 text-center">
                            <h2 class="fw-bold text-primary">24/7</h2>
                            <p class="text-muted mb-0 fw-semibold">Layanan Pelanggan</p>
                        </div>
                    </div>
                </div>

                <div class="row align-items-center py-5">
                    <div class="col-lg-6 mb-4 mb-lg-0 text-center">
                        <img src="https://images.unsplash.com/photo-1521737604893-d14cc237f11d?auto=format&fit=crop&w=600&q=80" alt="Team" class="img-fluid mission-img">
                    </div>
                    <div class="col-lg-6 ps-lg-5">
                        <h6 class="text-primary fw-bold text-uppercase">Visi Kami</h6>
                        <h2 class="fw-bold mb-4">Membangun Ekosistem Perjalanan Masa Depan</h2>
                        <div class="d-flex mb-4">
                            <div class="icon-box me-3"><i class="bi bi-shield-check"></i></div>
                            <div>
                                <h5 class="fw-bold">Keamanan Transaksi</h5>
                                <p class="text-muted">Setiap pembayaran diproses dengan enkripsi tingkat tinggi demi keamanan data Anda.</p>
                            </div>
                        </div>
                        <div class="d-flex mb-4">
                            <div class="icon-box me-3"><i class="bi bi-lightning-charge"></i></div>
                            <div>
                                <h5 class="fw-bold">Kecepatan Akses</h5>
                                <p class="text-muted">Dapatkan perbandingan harga dari ratusan rute hanya dalam hitungan detik.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <section class="bg-light py-5">
                <div class="container">
                    <div class="text-center mb-5">
                        <h2 class="fw-bold">Pilar di Balik FlightEase</h2>
                        <p class="text-muted">Tim ahli yang bekerja keras untuk kenyamanan terbang Anda.</p>
                    </div>
                    <div class="row justify-content-center">
                        <div class="col-md-3 text-center mb-4">
                            <div class="team-card">
                                <img src="https://i.pravatar.cc/150?u=1" alt="Andra" class="mb-3">
                                <h5 class="fw-bold mb-0"> Rohmatul Hidayat</h5>
                                <small class="text-primary fw-bold">CEO & Founder</small>
                            </div>
                        </div>
                        <div class="col-md-3 text-center mb-4">
                            <div class="team-card">
                                <img src="https://i.pravatar.cc/150?u=2" alt="Sarah" class="mb-3">
                                <h5 class="fw-bold mb-0"> Abdul Hakim</h5>
                                <small class="text-primary fw-bold">Head of Technology</small>
                            </div>
                        </div>
                        <div class="col-md-3 text-center mb-4">
                            <div class="team-card">
                                <img src="https://i.pravatar.cc/150?u=3" alt="Rian" class="mb-3">
                                <h5 class="fw-bold mb-0">Lestari</h5>
                                <small class="text-primary fw-bold">Operations Manager</small>
                            </div>
                        </div>
                        <div class="col-md-3 text-center mb-4">
                            <div class="team-card">
                                <img src="https://i.pravatar.cc/150?u=3" alt="Rian" class="mb-3">
                                <h5 class="fw-bold mb-0">Ali Mahbub</h5>
                                <small class="text-primary fw-bold">Operations Manager</small>
                            </div>
                    </div>
                </div>
                    <div class="col-md-3 text-center mb-4">
                            <div class="team-card">
                                <img src="https://i.pravatar.cc/150?u=3" alt="Rian" class="mb-3">
                                <h5 class="fw-bold mb-0">Zaidaan Salman</h5>
                                <small class="text-primary fw-bold">Operations Manager</small>
                            </div>
            </section>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>