<%@page import="com.flightease.model.Airport"%>
<%@page import="java.util.List"%>
<%@page import="com.flightease.dao.AirportDAO"%>
<%
    AirportDAO aDao = new AirportDAO();
    List<Airport> airports = aDao.getAllAirports();
%>

<%-- BAGIAN NOTIFIKASI / ALERT --%>
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
        <i class="bi bi-trash me-2"></i>Bandara berhasil dihapus.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%      } else if(status.equals("sukses_update")) { %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="bi bi-pencil-square me-2"></i>Data Bandara berhasil diperbarui.
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%      } else if(status.equals("gagal_hapus_fk")) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="bi bi-exclamation-triangle-fill me-2"></i><strong>Gagal Menghapus!</strong> Bandara ini masih terikat dengan jadwal penerbangan aktif.
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
        <div class="card shadow border-0 mb-3">
            <div class="card-header bg-primary text-white">
                <h6 class="mb-0"><i class="bi bi-building"></i> Tambah Bandara</h6>
            </div>
            <div class="card-body">
                <form action="AirportServlet" method="POST">
                    <input type="hidden" name="action" value="add">
                    
                    <div class="mb-2">
                        <label class="small fw-bold">Kode Bandara</label>
                        <input type="text" name="code" class="form-control" placeholder="Cth: CGK" required>
                    </div>

                    <div class="mb-2">
                        <label class="small fw-bold">Nama Bandara</label>
                        <input type="text" name="name" class="form-control" placeholder="Cth: Soekarno-Hatta" required>
                    </div>

                    <div class="mb-3">
                        <label class="small fw-bold">Kota</label>
                        <input type="text" name="city" class="form-control" placeholder="Cth: Jakarta" required>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 fw-bold">Simpan Bandara</button>
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
                <div class="table-responsive" style="max-height: 500px;">
                    <table class="table table-striped mb-0 small align-middle">
                        <thead class="table-dark sticky-top">
                            <tr>
                                <th>Kode</th>
                                <th>Nama Bandara</th>
                                <th>Kota</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (airports != null) { %>
                            <% for (Airport a : airports) { %>
                            <tr>
                                <td class="fw-bold"><%= a.getCode() %></td>
                                <td><%= a.getName() %></td>
                                <td><%= a.getCity() %></td>
                                <td>
                                    <a href="index.jsp?halaman=edit_airport&id=<%= a.getId() %>" 
                                       class="btn btn-sm btn-warning py-0 me-1">
                                        <i class="bi bi-pencil"></i>
                                    </a>
                                    
                                    <a href="AirportServlet?action=delete&id=<%= a.getId() %>" 
                                       class="btn btn-sm btn-danger py-0"
                                       onclick="return confirm('Hapus bandara ini?')">
                                        <i class="bi bi-x"></i>
                                    </a>
                                </td>
                            </tr>
                            <% } } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>