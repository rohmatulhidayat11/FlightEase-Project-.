<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FlightEase - Terbang Mudah & Murah</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;800&display=swap" rel="stylesheet">
    
    <style>
        html { scroll-behavior: smooth; } /* Efek scroll halus */
        body { font-family: 'Plus Jakarta Sans', sans-serif; overflow-x: hidden; background-color: #fcfcfc; }
        
        /* NAVBAR */
        .navbar { transition: 0.3s; padding: 20px 0; z-index: 1000; }
        .navbar.scrolled { background: rgba(26, 26, 26, 0.95); backdrop-filter: blur(10px); padding: 10px 0; }
        .navbar-brand { font-weight: 800; font-size: 1.5rem; }
        
        /* HERO SECTION */
        .hero {
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1436491865332-7a61a109c0f5?q=80&w=2074');
            background-size: cover; background-position: center;
            height: 100vh; display: flex; align-items: center; color: white; text-align: center;
        }
        .hero-title { font-size: 3.5rem; font-weight: 800; margin-bottom: 20px; }
        
        /* ABOUT US HERO */
        .hero-about {
            background: linear-gradient(rgba(13, 110, 253, 0.85), rgba(0, 79, 177, 0.9)), url('https://images.unsplash.com/photo-1436491865332-7a61a109c0f3?auto=format&fit=crop&w=1350&q=80');
            background-size: cover; background-position: center;
            padding: 120px 0; border-radius: 0 0 50px 50px; color: white;
            scroll-margin-top: 80px;
        }

        /* CARDS & COMPONENTS */
        .stat-card, .feature-box {
            border: none; border-radius: 20px; transition: 0.3s; background: white;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }
        .stat-card:hover, .feature-box:hover { transform: translateY(-10px); }
        
        .icon-box {
            width: 60px; height: 60px; display: flex; align-items: center; justify-content: center;
            border-radius: 15px; background: rgba(13, 110, 253, 0.1); color: #0d6efd;
            font-size: 1.5rem; margin: 0 auto 20px auto;
        }

        .team-card img {
            width: 140px; height: 140px; object-fit: cover; border-radius: 50%;
            border: 5px solid #fff; box-shadow: 0 10px 20px rgba(0,0,0,0.1); transition: 0.3s;
        }
        .team-card:hover img { transform: scale(1.05); border-color: #0d6efd; }
        
        section { scroll-margin-top: 80px; }
        footer { background: #1a1a1a; color: white; padding: 50px 0; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#"><i class="bi bi-airplane-engines-fill text-primary"></i> FlightEase</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item"><a class="nav-link" href="#tentang">About Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="#fitur">Layanan</a></li>
                    <li class="nav-item ms-lg-3 mt-2 mt-lg-0">
                        <a href="login.jsp" class="btn btn-outline-light rounded-pill px-4">Masuk</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <section class="hero">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <h1 class="hero-title">Jelajahi Dunia Tanpa Batas</h1>
                    <p class="lead mb-4">Platform pemesanan tiket pesawat termudah dan terpercaya.</p>
                    
                </div>
            </div>
        </div>
    </section>

    <section id="tentang">
        <div class="hero-about text-center">
            <div class="container">
                <h2 class="display-4 fw-bold mb-3">Terbang Lebih Jauh bersama FlightEase</h2>
                <p class="lead opacity-75 mx-auto" style="max-width: 700px;">
                    Kami hadir untuk menghubungkan mimpi ke destinasi melalui teknologi pencarian tiket tercepat.
                </p>
            </div>
        </div>

        <div class="container mt-n5 position-relative" style="z-index: 5; margin-top: -50px;">
            <div class="row g-4 text-center justify-content-center">
                <div class="col-md-4 col-6">
                    <div class="card stat-card p-4">
                        <h2 class="fw-bold text-primary">500k+</h2>
                        <small class="text-muted fw-bold">Tiket Terjual</small>
                    </div>
                </div>
                <div class="col-md-4 col-6">
                    <div class="card stat-card p-4">
                        <h2 class="fw-bold text-primary">120+</h2>
                        <small class="text-muted fw-bold">Partner Maskapai</small>
                    </div>
                </div>
                <div class="col-md-4 col-12">
                    <div class="card stat-card p-4">
                        <h2 class="fw-bold text-primary">24/7</h2>
                        <small class="text-muted fw-bold">Layanan Pelanggan</small>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5 mt-5" id="fitur">
        <div class="container py-5">
            <div class="text-center mb-5">
                <h6 class="text-primary fw-bold text-uppercase">Kenapa Memilih Kami?</h6>
                <h2 class="fw-bold">Layanan Terbaik Untuk Anda</h2>
            </div>
            <div class="row g-4">
                <div class="col-md-4 text-center">
                    <div class="feature-box p-5">
                        <div class="icon-box"><i class="bi bi-currency-exchange"></i></div>
                        <h4>Harga Transparan</h4>
                        <p class="text-muted small">Apa yang Anda lihat adalah apa yang Anda bayar tanpa biaya tambahan.</p>
                    </div>
                </div>
                <div class="col-md-4 text-center">
                    <div class="feature-box p-5">
                        <div class="icon-box"><i class="bi bi-shield-check"></i></div>
                        <h4>Keamanan Terjamin</h4>
                        <p class="text-muted small">Transaksi Anda dilindungi sistem enkripsi keamanan tingkat tinggi.</p>
                    </div>
                </div>
                <div class="col-md-4 text-center">
                    <div class="feature-box p-5">
                        <div class="icon-box"><i class="bi bi-clock-history"></i></div>
                        <h4>Proses Cepat</h4>
                        <p class="text-muted small">E-tiket terbit dalam hitungan detik setelah pembayaran dikonfirmasi.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="bg-light py-5">
        <div class="container py-5">
            <div class="text-center mb-5">
                <h2 class="fw-bold">Pilar di Balik FlightEase</h2>
                <p class="text-muted">Tim yang berdedikasi tinggi untuk kenyamanan Anda.</p>
            </div>
            <div class="row row-cols-1 row-cols-md-3 row-cols-lg-5 g-4 justify-content-center">
                <div class="col text-center">
                    <div class="team-card">
                        <img src="https://i.pravatar.cc/150?u=1" alt="Member" class="mb-3">
                        <h6 class="fw-bold mb-1">Rohmatul Hidayat</h6>
                        <small class="text-primary fw-bold">CEO & Founder</small>
                    </div>
                </div>
                <div class="col text-center">
                    <div class="team-card">
                        <img src="https://i.pravatar.cc/150?u=2" alt="Member" class="mb-3">
                        <h6 class="fw-bold mb-1">Abdul Hakim</h6>
                        <small class="text-primary fw-bold">Head of Tech</small>
                    </div>
                </div>
                <div class="col text-center">
                    <div class="team-card">
                        <img src="https://i.pravatar.cc/150?u=3" alt="Member" class="mb-3">
                        <h6 class="fw-bold mb-1">Lestari</h6>
                        <small class="text-primary fw-bold">Operations</small>
                    </div>
                </div>
                <div class="col text-center">
                    <div class="team-card">
                        <img src="https://i.pravatar.cc/150?u=4" alt="Member" class="mb-3">
                        <h6 class="fw-bold mb-1">Ali Mahbub</h6>
                        <small class="text-primary fw-bold">Operations</small>
                    </div>
                </div>
                <div class="col text-center">
                    <div class="team-card">
                        <img src="https://i.pravatar.cc/150?u=5" alt="Member" class="mb-3">
                        <h6 class="fw-bold mb-1">Zaidaan Salman</h6>
                        <small class="text-primary fw-bold">Operations</small>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer>
        <div class="container text-center">
            <h4 class="fw-bold mb-3">FlightEase Travel</h4>
            <p class="text-secondary mb-4">Melayani perjalanan Anda dengan sepenuh hati.</p>
            <div class="d-flex justify-content-center gap-3 mb-4">
                <a href="#" class="text-white fs-4"><i class="bi bi-instagram"></i></a>
                <a href="#" class="text-white fs-4"><i class="bi bi-facebook"></i></a>
                <a href="#" class="text-white fs-4"><i class="bi bi-twitter-x"></i></a>
            </div>
            <small class="text-secondary">&copy; 2026 FlightEase. All Rights Reserved.</small>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Animasi Navbar saat scroll
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled', 'bg-dark', 'shadow');
            } else {
                navbar.classList.remove('scrolled', 'bg-dark', 'shadow');
            }
        });
    </script>
</body>
</html>