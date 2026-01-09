<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.flightease.model.User"%>
<%
    // 1. CEK SESSION USER
    User user = (User) session.getAttribute("user");
    String halaman = request.getParameter("halaman");

    // 2. LOGIKA ROUTING UTAMA
    
    // SKENARIO A: Jika User BELUM LOGIN
    if (user == null) {
        // Tampilkan Landing Page
%>
        <jsp:include page="landing.jsp" />
<%
    } 
    // SKENARIO B: Jika User SUDAH LOGIN
    else {
%>
        <!DOCTYPE html>
        <html lang="id">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Dashboard - FlightEase</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
            <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
            <style>
                body { font-family: 'Poppins', sans-serif; background-color: #f8f9fa; }
            </style>
        </head>
        <body>
            
            <%-- Layout Khusus Admin (Ada Sidebar) --%>
            <% if(user.getRole().equals("admin")) { %>
                <div class="d-flex">
                    <div style="width: 280px; flex-shrink: 0;">
                        <jsp:include page="sidebar.jsp" />
                    </div>
                    <div class="flex-grow-1 p-4" style="height: 100vh; overflow-y: auto;">
                        <%
                            if (halaman == null || halaman.equals("home")) {
                        %>
                            <jsp:include page="admin_home.jsp" />
                        <%
                            } else if (halaman.equals("kelola_users")) {
                        %>
                            <jsp:include page="admin_users.jsp" />
                        <%
                            } else if (halaman.equals("kelola_airports")) {
                        %>
                            <jsp:include page="admin_airports.jsp" />
                        <%
                            } else if (halaman.equals("kelola_flights")) {
                        %>
                            <jsp:include page="admin_flights.jsp" />
                        <%
                            } else if (halaman.equals("laporan_bookings")) {
                        %>
                            <jsp:include page="admin_bookings.jsp" />
                        <%
                            }
                            else if (halaman.equals("database_schema")) {
                        %>
                            <jsp:include page="admin_database.jsp" /> <%
                                }
                        %>
                        
                    </div>
                </div>

            <%-- Layout Khusus User Biasa (Ada Navbar Atas) --%>
            <% } else { %>
                <jsp:include page="navbar.jsp" />
                
                <div class="container mt-4">
                    <%
                        if (halaman == null || halaman.equals("home")) {
                    %>
                        <jsp:include page="home.jsp" />
                    <%
                        } else if (halaman.equals("cari_hasil")) {
                    %>
                        <jsp:include page="hasil_pencarian.jsp" />
                    <%
                        } else if (halaman.equals("booking")) {
                    %>
                        <jsp:include page="booking.jsp" />
                    <%
                        } else if (halaman.equals("riwayat")) {
                    %>
                        <jsp:include page="riwayat.jsp" />
                    <%
                        } else if (halaman.equals("ticket")) {
                            // LOGIKA PENGAMBILAN DATA TIKET DISINI (SUDAH DIPERBAIKI)
                            
                            // 1. Ambil ID dari URL (index.jsp?halaman=ticket&id=10)
                            String idStr = request.getParameter("id");
                            
                            if(idStr != null) {
                                // 2. Panggil DAO untuk cari data tiket
                                com.flightease.dao.BookingDAO bDao = new com.flightease.dao.BookingDAO();
                                com.flightease.model.Booking tiket = bDao.getBookingById(Integer.parseInt(idStr));
                                
                                // 3. Simpan ke Request Attribute supaya bisa dibaca ticket.jsp
                                request.setAttribute("ticketDetail", tiket);
                            }
                    %>
                        <jsp:include page="ticket.jsp" />
                    <%
                        }
                    %>
                </div>
            <% } %>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>
        </html>
<%
    }
%>