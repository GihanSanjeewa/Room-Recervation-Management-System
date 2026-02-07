<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5">
  <h5 class="section-title">STAFF • MANAGE RESERVATIONS</h5>

  <c:if test="${param.updated == '1'}"><div class="alert alert-success">Reservation updated.</div></c:if>
  <c:if test="${param.updated == '0'}"><div class="alert alert-danger">Update failed (conflict or invalid data).</div></c:if>
  <c:if test="${param.done == '1'}"><div class="alert alert-success">Reservation cancelled.</div></c:if>

  <div class="table-responsive border rounded-4 p-2 mt-3">
    <table class="table align-middle mb-0">
      <thead>
      <tr>
        <th>Code</th><th>Room</th><th>Check-in</th><th>Check-out</th><th>Guests</th><th>Status</th><th>Total</th><th class="text-end">Actions</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="r" items="${allReservations}">
        <tr>
          <td class="fw-semibold">${r.reservationCode}</td>

          <td style="min-width:200px;">
            <form class="d-flex gap-2" method="post" action="<c:url value='/staff/reservation/update'/>">
              <input type="hidden" name="reservationId" value="${r.id}">
              <select class="form-select form-select-sm" name="roomId">
                <c:forEach var="rm" items="${rooms}">
                  <option value="${rm.id}" ${rm.id==r.roomId ? "selected" : ""}>
                    ${rm.roomNumber} • ${rm.type}
                  </option>
                </c:forEach>
              </select>
          </td>

          <td>
              <input class="form-control form-control-sm" type="date" name="checkIn" value="${r.checkIn}">
          </td>
          <td>
              <input class="form-control form-control-sm" type="date" name="checkOut" value="${r.checkOut}">
          </td>
          <td style="max-width:110px;">
              <input class="form-control form-control-sm" type="number" min="1" name="guests" value="${r.guests}">
          </td>

          <td>
            <span class="badge ${r.status=='RESERVED' ? 'text-bg-success' : 'text-bg-secondary'}">${r.status}</span>
          </td>

          <td>LKR ${r.totalAmount}</td>

          <td class="text-end">
              <button class="btn btn-sm btn-outline-dark">Save</button>
            </form>

            <c:if test="${r.status=='RESERVED'}">
              <form class="d-inline" method="post" action="<c:url value='/staff/reservation/cancel'/>"
                    onsubmit="return confirm('Cancel this reservation?');">
                <input type="hidden" name="reservationId" value="${r.id}">
                <button class="btn btn-sm btn-outline-danger">Cancel</button>
              </form>
            </c:if>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
