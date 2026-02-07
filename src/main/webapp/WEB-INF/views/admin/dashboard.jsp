<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>


<div class="mt-3">
  <div class="row g-3">
    <div class="col-md-4">
      <div class="stat-card">
        <div class="stat-title">Quick Actions</div>
        <div class="d-grid gap-2 mt-2">
          <a class="btn btn-lux" href="<c:url value='/admin/rooms'/>">Manage Rooms</a>
          <a class="btn btn-outline-dark" href="<c:url value='/admin/reservations'/>">Manage Reservations</a>
          <a class="btn btn-outline-dark" href="<c:url value='/admin/users'/>">Manage Users/Staff</a>
          <a class="btn btn-outline-dark" href="<c:url value='/admin/reports'/>">Reports</a>
        </div>
      </div>
    </div>

    <div class="col-md-8">
      <div class="stat-card">
        <div class="d-flex justify-content-between align-items-center">
          <div class="fw-bold">Latest Reservations</div>
          <a class="btn btn-sm btn-outline-dark" href="<c:url value='/admin/reservations'/>">Open</a>
        </div>
        <div class="table-responsive mt-2">
          <table class="table table-sm align-middle mb-0">
            <thead>
            <tr>
              <th>Code</th><th>Room</th><th>Dates</th><th>Guests</th><th>Status</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="r" items="${allReservations}" begin="0" end="9">
              <tr>
                <td class="fw-semibold">${r.reservationCode}</td>
                <td>${r.roomNumber} • ${r.roomType}</td>
                <td>${r.checkIn} → ${r.checkOut}</td>
                <td>${r.guests}</td>
                <td><span class="badge ${r.status=='RESERVED'?'text-bg-success':'text-bg-secondary'}">${r.status}</span></td>
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
