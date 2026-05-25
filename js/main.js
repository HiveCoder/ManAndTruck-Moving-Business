/**
 * ManAndTruck Movers — Main JavaScript
 */

(function () {
  'use strict';

  /* ===== ANNOUNCEMENT BAR SLIDER ===== */
  (function initAnnouncementBar() {
    const slides = document.querySelectorAll('.announcement-slide');
    const prevBtn = document.querySelector('.ann-prev');
    const nextBtn = document.querySelector('.ann-next');
    if (!slides.length) return;

    let current = 0;
    let timer = null;

    function show(index) {
      slides[current].classList.remove('active');
      current = (index + slides.length) % slides.length;
      slides[current].classList.add('active');
    }

    function startAuto() {
      timer = setInterval(function () { show(current + 1); }, 5000);
    }

    function resetAuto() {
      clearInterval(timer);
      startAuto();
    }

    if (prevBtn) prevBtn.addEventListener('click', function () { show(current - 1); resetAuto(); });
    if (nextBtn) nextBtn.addEventListener('click', function () { show(current + 1); resetAuto(); });

    startAuto();
  })();

  /* ===== MOBILE NAVIGATION ===== */
  (function initNav() {
    const toggle = document.getElementById('menuToggle');
    const nav = document.getElementById('mainNav');
    if (!toggle || !nav) return;

    toggle.addEventListener('click', function () {
      const open = nav.classList.toggle('open');
      toggle.classList.toggle('open', open);
      toggle.setAttribute('aria-expanded', String(open));
      document.body.style.overflow = open ? 'hidden' : '';
    });

    // Close nav on outside click
    document.addEventListener('click', function (e) {
      if (nav.classList.contains('open') &&
          !nav.contains(e.target) &&
          !toggle.contains(e.target)) {
        nav.classList.remove('open');
        toggle.classList.remove('open');
        toggle.setAttribute('aria-expanded', 'false');
        document.body.style.overflow = '';
      }
    });

    // Mobile: Toggle sub-dropdowns on click
    if (window.innerWidth < 1024) {
      const items = nav.querySelectorAll('.has-dropdown, .has-subdropdown');
      items.forEach(function (item) {
        const link = item.querySelector(':scope > a');
        if (!link) return;
        link.addEventListener('click', function (e) {
          e.preventDefault();
          item.classList.toggle('open');
        });
      });
    }

    // Close nav on Escape
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape' && nav.classList.contains('open')) {
        nav.classList.remove('open');
        toggle.classList.remove('open');
        toggle.setAttribute('aria-expanded', 'false');
        document.body.style.overflow = '';
      }
    });
  })();

  /* ===== GENERIC SLIDER FACTORY ===== */
  function createSlider(trackId, dotsId, prevId, nextId, visibleFn) {
    const track = document.getElementById(trackId);
    const dotsContainer = document.getElementById(dotsId);
    const prevBtn = document.getElementById(prevId);
    const nextBtn = document.getElementById(nextId);
    if (!track) return;

    const cards = track.children;
    let current = 0;
    let autoTimer = null;

    function getVisible() {
      if (typeof visibleFn === 'function') return visibleFn();
      const w = window.innerWidth;
      if (w >= 1200) return 4;
      if (w >= 900) return 3;
      if (w >= 600) return 2;
      return 1;
    }

    function totalSlides() {
      return Math.max(0, cards.length - getVisible() + 1);
    }

    function goTo(index) {
      const total = totalSlides();
      current = Math.max(0, Math.min(index, total - 1));
      const cardW = cards[0] ? cards[0].offsetWidth : 0;
      track.style.transform = 'translateX(-' + (current * cardW) + 'px)';
      // Update dots
      if (dotsContainer) {
        const dots = dotsContainer.querySelectorAll('.dot');
        dots.forEach(function (d, i) { d.classList.toggle('active', i === current); });
      }
    }

    function startAuto() {
      autoTimer = setInterval(function () {
        const next = current + 1 >= totalSlides() ? 0 : current + 1;
        goTo(next);
      }, 4500);
    }

    if (prevBtn) prevBtn.addEventListener('click', function () {
      clearInterval(autoTimer);
      goTo(current - 1);
      startAuto();
    });
    if (nextBtn) nextBtn.addEventListener('click', function () {
      clearInterval(autoTimer);
      goTo(current + 1);
      startAuto();
    });

    if (dotsContainer) {
      dotsContainer.querySelectorAll('.dot').forEach(function (dot, i) {
        dot.addEventListener('click', function () {
          clearInterval(autoTimer);
          goTo(i);
          startAuto();
        });
      });
    }

    // Touch swipe support
    let touchStartX = 0;
    track.addEventListener('touchstart', function (e) {
      touchStartX = e.touches[0].clientX;
    }, { passive: true });
    track.addEventListener('touchend', function (e) {
      const dx = e.changedTouches[0].clientX - touchStartX;
      if (Math.abs(dx) > 50) {
        clearInterval(autoTimer);
        goTo(dx < 0 ? current + 1 : current - 1);
        startAuto();
      }
    }, { passive: true });

    window.addEventListener('resize', function () { goTo(current); });

    startAuto();
    goTo(0);
  }

  /* ===== RTB SLIDER (Why ManAndTruck) ===== */
  createSlider('rtbTrack', 'rtbDots', 'rtbPrev', 'rtbNext', function () {
    const w = window.innerWidth;
    if (w >= 900) return 3;
    if (w >= 600) return 2;
    return 1;
  });

  /* ===== SERVICES SLIDER ===== */
  createSlider('servicesTrack', 'servicesDots', 'servicesPrev', 'servicesNext');

  /* ===== BLOG SLIDER ===== */
  createSlider('blogTrack', 'blogDots', 'blogPrev', 'blogNext', function () {
    const w = window.innerWidth;
    if (w >= 900) return 3;
    if (w >= 600) return 2;
    return 1;
  });

  /* ===== QUOTE FORM VALIDATION ===== */
  (function initQuoteForm() {
    const form = document.getElementById('quoteForm');
    if (!form) return;

    const noDate = document.getElementById('noDate');
    const moveDate = document.getElementById('moveDate');
    if (noDate && moveDate) {
      noDate.addEventListener('change', function () {
        moveDate.disabled = this.checked;
        if (this.checked) moveDate.value = '';
      });
    }

    form.addEventListener('submit', function (e) {
      e.preventDefault();
      let valid = true;

      // Clear previous errors
      form.querySelectorAll('.error').forEach(function (el) { el.classList.remove('error'); });

      const required = form.querySelectorAll('[required]');
      required.forEach(function (field) {
        if (field.type === 'checkbox') {
          if (!field.checked) { field.closest('.checkbox-label').style.color = '#e63946'; valid = false; }
          else { field.closest('.checkbox-label').style.color = ''; }
        } else if (!field.value.trim()) {
          field.classList.add('error');
          valid = false;
        }
      });

      // Validate email
      const email = form.querySelector('#email');
      if (email && email.value && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) {
        email.classList.add('error');
        valid = false;
      }

      // Validate phone
      const phone = form.querySelector('#phone');
      if (phone && phone.value && !/^\+?[\d\s\-().]{7,15}$/.test(phone.value)) {
        phone.classList.add('error');
        valid = false;
      }

      // Validate zip codes
      form.querySelectorAll('input[pattern]').forEach(function (input) {
        if (input.value && !new RegExp(input.getAttribute('pattern')).test(input.value)) {
          input.classList.add('error');
          valid = false;
        }
      });

      if (valid) {
        const successMsg = document.querySelector('.form-success');
        form.style.display = 'none';
        if (successMsg) successMsg.classList.add('visible');
      }
    });
  })();

  /* ===== FAQ ACCORDION ===== */
  (function initFAQ() {
    const items = document.querySelectorAll('.faq-item');
    items.forEach(function (item) {
      const question = item.querySelector('.faq-question');
      if (!question) return;
      question.addEventListener('click', function () {
        const wasOpen = item.classList.contains('open');
        items.forEach(function (i) { i.classList.remove('open'); });
        if (!wasOpen) item.classList.add('open');
      });
    });
  })();

  /* ===== SCROLL ANIMATIONS ===== */
  (function initScrollAnimations() {
    const elements = document.querySelectorAll('.fade-in');
    if (!elements.length) return;

    if ('IntersectionObserver' in window) {
      const observer = new IntersectionObserver(function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add('visible');
            observer.unobserve(entry.target);
          }
        });
      }, { threshold: 0.15 });
      elements.forEach(function (el) { observer.observe(el); });
    } else {
      elements.forEach(function (el) { el.classList.add('visible'); });
    }
  })();

  /* ===== BACK TO TOP BUTTON ===== */
  (function initBackToTop() {
    const btn = document.querySelector('.back-to-top');
    if (!btn) return;
    window.addEventListener('scroll', function () {
      btn.classList.toggle('visible', window.scrollY > 400);
    });
    btn.addEventListener('click', function () {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  })();

  /* ===== STICKY HEADER SHADOW ===== */
  (function initHeaderScroll() {
    const header = document.querySelector('.site-header');
    if (!header) return;
    window.addEventListener('scroll', function () {
      header.style.boxShadow = window.scrollY > 10
        ? '0 4px 20px rgba(29,53,87,0.18)'
        : '0 2px 12px rgba(29,53,87,0.10)';
    });
  })();

  /* ===== CONTACT FORM ===== */
  (function initContactForm() {
    const form = document.getElementById('contactForm');
    if (!form) return;
    form.addEventListener('submit', function (e) {
      e.preventDefault();
      const inputs = form.querySelectorAll('[required]');
      let valid = true;
      inputs.forEach(function (inp) {
        if (!inp.value.trim()) { inp.classList.add('error'); valid = false; }
        else inp.classList.remove('error');
      });
      if (valid) {
        form.innerHTML = '<p style="color:#155724;font-weight:600;padding:1rem;background:#d4edda;border-radius:6px;text-align:center;">Thank you! We\'ll be in touch shortly.</p>';
      }
    });
  })();

})();
