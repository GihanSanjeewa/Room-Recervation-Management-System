
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- ✅ Extra CDN (modern icons + animations) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="https://unpkg.com/aos@2.3.4/dist/aos.css"/>

<style>
  :root{
    --lux-bg: #0b1220;
    --lux-card: rgba(255,255,255,.08);
    --lux-border: rgba(255,255,255,.14);
    --lux-text: rgba(255,255,255,.92);
    --lux-muted: rgba(255,255,255,.70);
    --lux-gold: #d6b56c;
  }

  body{ background: var(--lux-bg); color: var(--lux-text); }

  .hero{
    position: relative;
    padding: 110px 0 140px;
    overflow: hidden;
  }
  .hero::before{
    content:"";
    position:absolute; inset:0;
    background:
      radial-gradient(1200px 400px at 10% 10%, rgba(214,181,108,.35), transparent 60%),
      radial-gradient(1000px 500px at 90% 20%, rgba(102,126,234,.30), transparent 60%),
      linear-gradient(135deg, rgba(118,75,162,.25), rgba(0,0,0,.1));
    filter: saturate(1.2);
  }
  .hero .container{ position: relative; z-index: 1; }

  .badge-soft{
    display:inline-flex; gap:8px; align-items:center;
    padding:8px 14px; border:1px solid var(--lux-border);
    background: rgba(255,255,255,.06);
    border-radius: 999px; font-size: 12px; letter-spacing: .18em;
    text-transform: uppercase; color: var(--lux-muted);
  }

  .glass{
    background: var(--lux-card);
    border:1px solid var(--lux-border);
    border-radius: 18px;
    backdrop-filter: blur(10px);
    box-shadow: 0 12px 40px rgba(0,0,0,.35);
  }

  .btn-gold{
    background: var(--lux-gold);
    border: 1px solid rgba(0,0,0,.15);
    color:#111;
    font-weight: 700;
  }
  .btn-gold:hover{ filter: brightness(.95); }

  .booking-bar{
    margin-top: 28px;
    padding: 16px;
  }

  .floating{
    margin-top: -70px;
    position: relative;
    z-index: 2;
  }

  .feature{
    padding: 16px;
    border-radius: 16px;
    background: rgba(255,255,255,.05);
    border:1px solid var(--lux-border);
    height: 100%;
  }
  .feature i{
    width:44px; height:44px; display:inline-flex;
    align-items:center; justify-content:center;
    border-radius: 14px;
    background: rgba(214,181,108,.18);
    border:1px solid rgba(214,181,108,.30);
    color: var(--lux-gold);
    font-size: 20px;
  }

  .section-title{
    letter-spacing:.18em; text-transform:uppercase;
    color: var(--lux-muted); font-size: 12px;
  }

  .img-frame{
    border-radius: 18px;
    overflow:hidden;
    border:1px solid var(--lux-border);
    background: rgba(255,255,255,.03);
  }
  .img-frame img{
    width:100%; height: 320px; object-fit: cover;
    transform: scale(1.02);
    transition: .35s ease;
  }
  .img-frame:hover img{ transform: scale(1.08); }

  .mini-divider{
    height:1px; background: rgba(255,255,255,.12);
    margin: 28px 0;
  }

  /* Sticky booking button on mobile */
  @media (max-width: 768px){
    .hero{ padding: 80px 0 120px; }
    .floating{ margin-top: -45px; }
  }
</style>

<section class="hero">
  <div class="container">
    <div class="row align-items-center g-5">
      <div class="col-lg-7" data-aos="fade-up">
        <div class="badge-soft">
          <i class="bi bi-stars"></i> CITY LUXURY
        </div>

        <h1 class="mt-3 display-5 fw-bold">
          <c:out value="${heroTitle}" />
        </h1>

        <p class="mt-3 fs-5" style="color: var(--lux-muted); max-width: 52ch;">
          <c:out value="${heroSubtitle}" />
        </p>

        <div class="booking-bar glass" data-aos="fade-up" data-aos-delay="120">
          <form class="row g-2 align-items-end" action="<c:url value='/availability'/>" method="get">
            <div class="col-12 col-md-3">
              <label class="form-label small" style="color: var(--lux-muted);">Check-in</label>
              <input type="date" name="checkIn" class="form-control" required>
            </div>
            <div class="col-12 col-md-3">
              <label class="form-label small" style="color: var(--lux-muted);">Check-out</label>
              <input type="date" name="checkOut" class="form-control" required>
            </div>
            <div class="col-12 col-md-2">
              <label class="form-label small" style="color: var(--lux-muted);">Guests</label>
              <input type="number" name="guests" class="form-control" min="1" value="2" required>
            </div>
            <div class="col-12 col-md-2">
              <label class="form-label small" style="color: var(--lux-muted);">Type</label>
              <select name="type" class="form-select">
                <option value="">Any</option>
                <option>Standard</option>
                <option>Deluxe</option>
                <option>Family</option>
                <option>Suite</option>
              </select>
            </div>
            <div class="col-12 col-md-2 d-grid">
              <button class="btn btn-gold btn-lg">
                Check Availability <i class="bi bi-arrow-right-short"></i>
              </button>
            </div>
          </form>
        </div>
      </div>

      <!-- Right side hero image -->
      <div class="col-lg-5" data-aos="fade-left">
        <div class="glass p-3">
          <div class="img-frame">
            <img src="https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=1200" alt="Hotel view">
          </div>
          <div class="mt-3">
            <div class="section-title">Featured</div>
            <h6 class="fw-bold mt-2 mb-1">Oceanfront Suites</h6>
            <div style="color: var(--lux-muted);">A refined stay designed for comfort and calm.</div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<div class="container floating">
  <div class="glass p-4">

    <!-- ✅ Feature cards (modern + consistent) -->
    <div class="row g-3" data-aos="fade-up">
      <div class="col-md-4">
        <div class="feature">
          <div class="d-flex gap-3">
            <i class="bi bi-gem"></i>
            <div>
              <h6 class="fw-bold mb-1">Luxury Experience</h6>
              <div style="color: var(--lux-muted);">Premium rooms, curated service, and comfort-first design.</div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="feature">
          <div class="d-flex gap-3">
            <i class="bi bi-geo-alt"></i>
            <div>
              <h6 class="fw-bold mb-1">Prime Location</h6>
              <div style="color: var(--lux-muted);">Close to attractions with calm oceanfront vibes.</div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="feature">
          <div class="d-flex gap-3">
            <i class="bi bi-lightning-charge"></i>
            <div>
              <h6 class="fw-bold mb-1">Instant Booking</h6>
              <div style="color: var(--lux-muted);">Check availability and reserve in a smooth flow.</div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="mini-divider"></div>

    <!-- ✅ Dynamic Featured Rooms (from DB later) -->
    <div class="d-flex align-items-end justify-content-between gap-3 flex-wrap" data-aos="fade-up">
      <div>
        <div class="section-title">Explore</div>
        <h4 class="fw-bold mb-0">Popular Rooms</h4>
       
      </div>
      <a class="btn btn-outline-light" href="<c:url value='/rooms'/>">View all rooms</a>
    </div>

    <div class="row g-3 mt-1">
      <c:forEach var="r" items="${featuredRooms}" begin="0" end="2">
        <div class="col-lg-4" data-aos="zoom-in" data-aos-delay="80">
          <div class="glass p-3 h-100">
            <div class="img-frame">
              <c:forEach var="img" items="${r.images}" varStatus="st">
		          <div class="carousel-item ${st.index==0 ? 'active' : ''}">
		            <img src="<c:url value='${img.imageUrl}'/>" class="d-block w-100" style="height:210px;object-fit:cover;">
		          </div>
		        </c:forEach>
            </div>
            <div class="mt-3">
              <div class="section-title">
                <c:out value="${r.type}" />
              </div>
              <h6 class="fw-bold mb-1">Room <c:out value="${r.roomNumber}" /></h6>
              <div style="color: var(--lux-muted);">
                Capacity: <c:out value="${r.capacity}" /> • LKR <c:out value="${r.pricePerNight}" /> / night
              </div>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>

    <div class="mini-divider"></div>

    <!-- ✅ Dynamic Gallery -->
    <div class="d-flex align-items-end justify-content-between gap-3 flex-wrap" data-aos="fade-up">
      <div>
        <div class="section-title">Gallery</div>
        <h4 class="fw-bold mb-0">A glimpse of your stay</h4>
      </div>
      <a class="btn btn-gold" href="<c:url value='/availability'/>">Book now</a>
    </div>

    <div class="row g-3 mt-2">
      <c:forEach var="img" items="${gallery}">
        <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
          <div class="img-frame">
            <img src="${img}" alt="Gallery">
          </div>
        </div>
      </c:forEach>
    </div>

  </div>
</div>

<script src="https://unpkg.com/aos@2.3.4/dist/aos.js"></script>
<script>
  AOS.init({ duration: 700, once: true });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
