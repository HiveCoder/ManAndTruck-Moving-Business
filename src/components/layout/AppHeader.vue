<template>
  <header ref="headerEl" class="sticky top-0 z-40 bg-white shadow-card h-[72px] transition-shadow duration-200">
    <div class="max-w-[1280px] mx-auto px-6 h-full flex items-center gap-6 relative">

      <!-- Logo -->
      <RouterLink to="/" class="flex-shrink-0" aria-label="ManAndTruck Movers — Home">
        <svg class="h-[52px] w-auto" viewBox="0 0 220 52" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
          <rect x="2" y="12" width="30" height="20" rx="2" fill="#1d3557"/>
          <rect x="32" y="18" width="18" height="14" rx="2" fill="#457b9d"/>
          <circle cx="11" cy="34" r="5" fill="#457b9d"/><circle cx="11" cy="34" r="2.5" fill="#fff"/>
          <circle cx="39" cy="34" r="5" fill="#457b9d"/><circle cx="39" cy="34" r="2.5" fill="#fff"/>
          <text x="58" y="30" font-family="Oswald,sans-serif" font-size="17" font-weight="700" fill="#1d3557" letter-spacing="1">MAN &amp; TRUCK</text>
          <text x="58" y="44" font-family="Open Sans,sans-serif" font-size="10" font-weight="600" fill="#457b9d" letter-spacing="2">MOVERS</text>
        </svg>
      </RouterLink>

      <!-- Desktop Nav -->
      <nav class="hidden lg:flex items-center flex-1 h-full" aria-label="Main navigation">
        <ul class="flex h-full">

          <li class="nav-item">
            <RouterLink to="/" class="nav-link" :class="{ active: $route.path === '/' }">Home</RouterLink>
          </li>

          <li class="nav-item has-dropdown relative">
            <RouterLink to="/services" class="nav-link" :class="{ active: $route.path.startsWith('/services') }">Services</RouterLink>
            <ul class="nav-dropdown">
              <li><RouterLink to="/services/local-moving"       class="dd-link">Local Moving</RouterLink></li>
              <li><RouterLink to="/services/long-distance-moving" class="dd-link">Long Distance</RouterLink></li>
              <li class="has-subdropdown relative">
                <RouterLink to="/services/commercial-moving" class="dd-link justify-between">Commercial Moving <span>›</span></RouterLink>
                <ul class="nav-subdropdown">
                  <li><RouterLink to="/services/commercial-moving" class="sub-link">Office Moves</RouterLink></li>
                  <li><RouterLink to="/services/commercial-moving" class="sub-link">Business Relocation</RouterLink></li>
                  <li><RouterLink to="/services/commercial-moving" class="sub-link">Warehouse Moving</RouterLink></li>
                </ul>
              </li>
              <li><RouterLink to="/services/packing-services"  class="dd-link">Packing &amp; Unpacking</RouterLink></li>
              <li><RouterLink to="/services/specialty-items"   class="dd-link">Specialty Items</RouterLink></li>
              <li><RouterLink to="/services/storage"           class="dd-link">Storage Solutions</RouterLink></li>
            </ul>
          </li>

          <li class="nav-item has-dropdown relative">
            <RouterLink to="/locations" class="nav-link" :class="{ active: $route.path.startsWith('/locations') }">Locations</RouterLink>
            <ul class="nav-dropdown">
              <li><RouterLink to="/locations" class="dd-link">Guelph (Head Office)</RouterLink></li>
              <li><RouterLink to="/locations" class="dd-link">Kitchener</RouterLink></li>
              <li><RouterLink to="/locations" class="dd-link">Waterloo</RouterLink></li>
              <li><RouterLink to="/locations" class="dd-link">Cambridge</RouterLink></li>
            </ul>
          </li>

          <li class="nav-item"><RouterLink to="/about"    class="nav-link" :class="{ active: $route.path === '/about' }">About</RouterLink></li>
          <li class="nav-item"><RouterLink to="/reviews"  class="nav-link" :class="{ active: $route.path === '/reviews' }">Reviews</RouterLink></li>
          <li class="nav-item"><RouterLink to="/blog"     class="nav-link" :class="{ active: $route.path.startsWith('/blog') }">Blog</RouterLink></li>
          <li class="nav-item"><RouterLink to="/contact"  class="nav-link" :class="{ active: $route.path === '/contact' }">Contact</RouterLink></li>
          <li class="nav-item"><RouterLink to="/admin/quotes"  class="nav-link" :class="{ active: $route.path === '/admin/quotes' }">Admin Quotes</RouterLink></li>

          <li class="flex items-center gap-3 px-4 ml-2">
            <a href="tel:+14165550136" class="flex items-center gap-1.5 text-primary font-semibold text-[0.85rem] hover:text-secondary transition-colors">
              <PhoneIcon class="w-4 h-4" />
              (416) 555-0136
            </a>
            <RouterLink to="/quote" class="btn-primary-sm">Get a Quote</RouterLink>
          </li>

        </ul>
      </nav>

      <!-- Mobile header actions -->
      <div class="lg:hidden flex items-center gap-3 ml-auto">
        <a href="tel:+14165550136" class="text-primary font-semibold text-sm hover:text-secondary transition-colors flex items-center gap-1">
          <PhoneIcon class="w-4 h-4" />
        </a>
        <RouterLink to="/quote" class="btn-primary-sm">Quote</RouterLink>
        <button
          :class="['hamburger flex flex-col justify-center gap-[5px] w-9 h-9 p-1', { open: mobileOpen }]"
          @click="toggleMobile"
          :aria-expanded="mobileOpen"
          aria-controls="mobileNav"
          aria-label="Toggle navigation"
        >
          <span class="hamburger-bar w-full"></span>
          <span class="hamburger-bar w-full"></span>
          <span class="hamburger-bar w-full"></span>
        </button>
      </div>

    </div>
  </header>

  <!-- Mobile Nav Overlay -->
  <nav
    id="mobileNav"
    :class="['mobile-nav lg:hidden fixed inset-0 top-[112px] bg-white z-30 overflow-y-auto pb-8', { open: mobileOpen }]"
    aria-label="Mobile navigation"
  >
    <ul>
      <li><RouterLink to="/"         @click="closeMobile" class="mob-link">Home</RouterLink></li>

      <li :class="['mobile-nav-item', { open: openGroup === 'services' }]">
        <button @click="toggleGroup('services')" class="mob-link w-full flex justify-between items-center">
          Services <span class="text-lg">›</span>
        </button>
        <ul class="mobile-dropdown bg-light-bg">
          <li><RouterLink to="/services/local-moving"        @click="closeMobile" class="mob-sub-link">Local Moving</RouterLink></li>
          <li><RouterLink to="/services/long-distance-moving" @click="closeMobile" class="mob-sub-link">Long Distance Moving</RouterLink></li>
          <li><RouterLink to="/services/commercial-moving"   @click="closeMobile" class="mob-sub-link">Commercial Moving</RouterLink></li>
          <li><RouterLink to="/services/packing-services"    @click="closeMobile" class="mob-sub-link">Packing &amp; Unpacking</RouterLink></li>
          <li><RouterLink to="/services/specialty-items"     @click="closeMobile" class="mob-sub-link">Specialty Items</RouterLink></li>
          <li><RouterLink to="/services/storage"             @click="closeMobile" class="mob-sub-link">Storage Solutions</RouterLink></li>
        </ul>
      </li>

      <li :class="['mobile-nav-item', { open: openGroup === 'locations' }]">
        <button @click="toggleGroup('locations')" class="mob-link w-full flex justify-between items-center">
          Locations <span class="text-lg">›</span>
        </button>
        <ul class="mobile-dropdown bg-light-bg">
          <li><RouterLink to="/locations" @click="closeMobile" class="mob-sub-link">Guelph (Head Office)</RouterLink></li>
          <li><RouterLink to="/locations" @click="closeMobile" class="mob-sub-link">Kitchener</RouterLink></li>
          <li><RouterLink to="/locations" @click="closeMobile" class="mob-sub-link">Waterloo</RouterLink></li>
          <li><RouterLink to="/locations" @click="closeMobile" class="mob-sub-link">Cambridge</RouterLink></li>
        </ul>
      </li>

      <li><RouterLink to="/about"   @click="closeMobile" class="mob-link">About</RouterLink></li>
      <li><RouterLink to="/reviews" @click="closeMobile" class="mob-link">Reviews</RouterLink></li>
      <li><RouterLink to="/blog"    @click="closeMobile" class="mob-link">Blog</RouterLink></li>
      <li><RouterLink to="/contact" @click="closeMobile" class="mob-link">Contact</RouterLink></li>
      <li><RouterLink to="/admin/quotes" @click="closeMobile" class="mob-link">Admin Quotes</RouterLink></li>

      <li class="flex flex-col gap-3 px-6 pt-4">
        <a href="tel:+14165550136" class="flex items-center gap-2 text-primary font-semibold">
          <PhoneIcon class="w-5 h-5" /> (416) 555-0136
        </a>
        <RouterLink to="/quote" @click="closeMobile" class="btn-primary-sm text-center">Get a Free Quote</RouterLink>
      </li>
    </ul>
  </nav>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

// Inline phone icon SVG as a tiny functional component
const PhoneIcon = {
  template: `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 16.92v3a2 2 0 01-2.18 2 19.79 19.79 0 01-8.63-3.07A19.5 19.5 0 013.07 9.81a19.79 19.79 0 01-3.07-8.63A2 2 0 012 0h3a2 2 0 012 1.72 12.84 12.84 0 00.7 2.81 2 2 0 01-.45 2.11L6.09 7.91a16 16 0 006 6l1.27-1.27a2 2 0 012.11-.45 12.84 12.84 0 002.81.7A2 2 0 0122 14v2.92z"/></svg>`,
}

const headerEl  = ref(null)
const mobileOpen = ref(false)
const openGroup  = ref(null)

function toggleMobile() {
  mobileOpen.value = !mobileOpen.value
  document.body.style.overflow = mobileOpen.value ? 'hidden' : ''
}
function closeMobile() {
  mobileOpen.value = false
  openGroup.value  = null
  document.body.style.overflow = ''
}
function toggleGroup(name) {
  openGroup.value = openGroup.value === name ? null : name
}

function onKeyDown(e) {
  if (e.key === 'Escape' && mobileOpen.value) closeMobile()
}

onMounted(() => document.addEventListener('keydown', onKeyDown))
onUnmounted(() => {
  document.removeEventListener('keydown', onKeyDown)
  document.body.style.overflow = ''
})
</script>

<style scoped>
.nav-link {
  @apply flex items-center whitespace-nowrap h-full px-4 font-heading text-[0.97rem] font-semibold uppercase tracking-wide text-primary relative transition-colors duration-200 hover:text-secondary;
}
.nav-link::after {
  content: '';
  @apply absolute bottom-0 left-4 right-4 h-[3px] bg-secondary transition-transform duration-200;
  transform: scaleX(0);
}
.nav-link:hover::after,
.nav-link.active::after { transform: scaleX(1); }
.nav-link.active { @apply text-secondary; }

.dd-link {
  @apply flex items-center px-[1.1rem] py-[0.65rem] font-heading text-[0.87rem] font-semibold uppercase tracking-wide text-primary border-b border-border transition-colors duration-200 hover:bg-light-bg hover:text-secondary last:border-b-0;
}
.sub-link {
  @apply block px-4 py-[0.6rem] font-body text-[0.84rem] text-gray-700 border-b border-border transition-colors duration-200 hover:bg-light-bg hover:text-secondary last:border-b-0;
}

.btn-primary-sm {
  @apply inline-block px-4 py-2 bg-primary text-white font-heading font-semibold text-sm uppercase tracking-wide rounded transition-colors duration-200 hover:bg-primary-dark;
}

.mob-link {
  @apply block px-6 py-[0.9rem] font-heading text-base font-semibold uppercase tracking-wide text-primary border-b border-border transition-colors duration-200 hover:text-secondary;
}
.mob-sub-link {
  @apply block px-8 py-3 font-body text-sm text-gray-700 border-b border-border transition-colors duration-200 hover:text-secondary;
}
</style>
