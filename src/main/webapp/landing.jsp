<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FlightEase - Terbang Mudah & Murah</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    
    <style>
        body { font-family: 'Poppins', sans-serif; overflow-x: hidden; }
        
        /* NAVBAR TRANSPARAN */
        .navbar { transition: 0.3s; padding: 20px 0; }
        .navbar-brand { font-weight: 700; font-size: 1.5rem; }
        
        /* HERO SECTION */
        .hero {
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?q=80&w=2074');
            background-size: cover;
            background-position: center;
            height: 100vh;
            display: flex;
            align-items: center;
            color: white;
            text-align: center;
        }
        
        .hero-title { font-size: 3.5rem; font-weight: 700; margin-bottom: 20px; }
        .hero-subtitle { font-size: 1.2rem; margin-bottom: 40px; opacity: 0.9; }
        
        .btn-cta {
            padding: 15px 40px;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 50px;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: 0.3s;
        }
        .btn-primary-cta {
            background: #0d6efd; border: none; color: white;
        }
        .btn-primary-cta:hover {
            background: #0b5ed7; transform: translateY(-5px); box-shadow: 0 10px 20px rgba(13, 110, 253, 0.4);
        }
        
        /* FEATURES SECTION */
        .feature-box {
            padding: 40px;
            border-radius: 20px;
            background: white;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            transition: 0.3s;
            height: 100%;
        }
        .feature-box:hover { transform: translateY(-10px); }
        .icon-box {
            width: 70px; height: 70px;
            background: #e3f2fd; color: #0d6efd;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 2rem; margin-bottom: 20px;
        }

        /* ABOUT US & TEAM SECTION */
        .team-card {
            background: white;
            padding: 30px 20px;
            border-radius: 20px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.05);
            transition: 0.3s;
            text-align: center;
            height: 100%;
            border: 1px solid #f0f0f0;
        }
        .team-card:hover {
            transform: translateY(-5px);
            border-color: #0d6efd;
        }
        .team-img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 15px;
            border: 3px solid #0d6efd;
            padding: 2px;
        }

        /* FOOTER */
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
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link text-white" href="#about">About Us</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="#fitur">Layanan</a></li>
                    <li class="nav-item ms-3">
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
                    <p class="hero-subtitle">Platform pemesanan tiket pesawat termudah dan terpercaya. Rencanakan perjalanan impian Anda sekarang juga.</p>
                    
                    <a href="login.jsp" class="btn btn-primary-cta btn-cta">Pesan Tiket Sekarang</a>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5" id="fitur">
        <div class="container py-5">
            <div class="text-center mb-5">
                <h6 class="text-primary fw-bold text-uppercase">Kenapa Memilih Kami?</h6>
                <h2 class="fw-bold">Perjalanan Nyaman Dimulai Di Sini</h2>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-box">
                        <div class="icon-box"><i class="bi bi-currency-exchange"></i></div>
                        <h4>Harga Transparan</h4>
                        <p class="text-muted">Tidak ada biaya tersembunyi. Harga yang Anda lihat adalah harga yang Anda bayar.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-box">
                        <div class="icon-box"><i class="bi bi-shield-check"></i></div>
                        <h4>Keamanan Terjamin</h4>
                        <p class="text-muted">Data pribadi dan transaksi Anda dilindungi dengan sistem keamanan enkripsi.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-box">
                        <div class="icon-box"><i class="bi bi-clock-history"></i></div>
                        <h4>Proses Cepat</h4>
                        <p class="text-muted">Pesan tiket hanya dalam hitungan menit, kapan saja dan di mana saja.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="py-5 bg-light" id="about">
        <div class="container py-5">
            <div class="row justify-content-center mb-5">
                <div class="col-lg-8 text-center">
                    <h6 class="text-primary fw-bold text-uppercase">Tentang FlightEase</h6>
                    <h2 class="fw-bold mb-3">Solusi Perjalanan Masa Depan</h2>
                    <p class="text-muted lead">
                        FlightEase adalah proyek pengembangan aplikasi berbasis web yang dirancang untuk memudahkan masyarakat dalam mencari dan memesan tiket pesawat. 
                        Dibangun dengan teknologi Java Enterprise (J2EE) untuk memastikan kecepatan, keamanan, dan kemudahan penggunaan.
                    </p>
                </div>
            </div>

            <div class="text-center mb-5">
                <h3 class="fw-bold">Meet Our Team</h3>
                <p class="text-muted">Orang-orang hebat di balik FlightEase</p>
            </div>

            <div class="row justify-content-center g-4">
                
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="team-card">
                        <img src="images/hakim.jpeg" class="team-img" alt="Member 1">
                        <h6 class="fw-bold mb-1">Abdul Hakim</h6>
                        <small class="text-muted d-block mb-2">NIM: 0110224161</small>
                        <span class="badge bg-primary bg-opacity-10 text-primary">Project Manager</span>
                    </div>
                </div>

                <div class="col-6 col-md-4 col-lg-2">
                    <div class="team-card">
                        <img src="images/lestari.jpeg" class="team-img" alt="Member 2">
                        <h6 class="fw-bold mb-1">Lestari</h6>
                        <small class="text-muted d-block mb-2">NIM: 0110224201</small>
                        <span class="badge bg-info bg-opacity-10 text-info">dev</span>
                    </div>
                </div>

                <div class="col-6 col-md-4 col-lg-2">
                    <div class="team-card">
                        <img src="images/rohmatt.jpeg" class="team-img" alt="Member 3">
                        <h6 class="fw-bold mb-1">Rohmatul Hidayat</h6>
                        <small class="text-muted d-block mb-2">NIM: 0110224015</small>
                        <span class="badge bg-warning bg-opacity-10 text-warning">Frontend Dev</span>
                    </div>
                </div>

                <div class="col-6 col-md-4 col-lg-2">
                    <div class="team-card">
                        <img src="images/ali mahbub.jpeg" class="team-img" alt="Member 4">
                        <h6 class="fw-bold mb-1">Ali Mahbub</h6>
                        <small class="text-muted d-block mb-2">NIM: 0110224054</small>
                        <span class="badge bg-danger bg-opacity-10 text-danger">backhand</span>
                    </div>
                </div>
                
                <div class="col-6 col-md-4 col-lg-2">
                    <div class="team-card">
                        <img src="images/zaidaan.jpeg" class="team-img" alt="Member 5">
                        <h6 class="fw-bold mb-1">Zaidaan Salman</h6>
                        <small class="text-muted d-block mb-2">NIM: 0110224078</small>
                        <span class="badge bg-success bg-opacity-10 text-success">UI/UX</span>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <footer>
        <div class="container text-center">
            <h4 class="fw-bold mb-3">FlightEase Travel</h4>
            <p class="text-secondary mb-4">Melayani perjalanan Anda sejak 2026.</p>
            <div class="d-flex justify-content-center gap-3 mb-4">
                <a href="#" class="text-white fs-4"><i class="bi bi-instagram"></i></a>
                <a href="#" class="text-white fs-4"><i class="bi bi-facebook"></i></a>
                <a href="#" class="text-white fs-4"><i class="bi bi-twitter-x"></i></a>
            </div>
            <small class="text-secondary">&copy; 2026 FlightEase Project. All Rights Reserved.</small>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Efek Navbar berubah warna saat discroll
        window.addEventListener('scroll', function() {
            if (window.scrollY > 50) {
                document.querySelector('.navbar').classList.add('bg-dark', 'shadow');
            } else {
                document.querySelector('.navbar').classList.remove('bg-dark', 'shadow');
            }
        });
    </script>
</body>
</html>