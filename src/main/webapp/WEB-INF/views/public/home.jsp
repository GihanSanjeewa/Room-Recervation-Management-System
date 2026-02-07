<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="hero">
  <div class="container">
    <div class="lux-badge">JAKARTA • CITY LUXURY</div>
    <h1 class="mt-2">Experience timeless comfort by the ocean</h1>
    <p class="mt-3">
      Discover elegant rooms, premium service, and a smooth booking experience built with MVC architecture.
    </p>

    <div class="booking-bar">
      <form class="row g-2 align-items-end" action="<c:url value='/availability'/>" method="get">
        <div class="col-12 col-md-3">
          <label class="form-label small muted">Check-in</label>
          <input type="date" name="checkIn" class="form-control" required>
        </div>
        <div class="col-12 col-md-3">
          <label class="form-label small muted">Check-out</label>
          <input type="date" name="checkOut" class="form-control" required>
        </div>
        <div class="col-12 col-md-2">
          <label class="form-label small muted">Guests</label>
          <input type="number" name="guests" class="form-control" min="1" value="2" required>
        </div>
        <div class="col-12 col-md-2">
          <label class="form-label small muted">Type</label>
          <select name="type" class="form-select">
            <option value="">Any</option>
            <option>Standard</option>
            <option>Deluxe</option>
            <option>Family</option>
            <option>Suite</option>
          </select>
        </div>
        <div class="col-12 col-md-2 d-grid">
          <button class="btn btn-gold btn-lg">Check Availability</button>
        </div>
      </form>
    </div>
  </div>
</section>

<section class="py-5">
  <div class="container">
    <h5 class="section-title">ABOUT THE HOTEL</h5>
    <p class="muted mt-2">
      Spacious rooms, fine dining, pool & spa facilities, and a reservation system that instantly confirms your booking.
    </p>

    <div class="row g-4 mt-2">
      <div class="col-md-4">
        <div class="p-4 border rounded-4">
          <h6 class="fw-bold">Prime Location</h6>
          <div class="muted">Close to the city center and oceanfront attractions.</div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="p-4 border rounded-4">
          <h6 class="fw-bold">Luxury Rooms</h6>
          <div class="muted">Comfortable interiors and premium service.</div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="p-4 border rounded-4">
          <h6 class="fw-bold">Fast Booking</h6>
          <div class="muted">Check availability and reserve instantly.</div>
        </div>
      </div>
    </div>
  </div>
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
