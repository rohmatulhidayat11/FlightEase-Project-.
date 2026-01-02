<%@page import="com.flightease.model.User"%>
<%@page import="java.util.List"%>
<%@page import="com.flightease.dao.UserDAO"%>
<%
    UserDAO dao = new UserDAO();
    List<User> list = dao.getAllUsers();
%>

<div class="card shadow border-0">
    <div class="card-header bg-dark text-white">
        <h5 class="mb-0"><i class="bi bi-people-fill"></i> Data Pengguna Terdaftar</h5>
    </div>
    <div class="card-body p-0">
        <table class="table table-striped table-hover mb-0">
            <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>Nama Lengkap</th>
                    <th>Username</th>
                    <th>Role</th>
                </tr>
            </thead>
            <tbody>
                <% if (list != null) { %>
                <% for (User u : list) {%>
                <tr>
                    <td><%= u.getId()%></td>
                    <td><%= (u.getFullname() != null) ? u.getFullname() : "-"%></td>
                    <td class="fw-bold text-primary"><%= u.getUsername()%></td>
                    <td>
                        <% if ("admin".equals(u.getRole())) { %>
                        <span class="badge bg-danger">ADMIN</span>
                        <% } else { %>
                        <span class="badge bg-secondary">USER</span>
                        <% } %>
                    </td>
                </tr>
                <% } %>
                <% }%>
            </tbody>
        </table>
    </div>
</div>