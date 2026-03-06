<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5">
  <h5 class="section-title">MY RESERVATIONS</h5>

  <c:if test="${param.success == '1'}">
    <div class="alert alert-success">Reservation confirmed successfully!</div>
  </c:if>

  <c:if test="${param.pay == 'success'}">
    <div class="alert alert-success">Payment successful.</div>
  </c:if>

  <c:if test="${param.pay == 'alreadyPaid'}">
    <div class="alert alert-warning">This reservation is already paid.</div>
  </c:if>

  <c:if test="${param.pay == 'cancel'}">
    <div class="alert alert-danger">Payment cancelled.</div>
  </c:if>

  <c:if test="${param.pay == 'invalid'}">
    <div class="alert alert-warning">Invalid payment request.</div>
  </c:if>

  <c:if test="${param.pay == 'failed'}">
    <div class="alert alert-danger">Payment creation failed.</div>
  </c:if>

  <div class="table-responsive border rounded-4 p-2">
    <table class="table align-middle mb-0">
      <thead>
        <tr>

          <th>Code</th>
          <th>Room</th>
          <th>Dates</th>
          <th>Guests</th>
          <th>Status</th>
          <th>Total</th>
          <th>Payment</th>
          <th></th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="r" items="${reservations}">
          <tr>
        
            <td class="fw-semibold">${r.reservationCode}</td>
            <td>${r.roomNumber} ${r.roomType}</td>
            <td>${r.checkIn} ${r.checkOut}</td>
            <td>${r.guests}</td>
            <td>
              <span class="badge text-bg-success">${r.status}</span>
            </td>
            <td>LKR ${r.totalAmount}</td>

            <td>
              <c:choose>
                <c:when test="${r.status == 'RESERVED'}">
                  <a href="<c:url value='/payment?reservationId=${r.id}'/>" class="btn btn-sm btn-primary">
                    Pay Now
                  </a>
                </c:when>

                <c:when test="${r.status == 'PAID'}">
                  <span class="badge text-bg-success">PAID</span>
                </c:when>

                <c:when test="${r.status == 'ADVANCE_PAID'}">
                  <span class="badge text-bg-warning">ADVANCE PAID</span>
                </c:when>

                <c:otherwise>
                  <span class="badge text-bg-secondary">${r.status}</span>
                </c:otherwise>
              </c:choose>
            </td>

            <td class="text-end">
              <c:if test="${r.status == 'RESERVED'}">
                <form method="post" action="<c:url value='/cancel'/>">
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