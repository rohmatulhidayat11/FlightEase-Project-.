<%@page import="com.flightease.dao.FlightDAO"%>
<%@page import="com.flightease.dao.AirportDAO"%>
<%@page import="com.flightease.model.Flight"%>
<%@page import="com.flightease.model.Airport"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
    int id = Integer.parseInt(request.getParameter("id"));

    FlightDAO fDao = new FlightDAO();
    AirportDAO aDao = new AirportDAO();

    Flight flight = fDao.getFlightById(id);
    List<Airport> airports = aDao.getAllAirports();

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
%>

<div class="card shadow border-0">
    <div class="card-header bg-warning">
        <h6 class="mb-0 fw-bold">
            <i class="bi bi-pencil-square"></i> Edit Jadwal Penerbangan
        </h6>
    </div>

    <div class="card-body">
        <form action="FlightServlet" method="post">

            <!-- WAJIB -->
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= flight.getId() %>">

            <!-- Nomor Penerbangan -->
            <div class="mb-3">
                <label class="fw-bold">Nomor Penerbangan</label>
                <input type="text" name="flight_number"
                       class="form-control"
                       value="<%= flight.getFlightNumber() %>" required>
            </div>

            <!-- Dari -->
            <div class="mb-3">
                <label class="fw-bold">Dari</label>
                <select name="origin_id" class="form-select" required>
                    <% for (Airport a : airports) { %>
                        <option value="<%= a.getId() %>"
                            <%= a.getCity().equals(flight.getOrigin().getCity()) ? "selected" : "" %>>
                            <%= a.getCity() %> (<%= a.getCode() %>)
                        </option>
                    <% } %>
                </select>
            </div>

            <!-- Ke -->
            <div class="mb-3">
                <label class="fw-bold">Ke</label>
                <select name="destination_id" class="form-select" required>
                    <% for (Airport a : airports) { %>
                        <option value="<%= a.getId() %>"
                            <%= a.getCity().equals(flight.getDestination().getCity()) ? "selected" : "" %>>
                            <%= a.getCity() %> (<%= a.getCode() %>)
                        </option>
                    <% } %>
                </select>
            </div>

            <!-- Waktu -->
            <div class="mb-3">
                <label class="fw-bold">Waktu Berangkat</label>
                <input type="datetime-local"
                       name="departure_time"
                       class="form-control"
                       value="<%= sdf.format(flight.getDepartureTime()) %>"
                       required>
            </div>

            <!-- Harga -->
            <div class="mb-3">
                <label class="fw-bold">Harga Tiket (Rp)</label>
                <input type="number"
                       name="price"
                       class="form-control"
                       value="<%= flight.getPrice() %>"
                       required>
            </div>

            <!-- Tombol -->
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success">
                    <i class="bi bi-save"></i> Simpan Perubahan
                </button>
                <a href="index.jsp?halaman=kelola_flights" class="btn btn-secondary">
                    Batal
                </a>
            </div>

        </form>
    </div>
</div>
