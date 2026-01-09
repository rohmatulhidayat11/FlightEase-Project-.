<%-- 
    Document   : admin_airports
    Created on : 25 Dec 2025, 18.33.43
    Author     : user
--%>

<%@page import="com.flightease.model.Airport"%>
<%@page import="java.util.List"%>
<%@page import="com.flightease.dao.AirportDAO"%>
<%
    
    AirportDAO dao = new AirportDAO();
    List<Airport> list = dao.getAllAirports();
%>
<%
    String status = request.getParameter("status");
    if(status != null) {
        if(status.equals("sukses_tambah")) {
%>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-check-circle me-2"></i>Data Bandara berhasil ditambahkan.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%      } else if(status.equals("sukses_hapus")) { %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-trash me-2"></i>Data Bandara berhasil dihapus.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%      } else if(status.equals("gagal_hapus_fk")) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="bi bi-exclamation-triangle-fill me-2"></i><strong>Gagal Menghapus!</strong> Bandara ini sedang digunakan dalam jadwal penerbangan. Hapus jadwal terkait terlebih dahulu.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%      } else { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="bi bi-x-circle me-2"></i>Terjadi kesalahan sistem.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%      }
    }
%>
<div class="row">
    <div class="col-md-4">
        <div class="card shadow border-0">
            <div class="card-header bg-primary text-white">
                <h6 class="mb-0"><i class="bi bi-plus-circle"></i> Tambah Bandara</h6>
            </div>
            <div class="card-body">
                <form action="AirportServlet" method="POST">
                    <input type="hidden" name="action" value="add">
                    
                    <div class="mb-3">
                        <label>Kode Bandara (3 Huruf)</label>
                        <input type="text" name="code" class="form-control" placeholder="Contoh: CGK" maxlength="3" required>
                    </div>
                    <div class="mb-3">
                        <label>Nama Bandara</label>
                        <input type="text" name="name" class="form-control" placeholder="Soekarno Hatta Intl" required>
                    </div>
                    <div class="mb-3">
                        <label>Kota</label>
                        <input type="text" name="city" class="form-control" placeholder="Jakarta" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary w-100">Simpan Data</button>
                </form>
            </div>
        </div>
    </div>

    <div class="col-md-8">
        <div class="card shadow border-0">
            <div class="card-header bg-white">
                <h6 class="mb-0 fw-bold">Daftar Bandara</h6>
            </div>
            <div class="card-body p-0">
                <table class="table table-striped mb-0">
                    <thead class="table-dark">
                        <tr>
                            <th>Kode</th>
                            <th>Nama Bandara</th>
                            <th>Kota</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Airport a : list) { %>
                        <tr>
                            <td class="fw-bold"><%= a.getCode() %></td>
                            <td><%= a.getName() %></td>
                            <td><%= a.getCity() %></td>
                            <td>
                                <a href="AirportServlet?action=delete&id=<%= a.getId() %>" 
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Yakin ingin menghapus bandara ini?')">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
