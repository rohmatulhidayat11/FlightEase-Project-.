<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.flightease.dao.AirportDAO"%>
<%@page import="com.flightease.model.Airport"%>

<%
    String idStr = request.getParameter("id");
    Airport airport = null;

    if (idStr != null) {
        int id = Integer.parseInt(idStr);
        AirportDAO dao = new AirportDAO();
        airport = dao.getAirportById(id);
    }

    if (airport == null) {
%>
    <h3>Data bandara tidak ditemukan.</h3>
<%
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Bandara</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-4">
    <h4>Edit Data Bandara</h4>

    <form action="AirportServlet" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= airport.getId() %>">

        <div class="mb-3">
            <label>Kode Bandara</label>
            <input type="text" name="code" class="form-control"
                   value="<%= airport.getCode() %>" required>
        </div>

        <div class="mb-3">
            <label>Nama Bandara</label>
            <input type="text" name="name" class="form-control"
                   value="<%= airport.getName() %>" required>
        </div>

        <div class="mb-3">
            <label>Kota</label>
            <input type="text" name="city" class="form-control"
                   value="<%= airport.getCity() %>" required>
        </div>

        <button type="submit" class="btn btn-success">Simpan Perubahan</button>
        <a href="index.jsp?halaman=kelola_airports" class="btn btn-secondary">Batal</a>
    </form>
</div>

</body>
</html>
