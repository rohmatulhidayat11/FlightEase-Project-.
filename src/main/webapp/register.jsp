<%-- 
    Document   : register
    Created on : 25 Dec 2025, 15.46.11
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Daftar Akun - FlightEase</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-image: url('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?q=80&w=2074&auto=format&fit=crop');
                background-size: cover;
                background-position: center;
                height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .bg-overlay {
                position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
                background: rgba(0, 0, 0, 0.5);
    z-index: 1;
            }
            .login-card {
                background: rgba(255, 255, 255, 0.9);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                box-shadow: 0 15px 35px rgba(0,0,0,0.2);
                z-index: 2;
    position: relative;
            }
            .flight-icon {
    font-size: 3rem;
    color: #198754;
    transform: rotate(-45deg);
    display: inline-block;
    margin-bottom: 10px;
    }
            .form-control {
    border-radius: 10px;
    padding: 12px 15px;
    padding-left: 45px;
    }
            .input-group-text {
    background: transparent;
    border: none;
    position: absolute;
    left: 10px;
    top: 50%;
    transform: translateY(-50%);
    z-index: 10;
    color: #6c757d;
    }
            .btn-register {
                border-radius: 10px;
    padding: 12px;
    font-weight: 600;
    border: none;
                background: linear-gradient(45deg, #198754, #20c997); /* Warna Hijau */
                color: white;
    transition: all 0.3s ease;
            }
            .btn-register:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(25, 135, 84, 0.4);
    }
        </style>
    </head>
    <body>
        <div class="bg-overlay"></div>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-5 col-lg-4">
                    <div class="card login-card p-4">
                        <div class="card-header text-center border-0 pt-3">
                            <i class="bi bi-person-plus-fill flight-icon"></i>
                            <h3 class="fw-bold text-success">Registrasi</h3>
                            <p class="text-muted small">Buat akun baru untuk memesan tiket</p>
                        </div>

                        <div class="card-body">
                            <form action="RegisterServlet" method="post">
                                <div class="mb-3 position-relative">
                                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                                    <input type="text" name="username" class="form-control" placeholder="Buat Username" required autocomplete="off">
                                </div>

                                <div class="mb-4 position-relative">
                                    <span class="input-group-text"><i class="bi bi-key"></i></span>
                                    <input type="password" name="password" class="form-control" placeholder="Buat Password" required>
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-register">
                                        DAFTAR SEKARANG
                                    </button>
                                </div>
                            </form>
                        </div>

                        <div class="card-footer text-center bg-transparent border-0 mt-2">
                            <small>Sudah punya akun? <a href="login.jsp" class="text-decoration-none fw-bold text-success">Login disini</a></small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
