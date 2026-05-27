<template>
  <footer class="bg-primary text-white">
    <div class="max-w-[1280px] mx-auto px-6 py-12 grid grid-cols-1 md:grid-cols-3 gap-8 items-start">

      <!-- Brand -->
      <div class="flex flex-col gap-5">
        <RouterLink to="/" aria-label="ManAndTruck Moving &amp; Cleaning — Home">
          <svg class="h-[50px] w-auto" viewBox="0 0 220 52" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
            <rect x="2" y="12" width="30" height="20" rx="2" fill="#fff" opacity=".8"/>
            <rect x="32" y="18" width="18" height="14" rx="2" fill="#a8d8ea" opacity=".65"/>
            <circle cx="11" cy="34" r="5" fill="#a8d8ea"/><circle cx="11" cy="34" r="2.5" fill="#1d3557"/>
            <circle cx="39" cy="34" r="5" fill="#a8d8ea"/><circle cx="39" cy="34" r="2.5" fill="#1d3557"/>
            <text x="58" y="30" font-family="Oswald,sans-serif" font-size="17" font-weight="700" fill="#ffffff" letter-spacing="1">MAN &amp; TRUCK</text>
            <text x="58" y="44" font-family="Open Sans,sans-serif" font-size="9" font-weight="600" fill="#a8d8ea" letter-spacing="1">MOVING &amp; CLEANING</text>
          </svg>
        </RouterLink>
        <p class="text-white/80 text-sm leading-relaxed max-w-[260px]">
          Professional moving and cleaning services you can trust. Dedicated to a stress-free move and a spotless space.
        </p>
        <div class="flex gap-3" aria-label="Social media">
          <a v-for="s in socials" :key="s.label" :href="s.href" :aria-label="s.label" rel="noopener noreferrer"
            class="w-9 h-9 border border-white/30 rounded-full flex items-center justify-center text-white/70 hover:bg-accent hover:text-primary hover:border-accent transition-all duration-200">
            <span class="w-[18px] h-[18px]" v-html="s.svg"></span>
          </a>
        </div>
      </div>

      <!-- Links -->
      <nav aria-label="Footer navigation">
        <ul class="flex flex-wrap gap-x-6 gap-y-2">
          <li v-for="link in links" :key="link.to">
            <RouterLink :to="link.to"
              class="font-heading text-[0.85rem] font-semibold uppercase tracking-wide text-white/90 hover:text-accent transition-colors duration-200">
              {{ link.label }}
            </RouterLink>
          </li>
        </ul>
      </nav>

      <!-- Contact -->
      <div class="flex flex-col gap-4">
        <p class="text-white/70 text-[0.74rem] uppercase tracking-[0.09em] font-heading font-semibold">Contact Us</p>
        <a href="tel:+14165550136" class="text-white/90 font-semibold text-base hover:text-accent transition-colors">(416) 555-0136</a>
        <RouterLink to="/contact" class="text-white/85 text-sm hover:text-accent transition-colors">Contact Form (Inquiry and Booking)</RouterLink>
        <p class="text-white/75 text-sm leading-relaxed">Office Hours: Mon-Sun, 8am - 8pm<br/>Move Scheduling: Sat-Sun only, 2+ weeks ahead</p>
        <RouterLink to="/quote" class="inline-block px-5 py-2.5 border-2 border-white text-white font-heading font-semibold text-sm uppercase tracking-wide rounded text-center hover:bg-white hover:text-primary transition-all duration-200">
          Get a Free Quote
        </RouterLink>
      </div>

    </div>

    <div class="bg-primary-dark px-6 py-5 text-center">
      <nav class="flex flex-wrap justify-center gap-x-6 gap-y-1 mb-2" aria-label="Legal links">
        <RouterLink v-for="l in legal" :key="l.to" :to="l.to"
          class="text-[0.78rem] uppercase tracking-wide font-heading font-semibold text-white/80 hover:text-accent transition-colors">
          {{ l.label }}
        </RouterLink>
      </nav>
      <p class="text-[0.78rem] text-white/70">&copy; {{ year }} ManAndTruck Moving &amp; Cleaning. All rights reserved. &nbsp;|&nbsp; Guelph-based, serving cities across Ontario</p>
    </div>
  </footer>
</template>

<script setup>
const year = new Date().getFullYear()

const links = [
  { to: '/',                         label: 'Home' },
  { to: '/services',                 label: 'Services' },
  { to: '/services/local-moving',    label: 'Local Moving' },
  { to: '/services/long-distance-moving', label: 'Long Distance' },
  { to: '/services/commercial-moving', label: 'Commercial' },
  { to: '/services/packing-services', label: 'Packing' },
  { to: '/services/storage',          label: 'Storage' },
  { to: '/services/cleaning-services', label: 'Cleaning' },
  { to: '/about',                    label: 'About Us' },
  { to: '/locations',                label: 'Locations' },
  { to: '/reviews',                  label: 'Reviews' },
  { to: '/blog',                     label: 'Blog' },
  { to: '/contact',                  label: 'Contact' },
  { to: '/quote',                    label: 'Get a Quote' },
]

const legal = [
  { to: '/privacy',       label: 'Privacy Policy' },
  { to: '/terms',         label: 'Terms of Service' },
  { to: '/accessibility', label: 'Accessibility' },
]

const socials = [
  {
    label: 'Facebook', href: 'https://www.facebook.com/search/top?q=man%20and%20truck%20movers%20guelph',
    svg: `<svg viewBox="0 0 24 24" fill="currentColor"><path d="M18 2h-3a5 5 0 00-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 011-1h3z"/></svg>`,
  },
  {
    label: 'Instagram', href: 'https://www.instagram.com/explore/tags/movingcompany/',
    svg: `<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="2" width="20" height="20" rx="5"/><path d="M16 11.37A4 4 0 1112.63 8 4 4 0 0116 11.37z"/><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"/></svg>`,
  },
  {
    label: 'Google Reviews', href: 'https://www.google.com/maps/search/?api=1&query=Man+And+Truck+Movers+Guelph',
    svg: `<svg viewBox="0 0 24 24" fill="currentColor"><path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/><path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/><path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/><path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/></svg>`,
  },
]
</script>
