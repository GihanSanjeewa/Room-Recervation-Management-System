<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>



<div class="mt-3">
  <div class="row g-3">
    <div class="col-md-3">
      <div class="stat-card">
        <div class="stat-title">Total Reservations</div>
        <div class="stat-value fs-3">${allReservations.size()}</div>
      </div>
    </div>
    <div class="col-md-9">
      <div class="stat-card">
        <div class="d-flex justify-content-between align-items-center">
          <div class="fw-bold">Latest Reservations</div>
          <a class="btn btn-sm btn-outline-dark" href="<c:url value='/staff/reservations'/>">Manage</a>
        </div>
        <div class="table-responsive mt-2">
          <table class="table table-sm align-middle mb-0">
            <thead>
            <tr>
              <th>Code</th><th>Room</th><th>Check-in</th><th>Check-out</th><th>Status</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="r" items="${allReservations}" begin="0" end="7">
              <tr>
                <td class="fw-semibold">${r.reservationCode}</td>
                <td>${r.roomNumber} • ${r.roomType}</td>
                <td>${r.checkIn}</td>
                <td>${r.checkOut}</td>
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
