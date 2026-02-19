<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<style>
.btn-outline-light{
  border-color: rgba(255,255,255,.25) !important;
  color: rgba(255,255,255,.92) !important;
}
.btn-outline-light:hover{
  background: rgba(255,255,255,.10) !important;
  border-color: rgba(255,255,255,.35) !important;
}

</style>
<div class="container py-4">

  <!-- Header -->
  <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3">
    <div>
      <div class="lux-badge">ADMIN PANEL</div>
      <h4 class="mb-1" style="letter-spacing:.04em;">Dashboard Overview</h4>
      <div class="muted">Quick access + latest reservations at a glance.</div>
    </div>

    <div class="d-flex gap-2">
      <a class="btn btn-lux px-3" href="<c:url value='/admin/reports'/>">
        <i class="bi bi-bar-chart-line me-2"></i>Reports
      </a>
      <a class="btn btn-outline-light px-3" href="<c:url value='/home'/>">
        <i class="bi bi-globe2 me-2"></i>Public Site
      </a>
    </div>
  </div>

  <div class="row g-3">
    <!-- Quick Actions -->
    <div class="col-lg-4">
      <div class="glass-card p-4 h-100">
        <div class="d-flex align-items-center gap-2">
          <div class="rounded-3 d-flex align-items-center justify-content-center"
               style="width:42px;height:42px;background:rgba(200,169,126,.14);border:1px solid rgba(200,169,126,.25);">
            <i class="bi bi-lightning-charge-fill" style="color:var(--lux-gold);font-size:1.15rem;"></i>
          </div>
          <div>
            <div class="fw-bold" style="letter-spacing:.08em;">QUICK ACTIONS</div>
            <div class="muted" style="font-size:.92rem;">Manage the system faster</div>
          </div>
        </div>

        <div class="d-grid gap-2 mt-3">
          <a class="btn btn-lux" href="<c:url value='/admin/rooms'/>">
            <i class="bi bi-door-open me-2"></i>Manage Rooms
          </a>
          <a class="btn btn-outline-light" href="<c:url value='/admin/reservations'/>">
            <i class="bi bi-calendar2-check me-2"></i>Manage Reservations
          </a>
          <a class="btn btn-outline-light" href="<c:url value='/admin/users'/>">
            <i class="bi bi-people me-2"></i>Manage Users/Staff
          </a>
          <a class="btn btn-outline-light" href="<c:url value='/admin/reports'/>">
            <i class="bi bi-clipboard-data me-2"></i>Reports
          </a>
        </div>

        <hr style="border-color: rgba(255,255,255,.12)" class="my-4"/>

        <div class="muted small">
          Tip: Use Reports to view revenue, occupancy, and cancellations quickly.
        </div>
      </div>
    </div>

    <!-- Latest Reservations -->
    <div class="col-lg-8">
      <div class="glass-card p-4 h-100">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <div>
            <div class="fw-bold" style="letter-spacing:.08em;">LATEST RESERVATIONS</div>
            <div class="muted" style="font-size:.92rem;">Showing up to 10 newest records</div>
          </div>
          <a class="btn btn-sm btn-outline-light" href="<c:url value='/admin/reservations'/>">
            Open <i class="bi bi-arrow-right ms-1"></i>
          </a>
        </div>

        <div class="table-responsive">
          <table class="table table-borderless align-middle mb-0"
                 style="color:#eaf2f7;">
            <thead>
              <tr style="border-bottom:1px solid rgba(255,255,255,.12);">
                <th style="color:rgb(4,2,0);font-weight:600;">Code</th>
                <th style="color:rgb(4,2,0);font-weight:600;">Room</th>
                <th style="color:rgb(4,2,0);font-weight:600;">Dates</th>
                <th style="color:rgb(4,2,0);font-weight:600;">Guests</th>
                <th style="color:rgb(4,2,0);font-weight:600;">Status</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="r" items="${allReservations}" begin="0" end="9">
                <tr style="border-bottom:1px solid rgba(255,255,255,.08);">
                  <td class="fw-semibold">${r.reservationCode}</td>
                  <td>
                    <i class="bi bi-house-door me-1" style="opacity:.8;"></i>
                    ${r.roomNumber} <span style="opacity:.7;"></span> ${r.roomType}
                  </td>
                  <td style="opacity:.9;">
                    <i class="bi bi-calendar-event me-1" style="opacity:.8;"></i>
                    ${r.checkIn} -- ${r.checkOut}
                  </td>
                  <td>
                    <i class="bi bi-person-fill me-1" style="opacity:.8;"></i>
                    ${r.guests}
                  </td>
                  <td>
                    <span class="badge ${r.status=='RESERVED' ? 'text-bg-success' : 'text-bg-secondary'}">
                      ${r.status}
                    </span>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

</div>

</main>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
