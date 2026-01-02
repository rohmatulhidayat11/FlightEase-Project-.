<%-- 
    Document   : navbar
    Created on : 25 Dec 2025, 15.56.19
    Author     : user
--%>

<%@page import="com.flightease.model.User"%>
<%
    // Ambil user dari session
    User userNav = (User) session.getAttribute("user");
    String role = (userNav != null) ? userNav.getRole() : "";
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-custom-blue py-2 shadow-sm" style="background-color: #138496;">
    <div class="container-fluid px-4">
        <a class="navbar-brand fw-bold" href="index.jsp">
            <i class="bi bi-airplane-fill"></i> FlightEase
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarMain">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" href="index.jsp?halaman=home"><i class="bi bi-house-door"></i> Home</a>
                </li>

                <% if (role.equals("admin")) { %>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                        <i class="bi bi-database"></i> Master Data
                    </a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="index.jsp?halaman=kelola_users">
                                <i class="bi bi-people"></i> Data Pengguna (Users)
                            </a></li>
                        <li><a class="dropdown-item" href="index.jsp?halaman=kelola_airports">
                                <i class="bi bi-geo-alt"></i> Data Bandara (Airports)
                            </a></li>
                        <li><a class="dropdown-item" href="index.jsp?halaman=kelola_flights">
                                <i class="bi bi-airplane"></i> Jadwal Penerbangan (Flights)
                            </a></li>
                    </ul>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp?halaman=laporan_bookings">
                        <i class="bi bi-file-earmark-text"></i> Laporan Transaksi
                    </a>
                </li>
                <% } %>

                <% if (role.equals("user")) { %>
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp?halaman=riwayat">
                        <i class="bi bi-ticket-detailed"></i> Tiket Saya
                    </a>
                </li>
                <% } %>
            </ul>

            <div class="d-flex align-items-center text-white">
                <% if (userNav != null) {%>
                <div class="dropdown">
                    <a class="text-white text-decoration-none dropdown-toggle fw-bold" href="#" role="button" data-bs-toggle="dropdown">
                        <i class="bi bi-person-circle"></i> <%= userNav.getUsername()%> 
                        <span class="badge bg-warning text-dark" style="font-size: 0.7rem;"><%= role.toUpperCase()%></span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item text-danger" href="LogoutServlet"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
                    </ul>
                </div>
                <% } else { %>
                <a href="login.jsp" class="btn btn-outline-light btn-sm">Login</a>
                <% }%>
            </div>
        </div>
    </div>
</nav>