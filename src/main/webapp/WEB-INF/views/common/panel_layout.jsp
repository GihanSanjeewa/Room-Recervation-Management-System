<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.hotel.model.User" %>
<%
  User panelAuthUser = (User) session.getAttribute("authUser");
  String role = (panelAuthUser != null) ? panelAuthUser.getRole() : "";
  String uri = request.getRequestURI();
%>

<div class="container panel">

  <aside class="sidebar">
    <div class="brand">OCEAN VIEW</div>
    <div class="role">
      Signed in as <b><%= (panelAuthUser!=null?panelAuthUser.getFullName():"") %></b><br/>
      Role: <b><%= role %></b>
    </div>

    <div class="px-3 pb-2" style="opacity:.6;font-size:.8rem;letter-spacing:.14em;">NAVIGATION</div>

    <% if ("STAFF".equals(role)) { %>
      <a class="side-link <%= uri.contains("/staff/dashboard") ? "active" : "" %>" href="<c:url value='/staff/dashboard'/>">📌 Dashboard</a>
      <a class="side-link <%= uri.contains("/staff/reservations") ? "active" : "" %>" href="<c:url value='/staff/reservations'/>"> Reservations</a>
      <a class="side-link <%= uri.contains("/staff/reports") ? "active" : "" %>" href="<c:url value='/staff/reports'/>"> Reports</a>
    <% } %>

    <% if ("ADMIN".equals(role)) { %>
      <a class="side-link <%= uri.contains("/admin/rooms") ? "active" : "" %>" href="<c:url value='/admin/rooms'/>"> Rooms</a>
      <a class="side-link <%= uri.contains("/admin/reservations") ? "active" : "" %>" href="<c:url value='/admin/reservations'/>"> Reservations</a>
      <a class="side-link <%= uri.contains("/admin/users") ? "active" : "" %>" href="<c:url value='/admin/users'/>"> Users/Staff</a>
      <a class="side-link <%= uri.contains("/admin/reports") ? "active" : "" %>" href="<c:url value='/admin/reports'/>"> Reports</a>
    <% } %>

    <div class="lux-divider"></div>

    <a class="side-link" href="<c:url value='/home'/>"> Public Site</a>
    <a class="side-link" href="<c:url value='/logout'/>"> Logout</a>
  </aside>

  <main class="panel-main">
    <!-- Optional top header container for each page -->
    <div class="panel-top glass-card">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <div class="section-badge">Control Panel</div>
          <div class="fw-bold mt-2" style="font-size:1.25rem;">Welcome, <%= (panelAuthUser!=null?panelAuthUser.getFullName():"") %></div>
          <div class="muted">Manage reservations and system operations.</div>
        </div>
        <div class="text-end">
          <div class="mini-note">Today</div>
          <div class="fw-bold"><%= java.time.LocalDate.now() %></div>
        </div>
      </div>
    </div>

    <!-- Page body starts after this include -->
    
  </main>
</div>
