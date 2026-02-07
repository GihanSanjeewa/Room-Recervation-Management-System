<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5">
  <h5 class="section-title">CHECK AVAILABILITY</h5>
  <p class="muted">Select dates and guests to view available rooms.</p>

  <c:if test="${param.error == '1'}">
    <div class="alert alert-danger">Reservation failed. Please try again.</div>
  </c:if>

  <form class="row g-2 align-items-end border rounded-4 p-3" method="get" action="<c:url value='/availability'/>">
    <div class="col-12 col-md-3">
      <label class="form-label small muted">Check-in</label>
      <input type="date" name="checkIn" class="form-control" value="${param.checkIn}" required>
    </div>
    <div class="col-12 col-md-3">
      <label class="form-label small muted">Check-out</label>
      <input type="date" name="checkOut" class="form-control" value="${param.checkOut}" required>
    </div>
    <div class="col-12 col-md-2">
      <label class="form-label small muted">Guests</label>
      <input type="number" name="guests" class="form-control" min="1" value="${empty param.guests ? 2 : param.guests}" required>
    </div>
    <div class="col-12 col-md-2">
      <label class="form-label small muted">Type</label>
      <select name="type" class="form-select">
        <option value="" ${empty param.type ? "selected" : ""}>Any</option>
        <option ${param.type == 'Standard' ? "selected" : ""}>Standard</option>
        <option ${param.type == 'Deluxe' ? "selected" : ""}>Deluxe</option>
        <option ${param.type == 'Family' ? "selected" : ""}>Family</option>
        <option ${param.type == 'Suite' ? "selected" : ""}>Suite</option>
      </select>
    </div>
    <div class="col-12 col-md-2 d-grid">
      <button class="btn btn-gold">Search</button>
    </div>
  </form>

  <c:if test="${not empty availableRooms}">
    <h6 class="mt-4 fw-bold">Available Rooms</h6>
    <div class="row g-4 mt-1">
      <c:forEach var="r" items="${availableRooms}">
        <div class="col-md-6 col-lg-4">
          <div class="card card-room">
            <div style="height:160px;background:#111;opacity:.9"></div>
            <div class="card-body">
              <h5 class="card-title mb-1">Room ${r.roomNumber}  ${r.type}</h5>
              <div class="muted small">Capacity: ${r.capacity}</div>
              <p class="mt-2 muted">${r.description}</p>

              <form method="post" action="<c:url value='/reserve'/>">
                <input type="hidden" name="roomId" value="${r.id}">
                <input type="hidden" name="checkIn" value="${param.checkIn}">
                <input type="hidden" name="checkOut" value="${param.checkOut}">
                <input type="hidden" name="guests" value="${param.guests}">
                <div class="d-flex justify-content-between align-items-center">
                  <div class="price">LKR ${r.pricePerNight}</div>
                  <button class="btn btn-gold">Reserve</button>
                </div>
                <div class="small muted mt-2">Instant confirmation Status: Reserved</div>
              </form>

              <c:if test="${empty sessionScope.authUser}">
                <div class="alert alert-warning mt-3 mb-0">
                  Please <a href="<c:url value='/login'/>">login</a> to reserve.
                </div>
              </c:if>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
  </c:if>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
