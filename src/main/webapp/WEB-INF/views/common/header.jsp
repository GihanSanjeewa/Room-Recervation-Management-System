<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Ocean View Resorts</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="<c:url value='/assets/css/theme.css'/>">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
  
  
  <style>
    :root{
      --lux-dark:#0b1f2a;
      --lux-gold:#c8a97e;
      --lux-muted:#6c7a86;
    }
    body{ font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial; }
    .navbar{ background: rgba(11,31,42,.92); }
    .navbar-brand{ letter-spacing:.12em; color:#fff!important; }
    .nav-link{ color:#fff!important; opacity:.9; }
    .nav-link:hover{ opacity:1; color: var(--lux-gold)!important; }

    .hero{
      min-height: 78vh;
      background: linear-gradient(180deg, rgba(0,0,0,.55), rgba(0,0,0,.15)),
                  url("<c:url value='/assets/img/hero.jpg'/>") center/cover no-repeat;
      display:flex; align-items:center;
      color:white;
    }
    .hero h1{ font-size: clamp(2rem, 5vw, 3.6rem); letter-spacing:.06em; }
    .hero p{ max-width: 52rem; color: rgba(255,255,255,.92); }

    .booking-bar{
      background:#fff; border-radius:16px; box-shadow: 0 12px 30px rgba(0,0,0,.15);
      padding:14px; margin-top: 18px;
    }
    .lux-badge{ color: var(--lux-gold); letter-spacing:.18em; font-weight:600; }
    .card-room{ border:0; border-radius:18px; overflow:hidden; box-shadow:0 10px 26px rgba(0,0,0,.08); }
    .card-room .price{ color: var(--lux-gold); font-weight:700; }
    .btn-gold{ background: var(--lux-gold); border:0; color:#111; font-weight:600; }
    .btn-gold:hover{ filter: brightness(.95); }
    .section-title{ letter-spacing:.12em; font-weight:700; color: var(--lux-dark); }
    .muted{ color: var(--lux-muted); }
    footer{ background: var(--lux-dark); color:#cfe3ef; }
    
    
    /* Navbar modern lux */
.navbar{
  background: rgba(11,31,42,.82) !important;
  backdrop-filter: blur(10px);
  border-bottom: 1px solid rgba(255,255,255,.08);
}

.navbar .navbar-brand{
  letter-spacing:.18em;
  font-weight:800;
  display:flex;
  align-items:center;
  gap:.55rem;
}

.navbar .navbar-brand i{
  color: var(--lux-gold);
  font-size: 1.2rem;
}

.navbar .nav-link{
  display:flex;
  align-items:center;
  gap:.45rem;
  padding: .55rem .85rem !important;
  border-radius: 999px;
  transition: .2s ease;
}

.navbar .nav-link:hover{
  background: rgba(200,169,126,.14);
  color: #fff !important;
}

.navbar .nav-link.active{
  background: rgba(255,255,255,.10);
  color:#fff !important;
}

.navbar .nav-pill{
  padding: .55rem .95rem !important;
  border-radius: 999px;
  font-weight: 700;
}

.navbar .nav-pill.gold{
  background: var(--lux-gold);
  color: #111 !important;
}

.navbar .nav-pill.gold:hover{
  filter: brightness(.95);
}

.navbar .nav-pill.outline{
  border: 1px solid rgba(255,255,255,.35);
  color:#fff !important;
}

.navbar .nav-pill.outline:hover{
  border-color: rgba(200,169,126,.9);
}

/* Dropdown modern */
.dropdown-menu{
  border: 1px solid rgba(0,0,0,.08);
  border-radius: 16px;
  box-shadow: 0 18px 40px rgba(0,0,0,.14);
  padding: 8px;
}

.dropdown-item{
  border-radius: 12px;
  padding: 10px 12px;
  font-weight: 600;
}

.dropdown-item i{
  margin-right: 8px;
  opacity: .85;
}

.dropdown-item:hover{
  background: rgba(200,169,126,.14);
}

/* Optional: make collapse menu glass on mobile */
@media (max-width: 992px){
  .nav-glass{
    margin-top: 10px;
    padding: 10px;
    border-radius: 16px;
    background: rgba(255,255,255,.08);
    border: 1px solid rgba(255,255,255,.10);
    backdrop-filter: blur(10px);
  }
}
    
  </style>
</head>
<body>
<%@ page import="com.hotel.model.User" %>
<%
  User authUser = null;
  if (session != null) authUser = (User) session.getAttribute("authUser");
%>
<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
  <div class="container">
    <a class="navbar-brand" href="<c:url value='/home'/>">
      <i class="bi bi-water"></i> OCEAN VIEW RESORTS
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse nav-glass" id="nav">
      <ul class="navbar-nav ms-auto align-items-lg-center gap-lg-1">

        <% if (authUser != null) { %>

          <li class="nav-item">
            <a class="nav-link <%= request.getRequestURI().contains("/my-reservations") ? "active" : "" %>"
               href="<c:url value='/my-reservations'/>">
              <i class="bi bi-journal-check"></i> My Reservations
            </a>
          </li>

          <% if ("STAFF".equals(authUser.getRole())) { %>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle"
                 href="#" role="button" data-bs-toggle="dropdown">
                <i class="bi bi-person-badge"></i> Staff Panel
              </a>
              <ul class="dropdown-menu dropdown-menu-end">
                <li>
                  <a class="dropdown-item" href="<c:url value='/staff/dashboard'/>">
                    <i class="bi bi-speedometer2"></i> Dashboard
                  </a>
                </li>
                <li>
                  <a class="dropdown-item" href="<c:url value='/staff/reservations'/>">
                    <i class="bi bi-journal-text"></i> Manage Reservations
                  </a>
                </li>
                <li>
                  <a class="dropdown-item" href="<c:url value='/staff/reports'/>">
                    <i class="bi bi-bar-chart-line"></i> Reports
                  </a>
                </li>
              </ul>
            </li>
          <% } %>

          <% if ("ADMIN".equals(authUser.getRole())) { %>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle"
                 href="#" role="button" data-bs-toggle="dropdown">
                <i class="bi bi-shield-lock"></i> Admin Panel
              </a>
              <ul class="dropdown-menu dropdown-menu-end">
                <li>
                  <a class="dropdown-item" href="<c:url value='/admin/dashboard'/>">
                    <i class="bi bi-speedometer2"></i> Dashboard
                  </a>
                </li>
                <li>
                  <a class="dropdown-item" href="<c:url value='/admin/rooms'/>">
                    <i class="bi bi-door-open"></i> Manage Rooms
                  </a>
                </li>
                <li>
                  <a class="dropdown-item" href="<c:url value='/admin/reservations'/>">
                    <i class="bi bi-journal-check"></i> Manage Reservations
                  </a>
                </li>
                <li>
                  <a class="dropdown-item" href="<c:url value='/admin/users'/>">
                    <i class="bi bi-people"></i> Manage Users/Staff
                  </a>
                </li>
                <li>
                  <a class="dropdown-item" href="<c:url value='/admin/reports'/>">
                    <i class="bi bi-bar-chart-line"></i> Reports
                  </a>
                </li>
              </ul>
            </li>
          <% } %>

          <li class="nav-item ms-lg-2">
            <a class="nav-link nav-pill outline" href="<c:url value='/logout'/>">
              <i class="bi bi-box-arrow-right"></i> Logout
            </a>
          </li>

        <% } else { %>

          <li class="nav-item">
            <a class="nav-link nav-pill outline" href="<c:url value='/login'/>">
              <i class="bi bi-person"></i> Login
            </a>
          </li>

          <li class="nav-item">
            <a class="nav-link nav-pill gold" href="<c:url value='/register'/>">
              <i class="bi bi-person-plus"></i> Register
            </a>
          </li>

        <% } %>

      </ul>
    </div>
  </div>
</nav>

