<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<style>
.input-group-text{
  border-radius: 14px 0 0 14px !important;
}
.form-control, .form-select{
  border-radius: 0 14px 14px 0 !important;
}
.form-control:focus, .form-select:focus{
  box-shadow: 0 0 0 .2rem rgba(200,169,126,.25) !important;
  border-color: rgba(200,169,126,.55) !important;
}

</style>
<div class="container py-5" style="max-width:980px;">

  <!-- Title -->
  <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-end gap-2 mb-3">
    <div>
      <div class="lux-badge mb-1">ADMIN</div>

      <h4 class="mb-1" style="color:var(--lux-dark);font-weight:800;letter-spacing:.06em;">
        <c:choose>
          <c:when test="${not empty room}">Edit Room</c:when>
          <c:otherwise>Create Room</c:otherwise>
        </c:choose>
      </h4>

      <div class="muted">
        Manage room details, pricing, status, and images.
      </div>
    </div>

    <a class="btn btn-outline-dark rounded-pill" href="<c:url value='/admin/rooms'/>">
      <i class="bi bi-arrow-left"></i> Back to Rooms
    </a>
  </div>

  <c:if test="${not empty error}">
    <div class="alert alert-danger d-flex align-items-center gap-2">
      <i class="bi bi-exclamation-octagon"></i>
      <div>${error}</div>
    </div>
  </c:if>

  <!-- ✅ Current Images -->
  <c:if test="${not empty room && not empty room.images}">
    <div class="p-3 p-md-4 rounded-4 mb-4"
         style="background:rgba(255,255,255,.86);border:1px solid rgba(0,0,0,.06);
                box-shadow:0 12px 30px rgba(0,0,0,.08);backdrop-filter: blur(10px);">

      <div class="d-flex justify-content-between align-items-center mb-3">
        <div class="fw-bold" style="color:var(--lux-dark);">
          <i class="bi bi-images"></i> Current Images
        </div>
        <div class="muted small">Tip: Choose a cover image for the room listing.</div>
      </div>

      <div class="row g-3">
        <c:forEach var="img" items="${room.images}">
          <div class="col-6 col-md-3">
            <div class="rounded-4 p-2 h-100"
                 style="border:1px solid rgba(0,0,0,.08);background:#fff;box-shadow:0 10px 22px rgba(0,0,0,.06);">

              <div class="position-relative">
                <img src="<c:url value='${img.imageUrl}'/>"
                     style="width:100%;height:130px;object-fit:cover;border-radius:14px;">
                <c:if test="${img.cover}">
                  <span class="badge rounded-pill position-absolute top-0 start-0 m-2 text-bg-warning">
                    <i class="bi bi-star-fill"></i> Cover
                  </span>
                </c:if>
              </div>

              <div class="d-grid gap-2 mt-2">
                <c:if test="${!img.cover}">
                  <form method="post" action="<c:url value='/admin/rooms/image/set-cover'/>">
                    <input type="hidden" name="imageId" value="${img.id}">
                    <button class="btn btn-sm btn-outline-dark rounded-pill w-100">
                      <i class="bi bi-star"></i> Set as Cover
                    </button>
                  </form>
                </c:if>

                <form method="post" action="<c:url value='/admin/rooms/image/delete'/>"
                      onsubmit="return confirm('Delete this image?');">
                  <input type="hidden" name="imageId" value="${img.id}">
                  <button class="btn btn-sm btn-outline-danger rounded-pill w-100">
                    <i class="bi bi-trash3"></i> Delete
                  </button>
                </form>
              </div>

            </div>
          </div>
        </c:forEach>
      </div>
    </div>
  </c:if>

  <!-- ✅ Form Card -->
  <div class="p-3 p-md-4 rounded-4"
       style="background:rgba(255,255,255,.86);border:1px solid rgba(0,0,0,.06);
              box-shadow:0 12px 30px rgba(0,0,0,.08);backdrop-filter: blur(10px);">

    <div class="fw-bold mb-3" style="color:var(--lux-dark);">
      <i class="bi bi-pencil-square"></i> Room Details
    </div>

    <form method="post"
          enctype="multipart/form-data"
          action="<c:url value='${empty room ? "/admin/rooms/create" : "/admin/rooms/edit"}'/>">

      <c:if test="${not empty room}">
        <input type="hidden" name="id" value="${room.id}">
      </c:if>

      <div class="row g-3">

        <!-- Room Number -->
        <div class="col-md-3">
          <label class="form-label">Room Number</label>
          <div class="input-group">
            <span class="input-group-text bg-white"><i class="bi bi-hash"></i></span>
            <input class="form-control" name="roomNumber" value="${room.roomNumber}" required>
          </div>
        </div>

        <!-- Type -->
        <div class="col-md-3">
          <label class="form-label">Type</label>
          <div class="input-group">
            <span class="input-group-text bg-white"><i class="bi bi-grid-3x3-gap"></i></span>
            <input class="form-control" name="type" value="${room.type}" placeholder="Standard / Deluxe / Suite" required>
          </div>
        </div>

        <!-- Capacity -->
        <div class="col-md-3">
          <label class="form-label">Capacity</label>
          <div class="input-group">
            <span class="input-group-text bg-white"><i class="bi bi-person"></i></span>
            <input class="form-control" type="number" min="1" name="capacity" value="${room.capacity}" required>
          </div>
        </div>

        <!-- Price -->
        <div class="col-md-3">
          <label class="form-label">Price Per Night (LKR)</label>
          <div class="input-group">
            <span class="input-group-text bg-white"><i class="bi bi-cash-coin"></i></span>
            <input class="form-control" type="number" step="0.01" name="pricePerNight" value="${room.pricePerNight}" required>
          </div>
        </div>

        <!-- Status -->
        <div class="col-md-4">
          <label class="form-label">Status</label>
          <div class="input-group">
            <span class="input-group-text bg-white"><i class="bi bi-shield-check"></i></span>
            <select class="form-select" name="status">
              <option value="AVAILABLE" ${room.status=='AVAILABLE'?'selected':''}>AVAILABLE</option>
              <option value="UNAVAILABLE" ${room.status=='MAINTENANCE'?'selected':''}>MAINTENANCE</option>
            </select>
          </div>
          <div class="small muted mt-1">
            AVAILABLE = bookable, MAINTENANCE = hidden / not bookable.
          </div>
        </div>

        <!-- Cover Index -->
        <div class="col-md-4">
          <label class="form-label">Cover Index</label>
          <div class="input-group">
            <span class="input-group-text bg-white"><i class="bi bi-star"></i></span>
            <input class="form-control" type="number" name="coverIndex" value="0" min="0">
          </div>
          <div class="small muted mt-1">0 = first image is cover, 1 = second image, etc.</div>
        </div>

        <!-- Upload -->
        <div class="col-md-4">
          <label class="form-label">Upload Room Images</label>
          <div class="input-group">
            <span class="input-group-text bg-white"><i class="bi bi-upload"></i></span>
            <input class="form-control" type="file" name="roomImages" multiple accept="image/*">
          </div>
          <div class="small muted mt-1">Select multiple images. Cover can be set later.</div>
        </div>

        <!-- Description -->
        <div class="col-12">
          <label class="form-label">Description</label>
          <div class="input-group">
            <span class="input-group-text bg-white"><i class="bi bi-text-paragraph"></i></span>
            <textarea class="form-control" name="description" rows="4"
                      placeholder="Write a short premium description...">${room.description}</textarea>
          </div>
        </div>

        <!-- Buttons -->
        <div class="col-12 d-flex flex-column flex-sm-row gap-2 mt-2">
          <button class="btn btn-gold rounded-pill px-4">
            <i class="bi bi-save"></i> Save
          </button>
          <a class="btn btn-outline-dark rounded-pill px-4" href="<c:url value='/admin/rooms'/>">
            <i class="bi bi-x-circle"></i> Cancel
          </a>
        </div>

      </div>
    </form>
  </div>

</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
