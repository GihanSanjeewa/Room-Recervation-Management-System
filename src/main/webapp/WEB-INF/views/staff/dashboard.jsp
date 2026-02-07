<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5">
  <h5 class="section-title">STAFF DASHBOARD</h5>
  <p class="muted">View all reservations (Reserved / Cancelled).</p>

  <div class="table-responsive border rounded-4 p-2">
    <table class="table align-middle mb-0">
      <thead>
      <tr>
        <th>Code</th><th>Room</th><th>Check-in</th><th>Check-out</th><th>Guests</th><th>Status</th><th>Total</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="r" items="${allReservations}">
        <tr>
          <td class="fw-semibold">${r.reservationCode}</td>
          <td>${r.roomNumber} ${r.roomType}</td>
          <td>${r.checkIn}</td>
          <td>${r.checkOut}</td>
          <td>${r.guests}</td>
          <td>
            <span class="badge ${r.status=='RESERVED' ? 'text-bg-success' : 'text-bg-secondary'}">
              ${r.status}
            </span>
          </td>
          <td>LKR ${r.totalAmount}</td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
