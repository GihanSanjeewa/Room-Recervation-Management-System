<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="auth-wrap lux-grid">
  <div class="auth-card row g-0">

    <!-- Left: Brand / Image -->
    <div class="col-lg-6 auth-left">
      <span class="auth-pill">Ocean View Resorts</span>
      <h2 class="mt-3">Welcome back</h2>
      <p class="mt-2" style="max-width:26rem;opacity:.92;">
        Sign in to manage your reservations and enjoy a seamless booking experience.
      </p>

      <div class="auth-feature">
        <div class="icon"></div>
        <div>
          <div class="fw-bold">Luxury stays</div>
          <div style="opacity:.9">Elegant rooms and premium comfort.</div>
        </div>
      </div>
      <div class="auth-feature">
        <div class="icon"></div>
        <div>
          <div class="fw-bold">Instant confirmation</div>
          <div style="opacity:.9">Your reservation becomes Reserved immediately.</div>
        </div>
      </div>
      <div class="auth-feature">
        <div class="icon"></div>
        <div>
          <div class="fw-bold">Secure access</div>
          <div style="opacity:.9">Role-based dashboards for staff and admin.</div>
        </div>
      </div>
    </div>

    <!-- Right: Form -->
    <div class="col-lg-6 auth-right">
      <h5 class="section-title mb-1">LOGIN</h5>
      <div class="mini-note">Enter your credentials to continue.</div>

      <c:if test="${param.registered == '1'}">
        <div class="alert alert-success mt-3">Registration successful. Please login.</div>
      </c:if>

      <c:if test="${not empty error}">
        <div class="alert alert-danger mt-3">${error}</div>
      </c:if>

      <form class="mt-3" method="post" action="<c:url value='/login'/>">
        <div class="mb-3">
          <label class="form-label">Email</label>
          <input class="form-control auth-input" type="email" name="email" required>
        </div>
        <div class="mb-3">
          <label class="form-label">Password</label>
          <input class="form-control auth-input" type="password" name="password" required>
        </div>

        <button class="btn btn-lux w-100">Login</button>

        <div class="mini-note mt-3">
          Dont have an account?
          <a href="<c:url value='/register'/>">Create one</a>
        </div>

       
      </form>
    </div>

  </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
