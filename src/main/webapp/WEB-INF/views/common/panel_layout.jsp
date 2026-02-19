<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="com.hotel.model.User" %>
<%
  User panelAuthUser = (User) session.getAttribute("authUser");
  String role = (panelAuthUser != null) ? panelAuthUser.getRole() : "";
  String uri = request.getRequestURI();
%>

<div class="panel-shell lux-grid">
  <div class="container">

    <div class="panel-wrap">

      <!-- Sidebar -->
      <aside class="panel-sidebar glass-card">
        <div class="side-brand">
          <div class="brand-mark"><i class="bi bi-water"></i></div>
          <div>
            <div class="brand-title">OCEAN VIEW</div>
            <div class="brand-sub">Control Panel</div>
          </div>
        </div>

        <div class="side-user">
          <div class="avatar">
            <i class="bi bi-person-circle"></i>
          </div>
          <div>
            <div class="fw-semibold"><%= (panelAuthUser!=null?panelAuthUser.getFullName():"") %></div>
            <div class="muted small">Role: <b><%= role %></b></div>
          </div>
        </div>

        <div class="side-section">NAVIGATION</div>

        <% if ("STAFF".equals(role)) { %>
          <a class="side-link <%= uri.contains("/staff/dashboard") ? "active" : "" %>"
             href="<c:url value='/staff/dashboard'/>">
            <i class="bi bi-speedometer2"></i> Dashboard
          </a>

          <a class="side-link <%= uri.contains("/staff/reservations") ? "active" : "" %>"
             href="<c:url value='/staff/reservations'/>">
            <i class="bi bi-journal-check"></i> Reservations
          </a>

          <a class="side-link <%= uri.contains("/staff/reports") ? "active" : "" %>"
             href="<c:url value='/staff/reports'/>">
            <i class="bi bi-bar-chart-line"></i> Reports
          </a>
        <% } %>

        <% if ("ADMIN".equals(role)) { %>
          <a class="side-link <%= uri.contains("/admin/dashboard") ? "active" : "" %>"
             href="<c:url value='/admin/dashboard'/>">
            <i class="bi bi-speedometer2"></i> Dashboard
          </a>

          <a class="side-link <%= uri.contains("/admin/rooms") ? "active" : "" %>"
             href="<c:url value='/admin/rooms'/>">
            <i class="bi bi-door-open"></i> Rooms
          </a>

          <a class="side-link <%= uri.contains("/admin/reservations") ? "active" : "" %>"
             href="<c:url value='/admin/reservations'/>">
            <i class="bi bi-journal-check"></i> Reservations
          </a>

          <a class="side-link <%= uri.contains("/admin/users") ? "active" : "" %>"
             href="<c:url value='/admin/users'/>">
            <i class="bi bi-people"></i> Users / Staff
          </a>

          <a class="side-link <%= uri.contains("/admin/reports") ? "active" : "" %>"
             href="<c:url value='/admin/reports'/>">
            <i class="bi bi-bar-chart-line"></i> Reports
          </a>
        <% } %>

        <div class="lux-divider"></div>

        <a class="side-link" href="<c:url value='/home'/>">
          <i class="bi bi-globe2"></i> Public Site
        </a>

        <a class="side-link danger" href="<c:url value='/logout'/>">
          <i class="bi bi-box-arrow-right"></i> Logout
        </a>
      </aside>

      <!-- Main -->
      <main class="panel-main">

        <!-- Top bar -->
        <div class="panel-top glass-card">
          <div class="d-flex justify-content-between align-items-start flex-wrap gap-3">
            <div>
              <div class="lux-badge">CONTROL PANEL</div>
              <div class="panel-title mt-2">
                Welcome, <%= (panelAuthUser!=null?panelAuthUser.getFullName():"") %>
              </div>
              <div class="muted">Manage reservations and system operations.</div>
            </div>

            <div class="top-actions d-flex gap-2 align-items-center">
              <div class="date-pill">
                <i class="bi bi-calendar3"></i>
                <span><%= java.time.LocalDate.now() %></span>
              </div>

              <a class="btn btn-gold btn-sm" href="<c:url value='/home'/>">
                <i class="bi bi-globe2 me-1"></i> View Site
              </a>
            </div>
          </div>
        </div>

        <!-- Page content starts here -->
        <div class="panel-content">
          <!-- your page body will be included after this -->
      </div> <!-- /panel-content -->
      </main>
    </div> <!-- /panel-wrap -->

  </div>
</div>
