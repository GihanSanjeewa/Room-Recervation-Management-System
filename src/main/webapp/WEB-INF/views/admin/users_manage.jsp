<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5">
  <h5 class="section-title">ADMIN • MANAGE USERS & STAFF</h5>
  <p class="muted">Change roles (USER/STAFF/ADMIN) and block/unblock accounts.</p>

  <div class="table-responsive border rounded-4 p-2 mt-3">
    <table class="table align-middle mb-0">
      <thead>
      <tr>
        <th>ID</th><th>Name</th><th>Email</th><th>Role</th><th class="text-end">Actions</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="u" items="${users}">
        <tr>
          <td>${u.id}</td>
          <td>${u.fullName}</td>
          <td>${u.email}</td>
          <td style="min-width:220px;">
            <form class="d-flex gap-2" method="post" action="<c:url value='/admin/user/update-role'/>">
              <input type="hidden" name="userId" value="${u.id}">
              <select class="form-select form-select-sm" name="role">
                <option value="USER" ${u.role=='USER'?'selected':''}>USER</option>
                <option value="STAFF" ${u.role=='STAFF'?'selected':''}>STAFF</option>
                <option value="ADMIN" ${u.role=='ADMIN'?'selected':''}>ADMIN</option>
              </select>
              <button class="btn btn-sm btn-outline-dark">Save</button>
            </form>
          </td>
          <td class="text-end">
            <form class="d-inline" method="post" action="<c:url value='/admin/user/block'/>"
                  onsubmit="return confirm('Block this user?');">
              <input type="hidden" name="userId" value="${u.id}">
              <button class="btn btn-sm btn-outline-danger">Block</button>
            </form>
            <form class="d-inline" method="post" action="<c:url value='/admin/user/unblock'/>">
              <input type="hidden" name="userId" value="${u.id}">
              <button class="btn btn-sm btn-outline-success">Unblock</button>
            </form>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
