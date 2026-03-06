<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5" style="max-width:700px;">
  <div class="card p-4 rounded-4 shadow-sm">
    <h4 class="mb-1">Payment Gateway</h4>
    <p class="text-muted mb-4">
      Reservation Code: <b>${reservation.reservationCode}</b>
    </p>

    <div class="d-flex justify-content-between mb-2">
      <span>Total Reservation Amount</span>
      <b>LKR ${reservation.totalAmount}</b>
    </div>

    <div class="d-flex justify-content-between mb-2">
      <span>Payment Method</span>
      <b>${paymentMethod}</b>
    </div>

    <div class="d-flex justify-content-between mb-2">
      <span>Amount To Pay Now</span>
      <b>LKR ${amountToPay}</b>
    </div>

    <hr/>

    <div class="d-flex gap-2">
      <a class="btn btn-success"
         href="<c:url value='/payment/success?paymentId=${paymentId}'/>">
         Pay Now (Success)
      </a>

      <a class="btn btn-danger"
         href="<c:url value='/payment/cancel?paymentId=${paymentId}'/>">
         Cancel
      </a>
    </div>
  </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>