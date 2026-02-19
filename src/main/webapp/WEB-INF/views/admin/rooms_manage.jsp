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
.badge{
  font-weight: 700;
  letter-spacing: .04em;
}

</style>
<div class="container py-5">

  <!-- Header -->
  <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-end gap-2">
    <div>
      <div class="lux-badge mb-1">ADMIN</div>
      <h4 class="mb-1" style="color:var(--lux-dark);font-weight:800;letter-spacing:.06em;">
        Manage Rooms
      </h4>
      <div class="muted">Create, update, and control room availability.</div>
    </div>

    <div class="d-flex gap-2">
      <a class="btn btn-gold" href="<c:url value='/admin/rooms/create'/>">
        <i class="bi bi-plus-circle"></i> Add Room
      </a>
    </div>
  </div>

  <!-- ✅ Messages -->
  <c:if test="${param.msg == 'hasReservations'}">
    <div class="alert alert-warning mt-3 mb-0 d-flex align-items-center gap-2">
      <i class="bi bi-exclamation-triangle"></i>
      <div>
        <b>Cannot delete this room</b> because it already has reservations.
        You can set it as <b>INACTIVE</b> instead.
      </div>
    </div>
  </c:if>

  <c:if test="${param.msg == 'deleted'}">
    <div class="alert alert-success mt-3 mb-0 d-flex align-items-center gap-2">
      <i class="bi bi-check-circle"></i>
      <div><b>Room deleted</b> successfully.</div>
    </div>
  </c:if>

  <!-- Card -->
  <div class="mt-4 p-3 p-md-4 rounded-4"
       style="background:rgba(255,255,255,.86);border:1px solid rgba(0,0,0,.06);
              box-shadow:0 12px 30px rgba(0,0,0,.08);backdrop-filter: blur(10px);">

    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-2 mb-3">
      <div class="fw-bold">
        <i class="bi bi-door-open"></i> Rooms Inventory
      </div>
      <div class="muted small">
        Tip: Use <b>Edit</b> to change details, or <b>Delete</b> if safe.
      </div>
    </div>

    <div class="table-responsive">
      <table class="table align-middle mb-0">
        <thead>
        <tr style="color:var(--lux-dark);">
          <th style="width:90px;">ID</th>
          <th style="min-width:160px;">Room</th>
          <th style="min-width:160px;">Type</th>
          <th style="width:140px;">Capacity</th>
          <th style="width:170px;">Price</th>
          <th style="width:140px;">Status</th>
          <th class="text-end" style="min-width:220px;">Actions</th>
        </tr>
        </thead>

        <tbody>
        <c:forEach var="r" items="${rooms}">
          <tr style="border-top:1px solid rgba(0,0,0,.06);">

            <td class="fw-bold">#${r.id}</td>

            <td>
              <div class="d-flex align-items-center gap-2">
                <div class="rounded-circle d-flex align-items-center justify-content-center"
                     style="width:38px;height:38px;background:rgba(200,169,126,.18);color:var(--lux-dark);">
                  <i class="bi bi-house-door"></i>
                </div>
                <div>
                  <div class="fw-bold">Room ${r.roomNumber}</div>
                  <div class="small muted">
                    <i class="bi bi-hash"></i> ${r.roomNumber}
                  </div>
                </div>
              </div>
            </td>

            <td>
              <c:choose>
                <c:when test="${r.type == 'Suite'}">
                  <span class="badge rounded-pill text-bg-dark">
                    <i class="bi bi-gem"></i> Suite
                  </span>
                </c:when>
                <c:when test="${r.type == 'Deluxe'}">
                  <span class="badge rounded-pill text-bg-primary">
                    <i class="bi bi-stars"></i> Deluxe
                  </span>
                </c:when>
                <c:when test="${r.type == 'Family'}">
                  <span class="badge rounded-pill text-bg-success">
                    <i class="bi bi-people"></i> Family
                  </span>
                </c:when>
                <c:otherwise>
                  <span class="badge rounded-pill text-bg-secondary">
                    <i class="bi bi-door-closed"></i> Standard
                  </span>
                </c:otherwise>
              </c:choose>
            </td>

            <td>
              <span class="badge rounded-pill text-bg-light border"
                    style="color:var(--lux-dark);">
                <i class="bi bi-person"></i> ${r.capacity}
              </span>
            </td>

            <td class="fw-bold" style="color:var(--lux-dark);">
              <i class="bi bi-cash-coin"></i> LKR ${r.pricePerNight}
              <div class="small muted">per night</div>
            </td>

            <td>
              <c:choose>
                <c:when test="${r.status == 'AVAILABLE'}">
                  <span class="badge rounded-pill text-bg-success">
                    <i class="bi bi-check-circle"></i> ACTIVE
                  </span>
                </c:when>
                <c:otherwise>
                  <span class="badge rounded-pill text-bg-danger">
                    <i class="bi bi-x-circle"></i> INACTIVE
                  </span>
                </c:otherwise>
              </c:choose>
            </td>

            <td class="text-end">
              <div class="d-inline-flex gap-2">
                <a class="btn btn-outline-dark"
                   href="<c:url value='/admin/rooms/edit?id=${r.id}'/>">
                  <i class="bi bi-pencil-square"></i> Edit
                </a>

                <form class="d-inline" method="post" action="<c:url value='/admin/rooms/delete'/>"
                      onsubmit="return confirm('Delete this room?');">
                  <input type="hidden" name="id" value="${r.id}">
                  <button class="btn btn-outline-danger">
                    <i class="bi bi-trash3"></i> Delete
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
