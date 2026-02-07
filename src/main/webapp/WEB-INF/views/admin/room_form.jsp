<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5" style="max-width:900px;">
  <h5 class="section-title">
    <c:choose>
      <c:when test="${not empty room}">EDIT ROOM</c:when>
      <c:otherwise>CREATE ROOM</c:otherwise>
    </c:choose>
  </h5>

  <c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
  </c:if>
  
  <c:if test="${not empty room && not empty room.images}">
  <div class="col-12">
    <label class="form-label">Current Images</label>
    <div class="row g-3">
      <c:forEach var="img" items="${room.images}">
        <div class="col-6 col-md-3">
          <div class="border rounded-4 p-2">
            <img src="<c:url value='${img.imageUrl}'/>" style="width:100%;height:120px;object-fit:cover;border-radius:12px;">
            <div class="d-flex justify-content-between align-items-center mt-2">
              <c:if test="${img.cover}">
                <span class="badge text-bg-warning">Cover</span>
              </c:if>
              <c:if test="${!img.cover}">
                <form method="post" action="<c:url value='/admin/rooms/image/set-cover'/>">
                  <input type="hidden" name="imageId" value="${img.id}">
                  <button class="btn btn-sm btn-outline-dark">Set Cover</button>
                </form>
              </c:if>
            </div>

            <form class="mt-2" method="post" action="<c:url value='/admin/rooms/image/delete'/>"
                  onsubmit="return confirm('Delete this image?');">
              <input type="hidden" name="imageId" value="${img.id}">
              <button class="btn btn-sm btn-outline-danger w-100">Delete</button>
            </form>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>
</c:if>
  

  <div class="border rounded-4 p-4">
    <form method="post"
      enctype="multipart/form-data"
      action="<c:url value='${empty room ? "/admin/rooms/create" : "/admin/rooms/edit"}'/>">

      <c:if test="${not empty room}">
        <input type="hidden" name="id" value="${room.id}">
      </c:if> 

      <div class="row g-3">
        <div class="col-md-3">
          <label class="form-label">Room Number</label>
          <input class="form-control" name="roomNumber" value="${room.roomNumber}" required>
        </div>
        <div class="col-md-3">
          <label class="form-label">Type</label>
          <input class="form-control" name="type" value="${room.type}" required>
        </div>
        <div class="col-md-3">
          <label class="form-label">Capacity</label>
          <input class="form-control" type="number" min="1" name="capacity" value="${room.capacity}" required>
        </div>
        <div class="col-md-3">
          <label class="form-label">Price Per Night (LKR)</label>
          <input class="form-control" type="number" step="0.01" name="pricePerNight" value="${room.pricePerNight}" required>
        </div>

        <div class="col-md-4">
          <label class="form-label">Status</label>
          <select class="form-select" name="status">
            <option value="AVAILABLE" ${room.status=='AVAILABLE'?'selected':''}>AVAILABLE</option>
            <option value="MAINTENANCE" ${room.status=='MAINTENANCE'?'selected':''}>MAINTENANCE</option>
          </select>
        </div>

        <div class="col-12">
          <label class="form-label">Description</label>
          <textarea class="form-control" name="description" rows="3">${room.description}</textarea>
        </div>

        <div class="col-12">
		  <label class="form-label">Upload Room Images</label>
		  <input class="form-control" type="file" name="roomImages" multiple accept="image/*">
		  <div class="small muted mt-1">You can select multiple images. First image will be cover.</div>
		</div>


        <div class="col-md-3">
          <label class="form-label">Cover Index (0,1,2...)</label>
          <input class="form-control" type="number" name="coverIndex" value="0">
        </div>

        <div class="col-12 d-flex gap-2">
          <button class="btn btn-gold">Save</button>
          <a class="btn btn-outline-dark" href="<c:url value='/admin/rooms'/>">Back</a>
        </div>
      </div>
    </form>
  </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
