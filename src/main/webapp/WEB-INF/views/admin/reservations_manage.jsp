<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<style>
.input-group-text{
  border-radius: 14px 0 0 14px !important;
}
.form-control, .form-select{
  border-radius: 0 14px 14px 0 !important;
}
.table thead th{
  font-size:.85rem;
  letter-spacing:.08em;
  text-transform:uppercase;
  color: rgba(11,31,42,.8);
}
.table tbody tr:hover{
  background: rgba(200,169,126,.08);
}



</style>
<div class="container py-5">

  <!-- Title bar -->
  <div class="d-flex flex-column flex-lg-row justify-content-between align-items-lg-end gap-2 mb-3">
    <div>
      <div class="lux-badge mb-1">ADMIN</div>
      <h4 class="mb-1" style="color:var(--lux-dark);font-weight:800;letter-spacing:.06em;">
        Manage Reservations
      </h4>
      <div class="muted">Update room/date/guests and manage reservation status.</div>
    </div>

    <!-- Search (frontend only) -->
    <div class="d-flex gap-2 align-items-center">
      <div class="input-group" style="min-width:320px;">
        <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
        <input id="resSearch" class="form-control" placeholder="Search by code, room, status...">
      </div>
    </div>
  </div>

  <!-- Messages -->
  <c:if test="${param.updated == '1'}">
    <div class="alert alert-success d-flex align-items-center gap-2">
      <i class="bi bi-check-circle-fill"></i>
      <div>Reservation updated successfully.</div>
    </div>
  </c:if>

  <c:if test="${param.updated == '0'}">
    <div class="alert alert-danger d-flex align-items-center gap-2">
      <i class="bi bi-x-circle-fill"></i>
      <div>Update failed (conflict or invalid data).</div>
    </div>
  </c:if>

  <c:if test="${param.done == '1'}">
    <div class="alert alert-warning d-flex align-items-center gap-2">
      <i class="bi bi-info-circle-fill"></i>
      <div>Reservation cancelled.</div>
    </div>
  </c:if>

  <!-- Table Card -->
  <div class="p-2 p-md-3 rounded-4"
       style="background:rgba(255,255,255,.86);border:1px solid rgba(0,0,0,.06);
              box-shadow:0 12px 30px rgba(0,0,0,.08);backdrop-filter: blur(10px);">

    <div class="table-responsive">
      <table class="table align-middle mb-0" id="resTable">
        <thead style="position:sticky;top:0;background:rgba(255,255,255,.92);z-index:2;">
          <tr>
            <th style="min-width:140px;">Code</th>
            <th style="min-width:260px;">Room</th>
            <th style="min-width:140px;">Check-in</th>
            <th style="min-width:140px;">Check-out</th>
            <th style="min-width:120px;">Guests</th>
            <th style="min-width:140px;">Status</th>
            <th style="min-width:140px;">Total</th>
            <th class="text-end" style="min-width:170px;">Actions</th>
          </tr>
        </thead>

        <tbody>
        <c:forEach var="r" items="${allReservations}">
          <tr class="resRow">

            <!-- Code -->
            <td class="fw-semibold">
              <div class="d-flex align-items-center gap-2">
                <span class="rounded-circle d-inline-flex align-items-center justify-content-center"
                      style="width:30px;height:30px;background:rgba(200,169,126,.18);color:#7a5b33;">
                  <i class="bi bi-receipt"></i>
                </span>
                <span class="resText">${r.reservationCode}</span>
              </div>
            </td>

            <!-- Room + Form START -->
            <td>
              <form class="d-flex gap-2 align-items-center" method="post" action="<c:url value='/admin/reservation/update'/>">
                <input type="hidden" name="reservationId" value="${r.id}">

                <div class="input-group">
                  <span class="input-group-text bg-white"><i class="bi bi-door-open"></i></span>
                  <select class="form-select form-select-sm resText" name="roomId">
                    <c:forEach var="rm" items="${rooms}">
                      <option value="${rm.id}" ${rm.id==r.roomId ? "selected" : ""}>
                        ${rm.roomNumber} ${rm.type}
                      </option>
                    </c:forEach>
                  </select>
                </div>
            </td>

            <!-- Dates -->
            <td>
              <div class="input-group">
                <span class="input-group-text bg-white"><i class="bi bi-calendar-event"></i></span>
                <input class="form-control form-control-sm resText" type="date" name="checkIn" value="${r.checkIn}">
              </div>
            </td>

            <td>
              <div class="input-group">
                <span class="input-group-text bg-white"><i class="bi bi-calendar-check"></i></span>
                <input class="form-control form-control-sm resText" type="date" name="checkOut" value="${r.checkOut}">
              </div>
            </td>

            <!-- Guests -->
            <td>
              <div class="input-group" style="max-width:130px;">
                <span class="input-group-text bg-white"><i class="bi bi-people"></i></span>
                <input class="form-control form-control-sm resText" type="number" min="1" name="guests" value="${r.guests}">
              </div>
            </td>

            <!-- Status badge -->
            <td>
              <c:set var="st" value="${r.status}" />
              <span class="badge rounded-pill px-3 py-2 resText
                ${st=='RESERVED' ? 'text-bg-success' :
                  (st=='CANCELLED' ? 'text-bg-danger' :
                  (st=='PENDING' ? 'text-bg-warning' : 'text-bg-secondary'))}">
                <i class="bi
                  ${st=='RESERVED' ? 'bi-check2-circle' :
                    (st=='CANCELLED' ? 'bi-x-circle' :
                    (st=='PENDING' ? 'bi-hourglass-split' : 'bi-dot'))}"></i>
                ${r.status}
              </span>
            </td>

            <!-- Total -->
            <td class="fw-semibold">
              <span class="resText">LKR ${r.totalAmount}</span>
            </td>

            <!-- Actions (Form END here) -->
            <td class="text-end">
                <button class="btn btn-sm btn-outline-dark rounded-pill">
                  <i class="bi bi-save"></i> save
                </button>
              </form>

              <c:if test="${r.status=='RESERVED'}">
                <form class="d-inline" method="post" action="<c:url value='/admin/reservation/cancel'/>"
                      onsubmit="return confirm('Cancel this reservation?');">
                  <input type="hidden" name="reservationId" value="${r.id}">
                  <button class="btn btn-sm btn-outline-danger rounded-pill">
                    <i class="bi bi-x-octagon"></i> Cancel
                  </button>
                </form>
              </c:if>
            </td>

          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>

    <div class="small muted mt-2 px-1">
      Tip: Use search to quickly find a reservation by code or room.
    </div>
  </div>
</div>

<!-- ✅ Client-side search -->
<script>
  (function(){
    const input = document.getElementById('resSearch');
    const rows = document.querySelectorAll('#resTable tbody tr.resRow');

    if(!input) return;

    input.addEventListener('input', function(){
      const q = this.value.toLowerCase().trim();
      rows.forEach(r => {
        const text = r.innerText.toLowerCase();
        r.style.display = text.includes(q) ? '' : 'none';
      });
    });
  })();
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
