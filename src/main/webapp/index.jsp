<%-- 
    Document   : index
    Created on : 25 Dec 2025
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.flightease.model.User"%>
<%@page import="com.flightease.model.Flight"%>
<%@page import="com.flightease.model.Booking"%>
<%@page import="com.flightease.dao.FlightDAO"%>
<%@page import="com.flightease.dao.BookingDAO"%>
<%@page import="java.util.List"%>

<%
    
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>FlightEase Travel</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&family=Playfair+Display:wght@700&display=swap" rel="stylesheet">

        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f4f6f9;
            }
            .bg-custom-blue {
                background-color: #17a2b8;
            }
            .bg-custom-orange {
                background-color: #fd7e14;
                color: white;
            }
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp" />
        <jsp:include page="navbar.jsp" />

        <div class="container-fluid mt-4 mb-5">
            <div class="row">

                <div class="col-md-3">
                    <jsp:include page="sidebar.jsp" />
                </div>

                <div class="col-md-9">
                    <%
                        String hal = request.getParameter("halaman");

                        // HALAMAN HOME 
                        if (hal == null || hal.equals("home")) {
                            // CEK ROLE: Jika Admin tampilkan Dashboard, Jika User tampilkan Pencarian
                            if (user.getRole().equals("admin")) {
                    %>
                    <jsp:include page="admin_home.jsp" />
                    <%
                    } else {
                    %>
                    <jsp:include page="home.jsp" />
                    <%
                    }
                        // PENCARIAN TIKET
                    } else if (hal.equals("cari_hasil")) {
                        String asal = request.getParameter("origin_id");
                        String tujuan = request.getParameter("destination_id");
                        String tgl = request.getParameter("tanggal");

                        if (asal != null && tujuan != null && tgl != null) {
                            try {
                                int oId = Integer.parseInt(asal);
                                int dId = Integer.parseInt(tujuan);
                                FlightDAO flightDao = new FlightDAO();
                                List<Flight> hasil = flightDao.searchFlights(oId, dId, tgl);
                                request.setAttribute("daftarPenerbangan", hasil);
                            } catch (Exception e) {
                                out.println("<div class='alert alert-danger'>Data pencarian tidak valid.</div>");
                            }
                        }
                    %>
                    <jsp:include page="hasil_pencarian.jsp" />

                    <%
                        // FORMULIR BOOKING
                    } else if (hal.equals("booking_form")) {
                        String idStr = request.getParameter("flight_id");
                        if (idStr != null) {
                            try {
                                FlightDAO flightDao = new FlightDAO();
                                Flight f = flightDao.getFlightById(Integer.parseInt(idStr));
                                request.setAttribute("flightDetail", f);
                            } catch (Exception e) {
                                out.println("<div class='alert alert-danger'>ID Penerbangan tidak valid.</div>");
                            }
                        }
                    %>
                    <jsp:include page="booking.jsp" />

                    <%
                        // RIWAYAT PESANAN
                    } else if (hal.equals("riwayat")) {
                        if (request.getParameter("status") != null && request.getParameter("status").equals("sukses")) {
                            out.println("<div class='alert alert-success fw-bold'><i class='bi bi-check-circle'></i> Pemesanan Berhasil! Tiket Anda telah diterbitkan.</div>");
                        }

                        BookingDAO bookingDao = new BookingDAO();
                        List<Booking> listHistory = bookingDao.getUserHistory(user.getId());
                        request.setAttribute("listHistory", listHistory);
                    %>
                    <jsp:include page="riwayat.jsp" />

                    <%
                        // E-TIKET (BOARDING PASS)
                    } else if (hal.equals("ticket")) {
                        String idStr = request.getParameter("id");
                        if (idStr != null) {
                            try {
                                int bookId = Integer.parseInt(idStr);
                                BookingDAO bDao = new BookingDAO();
                                Booking b = bDao.getBookingById(bookId);
                                request.setAttribute("ticketDetail", b);
                            } catch (Exception e) {
                                out.println("<div class='alert alert-danger'>ID Tiket salah.</div>");
                            }
                        }
                    %>
                    <jsp:include page="ticket.jsp" />

                    <%
                        // HALAMAN ADMIN
                        // KELOLA USERS
                    } else if (hal.equals("kelola_users")) {
                        if (!user.getRole().equals("admin")) {
                            out.println("<div class='alert alert-danger'>Akses Ditolak!</div>");
                        } else {
                    %>
                    <jsp:include page="admin_users.jsp" />
                    <%
                        }

                        // KELOLA AIRPORTS
                    } else if (hal.equals("kelola_airports")) {
                        if (!user.getRole().equals("admin")) {
                            out.println("<div class='alert alert-danger'>Akses Ditolak!</div>");
                        } else {
                    %>
                    <jsp:include page="admin_airports.jsp" />
                    <%
                        }

                        // KELOLA FLIGHTS
                    } else if (hal.equals("kelola_flights")) {
                        if (!user.getRole().equals("admin")) {
                            out.println("<div class='alert alert-danger'>Akses Ditolak!</div>");
                        } else {
                    %>
                    <jsp:include page="admin_flights.jsp" />
                    <%
                        }

                        // LAPORAN BOOKINGS
                    } else if (hal.equals("laporan_bookings")) {
                        if (!user.getRole().equals("admin")) {
                            out.println("<div class='alert alert-danger'>Akses Ditolak!</div>");
                        } else {
                    %>
                    <jsp:include page="admin_bookings.jsp" />
                    <%
                            }

                        } else {
                            out.println("<div class='alert alert-danger'>Halaman tidak ditemukan!</div>");
                        }
                    %>
                </div>

            </div>
        </div>

        <jsp:include page="footer.jsp" />

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>