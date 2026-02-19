<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="auth-wrap lux-grid">
  <div class="auth-card row g-0">

    <div class="col-lg-6 auth-left">
      <span class="auth-pill">Ocean View Resorts</span>
      <h2 class="mt-3">Create your account</h2>
      <p class="mt-2" style="max-width:26rem;opacity:.92;">
        Register to reserve rooms, manage bookings, and enjoy a premium experience.
      </p>

      <div class="auth-feature">
        <div class="icon"><i class="bi bi-emoji-smile"></i></div>
        <div>
          <div class="fw-bold">Smart availability</div>
          <div style="opacity:.9">Search rooms by dates and guests.</div>
        </div>
      </div>
      <div class="auth-feature">
        <div class="icon"><i class="bi bi-door-open me-2"></i></div>
        <div>
          <div class="fw-bold">Elegant stays</div>
          <div style="opacity:.9">Comfortable interiors and service.</div>
        </div>
      </div>
      <div class="auth-feature">
        <div class="icon"><i class="bi bi-journal-bookmark-fill"></i></div>
        <div>
          <div class="fw-bold">Instant booking</div>
          <div style="opacity:.9">Reservations are instantly confirmed as Reserved.</div>
        </div>
      </div>
    </div>

    <div class="col-lg-6 auth-right">
      <h5 class="section-title mb-1">REGISTER</h5>
      <div class="mini-note">Fill the details to create an account.</div>

      <c:if test="${not empty error}">
        <div class="alert alert-danger mt-3">${error}</div>
      </c:if>

      <form class="mt-3" method="post" action="<c:url value='/register'/>">
        <div class="mb-3">
          <label class="form-label" style="color:rgb(4,2,0);font-weight:600;">Full Name</label>
          <input class="form-control auth-input"  name="fullName" required>
        </div>
        <div class="mb-3">
          <label class="form-label" style="color:rgb(4,2,0);font-weight:600;">Email</label>
          <input class="form-control auth-input" type="email" name="email" required>
        </div>
        <div class="mb-3">
          <label class="form-label" style="color:rgb(4,2,0);font-weight:600;">Phone</label>
          <input class="form-control auth-input" name="phone">
        </div>
        <div class="mb-3">
          <label class="form-label" style="color:rgb(4,2,0);font-weight:600;">Password</label>
          <input class="form-control auth-input" type="password" name="password" required>
        </div>

        <button class="btn btn-lux w-100">Create Account</button>

        <div class="mini-note mt-3">
          Already have an account?
          <a href="<c:url value='/login'/>">Login</a>
        </div>
      </form>
    </div>

  </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
