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
        <div class="icon"> <i class="bi bi-door-open me-2"></i></div>
        <div>
          <div class="fw-bold">Luxury stays</div>
          <div style="opacity:.9">Elegant rooms and premium comfort.</div>
        </div>
      </div>
      <div class="auth-feature">
        <div class="icon"><i class="bi bi-amd"></i></div>
        <div>
          <div class="fw-bold">Instant confirmation</div>
          <div style="opacity:.9">Your reservation becomes Reserved immediately.</div>
        </div>
      </div>
      <div class="auth-feature">
        <div class="icon"><i class="bi bi-universal-access-circle"></i></div>
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
    <div class="alert alert-success mt-3 d-flex align-items-center gap-2">
      <i class="bi bi-check-circle-fill"></i>
      <div>Registration successful. Please login.</div>
    </div>
  </c:if>

  <c:if test="${not empty error}">
    <div class="alert alert-danger mt-3 d-flex align-items-center gap-2">
      <i class="bi bi-exclamation-triangle-fill"></i>
      <div>${error}</div>
    </div>
  </c:if>

  <form class="mt-3" method="post" action="<c:url value='/login'/>">

    <!-- Email -->
    <label class="form-label">Email</label>
    <div class="input-group mb-3">
      <span class="input-group-text bg-white">
        <i class="bi bi-envelope"></i>
      </span>
      <input class="form-control auth-input" type="email" name="email" placeholder="you@example.com" required>
    </div>

    <!-- Password -->
    <label class="form-label">Password</label>
    <div class="input-group mb-2">
      <span class="input-group-text bg-white">
        <i class="bi bi-lock"></i>
      </span>
      <input id="password" class="form-control auth-input" type="password" name="password" placeholder="Enter password" required>
      <button class="btn btn-outline-secondary" type="button" id="togglePw" aria-label="Show password">
        <i class="bi bi-eye"></i>
      </button>
    </div>

    <div class="d-flex justify-content-between align-items-center mb-3">
      <div class="form-check">
        <input class="form-check-input" type="checkbox" value="1" id="remember" name="remember">
        <label class="form-check-label small" for="remember">Remember me</label>
      </div>

      <a class="small text-decoration-none" href="<c:url value='/forgot-password'/>">
        Forgot password?
      </a>
    </div>

    <button class="btn btn-lux w-100 d-flex justify-content-center align-items-center gap-2" type="submit">
      <i class="bi bi-box-arrow-in-right"></i>
      <span>Login</span>
    </button>

    <div class="mini-note mt-3">
      Don’t have an account?
      <a href="<c:url value='/register'/>">Create one</a>
    </div>
  </form>

  <script>
    (function () {
      const pw = document.getElementById('password');
      const btn = document.getElementById('togglePw');
      if (!pw || !btn) return;

      btn.addEventListener('click', function () {
        const isPw = pw.type === 'password';
        pw.type = isPw ? 'text' : 'password';
        btn.innerHTML = isPw
          ? '<i class="bi bi-eye-slash"></i>'
          : '<i class="bi bi-eye"></i>';
      });
    })();
  </script>
</div>


  </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
