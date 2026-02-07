<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="hero lux-grid">
  <div class="container">
    <div class="section-badge"> CITY LUXURY</div>
    <h1 class="mt-2">Experience timeless comfort by the ocean</h1>
    <p class="mt-3">
      Discover elegant rooms, premium service, and an instant reservation system.
    </p>

    <div class="booking-bar glass-card">
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

<div class="container floating-booking">
  <div class="glass-card p-4">
    <div class="row g-4 align-items-stretch">
      <div class="col-md-4">
        <div class="d-flex gap-3">
          <div class="icon-pill">★</div>
          <div>
            <h6 class="fw-bold mb-1">Luxury Experience</h6>
            <div class="muted">Premium rooms, curated service, and comfortable stays.</div>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="d-flex gap-3">
          <div class="icon-pill">⌂</div>
          <div>
            <h6 class="fw-bold mb-1">Prime Location</h6>
            <div class="muted">Close to city attractions with oceanfront views.</div>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="d-flex gap-3">
          <div class="icon-pill">⚡</div>
          <div>
            <h6 class="fw-bold mb-1">Instant Booking</h6>
            <div class="muted">Check availability and reserve in one smooth flow.</div>
          </div>
        </div>
      </div>
    </div>

    <div class="lux-divider"></div>

    <div class="row g-4">
      <div class="col-lg-7">
        <h5 class="section-title">ABOUT THE HOTEL</h5>
        <p class="muted mt-2">
          Ocean View Resorts blends elegance and simplicity: spacious rooms, professional staff, and a seamless booking experience.
          Enjoy fine dining, pool & spa facilities, and calm interiors designed for rest.
        </p>

        <div class="row g-3 mt-1">
          <div class="col-sm-6">
            <div class="p-3 border rounded-4 bg-white">
              <div class="section-badge">Dining</div>
              <div class="mt-2 muted">Signature meals, curated menus, and warm ambiance.</div>
            </div>
          </div>
          <div class="col-sm-6">
            <div class="p-3 border rounded-4 bg-white">
              <div class="section-badge">Wellness</div>
              <div class="mt-2 muted">Spa treatments and a calm poolside atmosphere.</div>
            </div>
          </div>
          <div class="col-sm-6">
            <div class="p-3 border rounded-4 bg-white">
              <div class="section-badge">Events</div>
              <div class="mt-2 muted">Meeting rooms and event-friendly spaces.</div>
            </div>
          </div>
          <div class="col-sm-6">
            <div class="p-3 border rounded-4 bg-white">
              <div class="section-badge">Support</div>
              <div class="mt-2 muted">Fast help from staff and easy reservation changes.</div>
            </div>
          </div>
        </div>

        <div class="mt-4 d-flex gap-2">
          <a class="btn btn-gold" href="<c:url value='/rooms'/>">Explore Rooms</a>
          <a class="btn btn-outline-dark" href="<c:url value='/availability'/>">Check Availability</a>
        </div>
      </div>

      <div class="col-lg-5">
        <div class="glass-card p-3">
          <div class="room-img-frame">
            <img src="<c:url value='/assets/img/home/home-1.jpg'/>" alt="Hotel view">
          </div>
          <div class="mt-3">
            <div class="section-badge">Featured</div>
            <h6 class="fw-bold mt-2 mb-1">Oceanfront Suites</h6>
            <div class="muted">A refined stay designed for comfort and calm.</div>
          </div>
        </div>
      </div>
    </div>

    <!-- ✅ Image Section UNDER all texts (as requested) -->
    <div class="lux-divider"></div>
    <h6 class="fw-bold mb-3">Gallery</h6>

    <div class="row g-3">
      <div class="col-md-4">
        <div class="room-img-frame">
          <img src="<c:url value='/assets/img/home/home-1.jpg'/>" alt="Gallery 1">
        </div>
      </div>
      <div class="col-md-4">
        <div class="room-img-frame">
          <img src="<c:url value='/assets/img/home/home-2.jpg'/>" alt="Gallery 2">
        </div>
      </div>
      <div class="col-md-4">
        <div class="room-img-frame">
          <img src="<c:url value='/assets/img/home/home-3.jpg'/>" alt="Gallery 3">
        </div>
      </div>
    </div>

  </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
