<%@page import="com.flightease.model.Flight"%>
<%@page import="com.flightease.model.Airport"%>
<%@page import="java.util.List"%>
<%@page import="com.flightease.dao.FlightDAO"%>
<%@page import="com.flightease.dao.AirportDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
    FlightDAO fDao = new FlightDAO();
    List<Flight> flights = fDao.getAllFlights(); // Ini memanggil method yang baru kita tambah

    AirportDAO aDao = new AirportDAO();
    List<Airport> airports = aDao.getAllAirports();

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
%>

<div class="row">
    <div class="col-md-4">
        <div class="card shadow border-0 mb-3">
            <div class="card-header bg-info text-white">
                <h6 class="mb-0"><i class="bi bi-airplane-engines"></i> Tambah Jadwal</h6>
            </div>
            <div class="card-body">
                <form action="FlightServlet" method="POST">
                    <input type="hidden" name="action" value="add">

                    <div class="mb-2">
                        <label class="small fw-bold">No. Penerbangan</label>
                        <input type="text" name="flight_number" class="form-control" placeholder="Cth: GA-123" required>
                    </div>

                    <div class="mb-2">
                        <label class="small fw-bold">Dari</label>
                        <select name="origin_id" class="form-select" required>
                            <% for (Airport a : airports) {%>
                            <option value="<%= a.getId()%>"><%= a.getCity()%> (<%= a.getCode()%>)</option>
                            <% } %>
                        </select>
                    </div>

                    <div class="mb-2">
                        <label class="small fw-bold">Ke</label>
                        <select name="destination_id" class="form-select" required>
                            <% for (Airport a : airports) {%>
                            <option value="<%= a.getId()%>"><%= a.getCity()%> (<%= a.getCode()%>)</option>
                            <% } %>
                        </select>
                    </div>

                    <div class="mb-2">
                        <label class="small fw-bold">Waktu Berangkat</label>
                        <input type="datetime-local" name="departure_time" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="small fw-bold">Harga Tiket (Rp)</label>
                        <input type="number" name="price" class="form-control" placeholder="1500000" required>
                    </div>

                    <button type="submit" class="btn btn-info text-white w-100 fw-bold">Simpan Jadwal</button>
                </form>
            </div>
        </div>
    </div>

    <div class="col-md-8">
        <div class="card shadow border-0">
            <div class="card-header bg-white">
                <h6 class="mb-0 fw-bold">Jadwal Penerbangan Aktif</h6>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive" style="max-height: 500px;">
                    <table class="table table-striped mb-0 small align-middle">
                        <thead class="table-dark sticky-top">
                            <tr>
                                <th>No</th>
                                <th>Rute</th>
                                <th>Waktu</th>
                                <th>Harga</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (flights != null) { %>
                            <% for (Flight f : flights) {%>
                            <tr>
                                <td class="fw-bold"><%= f.getFlightNumber()%></td>
                                <td>
                                    <%= f.getOrigin().getCity()%> &rarr; <%= f.getDestination().getCity()%>
                                </td>
                                <td><%= sdf.format(f.getDepartureTime())%></td>
                                <td class="text-success fw-bold"><%= f.getFormattedPrice()%></td>
                                <td>
                                    <a href="FlightServlet?action=delete&id=<%= f.getId()%>" 
                                       class="btn btn-sm btn-danger py-0"
                                       onclick="return confirm('Hapus jadwal ini?')">
                                        <i class="bi bi-x"></i>
                                    </a>
                                </td>
                            </tr>
                            <% } %>
                            <% }%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>