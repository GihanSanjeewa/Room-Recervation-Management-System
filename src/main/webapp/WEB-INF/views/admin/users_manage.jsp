<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<style>
.table tbody tr:hover{
  background: rgba(200,169,126,.10);
}
.table thead th{
  border-bottom: 1px solid rgba(0,0,0,.08) !important;
}
.btn{
  border-radius: 999px;
  font-weight: 700;
}
.input-group-text{
  border-radius: 14px 0 0 14px;
}
.form-select, .form-control{
  border-radius: 0 14px 14px 0;
}

</style>
<div class="container py-5">

  <!-- Title / Header -->
  <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-end gap-2">
    <div>
      <div class="lux-badge mb-1">ADMIN</div>
      <h4 class="mb-1" style="color:var(--lux-dark);font-weight:800;letter-spacing:.06em;">
        Manage Users & Staff
      </h4>
      <div class="muted">
        Change roles (USER/STAFF/ADMIN) and block/unblock accounts.
      </div>
    </div>

    <div class="text-md-end">
      <div class="mini-note">Total Accounts</div>
      <div class="fw-bold" style="font-size:1.15rem;">
        <i class="bi bi-people"></i> <c:out value="${users.size()}"/>
      </div>
    </div>
  </div>

  <!-- Card -->
  <div class="mt-4 p-3 p-md-4 rounded-4"
       style="background:rgba(255,255,255,.85);border:1px solid rgba(0,0,0,.06);
              box-shadow:0 12px 30px rgba(0,0,0,.08);backdrop-filter: blur(10px);">

    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-2 mb-3">
      <div class="fw-bold">
        <i class="bi bi-shield-lock"></i> Accounts Control
      </div>
      <div class="muted small">
        Tip: Use role dropdown then click <b>Save</b>.
      </div>
    </div>

    <div class="table-responsive">
      <table class="table align-middle mb-0">
        <thead>
        <tr style="color:var(--lux-dark);">
          <th style="width:80px;">ID</th>
          <th>Name</th>
          <th>Email</th>
          <th style="min-width:280px;">Role</th>
          <th class="text-end" style="min-width:220px;">Actions</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="u" items="${users}">
          <tr style="border-top:1px solid rgba(0,0,0,.06);">

            <td class="fw-bold">#${u.id}</td>

            <td>
              <div class="d-flex align-items-center gap-2">
                <div class="rounded-circle d-flex align-items-center justify-content-center"
                     style="width:38px;height:38px;background:rgba(200,169,126,.18);color:var(--lux-dark);">
                  <i class="bi bi-person"></i>
                </div>
                <div>
                  <div class="fw-bold">${u.fullName}</div>

                  <!-- Role badge -->
                  <div class="small">
                    <c:choose>
                      <c:when test="${u.role == 'ADMIN'}">
                        <span class="badge rounded-pill text-bg-dark">
                          <i class="bi bi-shield-lock"></i> ADMIN
                        </span>
                      </c:when>
                      <c:when test="${u.role == 'STAFF'}">
                        <span class="badge rounded-pill text-bg-primary">
                          <i class="bi bi-person-badge"></i> STAFF
                        </span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge rounded-pill text-bg-secondary">
                          <i class="bi bi-person"></i> USER
                        </span>
                      </c:otherwise>
                    </c:choose>
                  </div>

                </div>
              </div>
            </td>

            <td class="muted">
              <i class="bi bi-envelope"></i> ${u.email}
            </td>

            <td>
              <form class="d-flex gap-2" method="post" action="<c:url value='/admin/user/update-role'/>">
                <input type="hidden" name="userId" value="${u.id}">

                <div class="input-group">
                  <span class="input-group-text bg-white">
                    <i class="bi bi-person-gear"></i>
                  </span>

                  <select class="form-select" name="role">
                    <option value="USER" ${u.role=='USER'?'selected':''}>USER</option>
                    <option value="STAFF" ${u.role=='STAFF'?'selected':''}>STAFF</option>
                    <option value="ADMIN" ${u.role=='ADMIN'?'selected':''}>ADMIN</option>
                  </select>
                </div>

                <button class="btn btn-gold">
                  <i class="bi bi-check2-circle"></i> Save
                </button>
              </form>
            </td>

            <td class="text-end">
              <div class="d-inline-flex gap-2">

                <form class="d-inline" method="post" action="<c:url value='/admin/user/block'/>"
                      onsubmit="return confirm('Block this user?');">
                  <input type="hidden" name="userId" value="${u.id}">
                  <button class="btn btn-outline-danger">
                    <i class="bi bi-slash-circle"></i> Block
                  </button>
                </form>

                <form class="d-inline" method="post" action="<c:url value='/admin/user/unblock'/>"
                      onsubmit="return confirm('Unblock this user?');">
                  <input type="hidden" name="userId" value="${u.id}">
                  <button class="btn btn-outline-success">
                    <i class="bi bi-unlock"></i> Unblock
                  </button>
                </form>

              </div>
            </td>

          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>

  </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
