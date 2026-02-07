<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container py-5">
  <h5 class="section-title">ROOMS & SUITES</h5>
  <p class="muted">Explore our selection of rooms designed for comfort and style.</p>

  <div class="row g-4 mt-2">
    <c:forEach var="r" items="${rooms}">
      <div class="col-md-6 col-lg-4">
        <div class="card card-room">

          <div id="carousel-${r.id}" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-inner" style="height:190px;">
              <c:forEach var="img" items="${r.images}" varStatus="st">
                <div class="carousel-item ${st.index==0 ? 'active' : ''}">
                  <img src="<c:url value='${img.imageUrl}'/>"
                       class="d-block w-100"
                       style="height:190px;object-fit:cover;">
                </div>
              </c:forEach>
            </div>
          </div>

          <div class="card-body">
            <h5 class="card-title mb-1">Room ${r.roomNumber} ${r.type}</h5>
            <div class="muted small">Capacity: ${r.capacity} Status: ${r.status}</div>
            <p class="mt-2 muted">${r.description}</p>
            <div class="d-flex justify-content-between align-items-center">
              <div class="price">LKR ${r.pricePerNight}</div>
              <a class="btn btn-gold" href="<c:url value='/availability'/>">Book</a>
            </div>
          </div>

        </div>
      </div>
    </c:forEach>
  </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
