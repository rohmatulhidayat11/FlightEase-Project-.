<%-- 
    Document   : login
    Created on : 25 Dec 2025, 15.14.43
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - FlightEase</title>

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
                overflow: hidden;
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
                background: rgba(255, 255, 255, 0.85); /* Lebih solid sedikit biar teks jelas */
                backdrop-filter: blur(12px);
                -webkit-backdrop-filter: blur(12px);
                border-radius: 20px;
                border: 1px solid rgba(255, 255, 255, 0.6);
                box-shadow: 0 15px 35px rgba(0,0,0,0.3);
                z-index: 2;
                position: relative;
            }

            .flight-icon {
                font-size: 3.5rem;
                background: linear-gradient(45deg, #0d6efd, #0dcaf0);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                transform: rotate(-10deg);
                display: inline-block;
                margin-bottom: 10px;
            }

            .form-control {
                border-radius: 10px;
                padding: 12px 15px 12px 45px;
                border: 1px solid #ced4da;
                transition: all 0.3s;
            }
            .form-control:focus {
                box-shadow: 0 0 10px rgba(13, 110, 253, 0.2);
                border-color: #0d6efd;
            }

            .input-icon {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: #6c757d;
                font-size: 1.2rem;
                z-index: 10;
            }

            .btn-login {
                border-radius: 10px;
                padding: 12px;
                font-weight: 600;
                background: linear-gradient(45deg, #0d6efd, #0099ff);
                border: none;
                box-shadow: 0 4px 15px rgba(13, 110, 253, 0.3);
                transition: transform 0.2s;
            }
            .btn-login:hover {
                transform: scale(1.02);
            }

            .link-register {
                color: #0d6efd;
                font-weight: 600;
                text-decoration: none;
            }
            .link-register:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>

        <div class="bg-overlay"></div>

        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-5 col-lg-4">
                    <div class="card login-card p-4">

                        <div class="text-center mb-4">
                            <i class="bi bi-airplane-engines-fill flight-icon"></i>
                            <h3 class="fw-bold text-dark">FlightEase</h3>
                            <p class="text-muted small">Login untuk memulai petualanganmu</p>

                            <% if (request.getParameter("status") != null && request.getParameter("status").equals("gagal")) { %>
                            <div class="alert alert-danger alert-dismissible fade show py-2" role="alert" style="font-size: 0.85rem;">
                                <i class="bi bi-exclamation-triangle-fill me-1"></i> Username/Password Salah!
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <% } %>

                            <% if (request.getParameter("status") != null && request.getParameter("status").equals("registered")) { %>
                            <div class="alert alert-success alert-dismissible fade show py-2" role="alert" style="font-size: 0.85rem;">
                                <i class="bi bi-check-circle-fill me-1"></i> Registrasi Berhasil! Silakan Login.
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <% }%>
                        </div>

                        <form action="LoginServlet" method="post">
                            <div class="mb-3 position-relative">
                                <i class="bi bi-person-fill input-icon"></i>
                                <input type="text" name="username" class="form-control" placeholder="Username" required autocomplete="off">
                            </div>

                            <div class="mb-4 position-relative">
                                <i class="bi bi-lock-fill input-icon"></i>
                                <input type="password" name="password" class="form-control" placeholder="Password" required>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary btn-login text-white">
                                    MASUK <i class="bi bi-box-arrow-in-right ms-1"></i>
                                </button>
                            </div>
                        </form>

                        <div class="text-center mt-4">
                            <p class="small text-muted mb-1">Belum punya akun?</p>
                            <a href="register.jsp" class="link-register">Daftar Sekarang</a>
                            <div class="mt-3 border-top pt-3">
                                <small class="text-secondary">&copy; 2025 FlightEase App</small>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>