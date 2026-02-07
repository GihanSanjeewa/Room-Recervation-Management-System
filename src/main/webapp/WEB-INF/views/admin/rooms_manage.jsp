<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5">
  <div class="d-flex justify-content-between align-items-center">
    <h5 class="section-title mb-0">ADMIN • MANAGE ROOMS</h5>
    <a class="btn btn-gold" href="<c:url value='/admin/rooms/create'/>">+ Add Room</a>
  </div>

  <!-- ✅ Messages -->
  <c:if test="${param.msg == 'hasReservations'}">
    <div class="alert alert-warning mt-3 mb-0">
      Cannot delete this room because it already has reservations. You can set it as INACTIVE instead.
    </div>
  </c:if>

  <c:if test="${param.msg == 'deleted'}">
    <div class="alert alert-success mt-3 mb-0">
      Room deleted successfully.
    </div>
  </c:if>

  <div class="table-responsive border rounded-4 p-2 mt-3">
    <table class="table align-middle mb-0">
      <thead>
      <tr>
        <th>ID</th><th>Room</th><th>Type</th><th>Capacity</th><th>Price</th><th>Status</th><th class="text-end">Actions</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="r" items="${rooms}">
        <tr>
          <td>${r.id}</td>
          <td>${r.roomNumber}</td>
          <td>${r.type}</td>
          <td>${r.capacity}</td>
          <td>LKR ${r.pricePerNight}</td>
          <td>${r.status}</td>
          <td class="text-end">
            <a class="btn btn-sm btn-outline-dark" href="<c:url value='/admin/rooms/edit?id=${r.id}'/>">Edit</a>

            <form class="d-inline" method="post" action="<c:url value='/admin/rooms/delete'/>"
                  onsubmit="return confirm('Delete this room?');">
              <input type="hidden" name="id" value="${r.id}">
              <button class="btn btn-sm btn-outline-danger">Delete</button>
            </form>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
