package com.flightease.controller;

import com.flightease.dao.AirportDAO;
import com.flightease.model.Airport;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AirportServlet", urlPatterns = {"/AirportServlet"})
public class AirportServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        AirportDAO dao = new AirportDAO();

        try {
            if ("add".equals(action)) {
                // ===== TAMBAH BANDARA =====
                Airport a = new Airport();
                a.setCode(request.getParameter("code").toUpperCase());
                a.setName(request.getParameter("name"));
                a.setCity(request.getParameter("city"));
                
                if (dao.addAirport(a)) {
                    response.sendRedirect("index.jsp?halaman=kelola_airports&status=sukses_tambah");
                } else {
                    response.sendRedirect("index.jsp?halaman=kelola_airports&status=gagal");
                }

            } 
            else if ("update".equals(action)) {
                // ===== UPDATE BANDARA (INI YANG BARU) =====
                int id = Integer.parseInt(request.getParameter("id"));

                Airport a = new Airport();
                a.setId(id);
                a.setCode(request.getParameter("code").toUpperCase());
                a.setName(request.getParameter("name"));
                a.setCity(request.getParameter("city"));

                if (dao.updateAirport(a)) {
                    response.sendRedirect("index.jsp?halaman=kelola_airports&status=sukses_update");
                } else {
                    response.sendRedirect("index.jsp?halaman=kelola_airports&status=gagal");
                }
            } 
            else if ("delete".equals(action)) {
                // ===== HAPUS BANDARA =====
                int id = Integer.parseInt(request.getParameter("id"));
                boolean sukses = dao.deleteAirport(id);
                
                if (sukses) {
                    response.sendRedirect("index.jsp?halaman=kelola_airports&status=sukses_hapus");
                } else {
                    response.sendRedirect("index.jsp?halaman=kelola_airports&status=gagal_hapus_fk");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?halaman=kelola_airports&status=error");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
