<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Ocean View Resorts</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
    <a class="navbar-brand" href="<c:url value='/home'/>">OCEAN VIEW RESORTS</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="nav">

	  <ul class="navbar-nav ms-auto align-items-lg-center">
	
	    <% if (authUser != null) { %>
	
	      <li class="nav-item">
	        <a class="nav-link" href="<c:url value='/my-reservations'/>">My Reservations</a>
	      </li>
	
	      <% if ("STAFF".equals(authUser.getRole())) { %>
		  <li class="nav-item dropdown">
		    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Staff Panel</a>
		    <ul class="dropdown-menu dropdown-menu-end">
		      <li><a class="dropdown-item" href="<c:url value='/staff/dashboard'/>">Dashboard</a></li>
		      <li><a class="dropdown-item" href="<c:url value='/staff/reservations'/>">Manage Reservations</a></li>
		    </ul>
		  </li>
		<% } %>
		
		<% if ("ADMIN".equals(authUser.getRole())) { %>
		  <li class="nav-item dropdown">
		    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Admin Panel</a>
		    <ul class="dropdown-menu dropdown-menu-end">
		      <li><a class="dropdown-item" href="<c:url value='/admin/rooms'/>">Manage Rooms</a></li>
		      <li><a class="dropdown-item" href="<c:url value='/admin/reservations'/>">Manage Reservations</a></li>
		      <li><a class="dropdown-item" href="<c:url value='/admin/users'/>">Manage Users/Staff</a></li>
		    </ul>
		  </li>
		<% } %>
	
	      <li class="nav-item">
	        <a class="nav-link" href="<c:url value='/logout'/>">Logout</a>
	      </li>
	
	    <% } else { %>
	
	      <li class="nav-item">
	        <a class="nav-link" href="<c:url value='/login'/>">Login</a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="<c:url value='/register'/>">Register</a>
	      </li>
	
	    <% } %>
	
	  </ul>
	
	</div>
  </div>
</nav>
