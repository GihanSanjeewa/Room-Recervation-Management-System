<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5">
  <h5 class="section-title">STAFF REPORTS</h5>
  
  <form class="row g-2 align-items-end border rounded-4 p-3 mt-3"
	      method="get" action="<c:url value='/staff/reports'/>">
	  <div class="col-12 col-md-4">
	    <label class="form-label small muted">From</label>
	    <input type="date" name="from" class="form-control" value="${from}" required>
	  </div>
	  <div class="col-12 col-md-4">
	    <label class="form-label small muted">To</label>
	    <input type="date" name="to" class="form-control" value="${to}" required>
	  </div>
	  <div class="col-12 col-md-4 d-grid">
	    <button class="btn btn-gold">Apply Filter</button>
	  </div>
	</form>
	
	<div class="mt-3 muted">
	  Showing results from <strong>${from}</strong> to <strong>${to}</strong>
	</div>
	  

  <div class="row g-3 mt-2">
    <div class="col-md-3"><div class="p-3 border rounded-4"><div class="muted">Total</div><h4>${summary.totalReservations}</h4></div></div>
    <div class="col-md-3"><div class="p-3 border rounded-4"><div class="muted">Reserved</div><h4>${summary.reservedCount}</h4></div></div>
    <div class="col-md-3"><div class="p-3 border rounded-4"><div class="muted">Cancelled</div><h4>${summary.cancelledCount}</h4></div></div>
    <div class="col-md-3"><div class="p-3 border rounded-4"><div class="muted">Revenue (Reserved)</div><h4>LKR ${summary.reservedRevenue}</h4></div></div>
  </div>

  <div class="row g-3 mt-2">
    <div class="col-md-6">
      <div class="p-4 border rounded-4">
        <h6 class="fw-bold">Today</h6>
        <div class="d-flex justify-content-between"><span class="muted">Check-ins</span><span>${summary.todayCheckins}</span></div>
        <div class="d-flex justify-content-between"><span class="muted">Check-outs</span><span>${summary.todayCheckouts}</span></div>
      </div>
    </div>
    <div class="col-md-6">
      <div class="p-4 border rounded-4">
        <h6 class="fw-bold">Top Reserved Rooms</h6>
        <c:forEach var="e" items="${topRooms}">
          <div class="d-flex justify-content-between">
            <span>Room ${e.key}</span><span class="muted">${e.value}</span>
          </div>
        </c:forEach>
      </div>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
