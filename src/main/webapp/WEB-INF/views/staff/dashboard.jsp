<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-4">

  <!-- Header -->
  <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 mb-3">
    <div>
      <div class="lux-badge">STAFF PANEL</div>
      <h4 class="mb-1" style="letter-spacing:.04em;">Dashboard</h4>
      <div class="muted">Monitor reservations and manage bookings quickly.</div>
    </div>

    <a class="btn btn-outline-light" href="<c:url value='/staff/reservations'/>">
      <i class="bi bi-calendar2-check me-2"></i>Manage Reservations
    </a>
  </div>

  <div class="row g-3">

    <!-- Total Reservations -->
    <div class="col-lg-3">
      <div class="glass-card p-4 h-100">
        <div class="d-flex align-items-center gap-2">
          <div class="rounded-3 d-flex align-items-center justify-content-center"
               style="width:42px;height:42px;background:rgba(200,169,126,.14);border:1px solid rgba(200,169,126,.25);">
            <i class="bi bi-clipboard-check-fill" style="color:var(--lux-gold);font-size:1.15rem;"></i>
          </div>
          <div>
            <div class="fw-bold" style="letter-spacing:.08em;">TOTAL RESERVATIONS</div>
            <div class="muted" style="font-size:.92rem;">All-time records</div>
          </div>
        </div>

        <div class="mt-3">
          <div class="fw-bold" style="font-size:2.2rem;line-height:1;">
            ${allReservations.size()}
          </div>
          <div class="muted mt-1">Reservations stored</div>
        </div>

        <hr style="border-color: rgba(255,255,255,.12)" class="my-4"/>

        <div class="small muted">
          Tip: Use “Manage Reservations” to update room and dates.
        </div>
      </div>
    </div>

    <!-- Latest Reservations -->
    <div class="col-lg-9">
      <div class="glass-card p-4 h-100">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <div>
            <div class="fw-bold" style="letter-spacing:.08em;">LATEST RESERVATIONS</div>
            <div class="muted" style="font-size:.92rem;">Showing up to 8 newest records</div>
          </div>
          <a class="btn btn-sm btn-outline-light" href="<c:url value='/staff/reservations'/>">
            Manage <i class="bi bi-arrow-right ms-1"></i>
          </a>
        </div>

        <div class="table-responsive">
          <table class="table table-borderless align-middle mb-0" style="color:#eaf2f7;">
            <thead>
              <tr style="border-bottom:1px solid rgba(255,255,255,.12);">
                <th style="color:rgb(4,2,0);font-weight:600;">Code</th>
                <th style="color:rgb(4,2,0);font-weight:600;">Room</th>
                <th style="color:rgb(4,2,0);font-weight:600;">Check-in</th>
                <th style="color:rgb(4,2,0);font-weight:600;">Check-out</th>
                <th style="color:rgb(4,2,0);font-weight:600;">Status</th>
              </tr>
            </thead>

            <tbody>
              <c:forEach var="r" items="${allReservations}" begin="0" end="7">
                <tr style="border-bottom:1px solid rgba(255,255,255,.08);">
                  <td class="fw-semibold">${r.reservationCode}</td>

                  <td>
                    <i class="bi bi-house-door me-1" style="opacity:.8;"></i>
                    ${r.roomNumber} <span style="opacity:.7;"></span> ${r.roomType}
                  </td>

                  <td style="opacity:.9;">
                    <i class="bi bi-calendar-event me-1" style="opacity:.8;"></i>
                    ${r.checkIn}
                  </td>

                  <td style="opacity:.9;">
                    <i class="bi bi-calendar-event me-1" style="opacity:.8;"></i>
                    ${r.checkOut}
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
