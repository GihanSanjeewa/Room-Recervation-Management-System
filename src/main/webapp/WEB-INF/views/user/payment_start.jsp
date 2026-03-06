<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5" style="max-width:700px;">
  <div class="card p-4 rounded-4 shadow-sm">
    <h4 class="mb-1">Confirm Payment</h4>
    <p class="text-muted mb-4">
      Reservation Code: <b>${reservation.reservationCode}</b>
    </p>

    <div class="d-flex justify-content-between mb-2">
      <span>Total Reservation Amount</span>
      <b>LKR ${reservation.totalAmount}</b>
    </div>

    <hr/>

    <form method="post" action="<c:url value='/payment'/>">
      <input type="hidden" name="reservationId" value="${reservation.id}" />

      <div class="mb-3">
        <label class="form-label">Payment Method</label>
        <select class="form-select" name="paymentMethod" id="paymentMethod" onchange="toggleAdvanceAmount()">
          <option value="CARD">Full Payment</option>
          <option value="ADVANCE">Advance Payment</option>
        </select>
      </div>

      <div class="mb-3" id="advanceAmountBox" style="display:none;">
        <label class="form-label">Advance Amount</label>
        <input
          type="number"
          step="0.01"
          min="1"
          class="form-control"
          name="advanceAmount"
          placeholder="Enter advance amount"
        />
        <small class="text-muted">Enter the amount you want to pay now.</small>
      </div>

      <div class="d-flex gap-2">
        <button type="submit" class="btn btn-success">Continue</button>
        <a class="btn btn-secondary" href="<c:url value='/my-reservations'/>">Back</a>
      </div>
    </form>
  </div>
</div>

<script>
function toggleAdvanceAmount() {
    const method = document.getElementById("paymentMethod").value;
    const box = document.getElementById("advanceAmountBox");
    box.style.display = (method === "ADVANCE") ? "block" : "none";
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>