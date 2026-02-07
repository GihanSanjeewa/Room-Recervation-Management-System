<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5" style="max-width:560px;">
  <h5 class="section-title">REGISTER</h5>

  <c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
  </c:if>

  <div class="border rounded-4 p-4">
    <form method="post" action="<c:url value='/register'/>">
      <div class="mb-3">
        <label class="form-label">Full Name</label>
        <input class="form-control" name="fullName" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Email</label>
        <input class="form-control" type="email" name="email" required>
      </div>
      <div class="mb-3">
        <label class="form-label">Phone</label>
        <input class="form-control" name="phone">
      </div>
      <div class="mb-3">
        <label class="form-label">Password</label>
        <input class="form-control" type="password" name="password" required>
      </div>
      <button class="btn btn-gold w-100">Create Account</button>
    </form>
  </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
