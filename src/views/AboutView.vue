<template>
  <main>
    <PageHero title="About ManAndTruck Movers" subtitle="Family-owned, community-driven, and passionate about stress-free moving." badge="Our Story"
      :breadcrumbs="[{to:'/',label:'Home'},{label:'About Us'}]" />

    <section class="py-20 bg-white">
      <div class="max-w-[1280px] mx-auto px-6 grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
        <div class="flex flex-col gap-6">
          <p class="text-xs uppercase tracking-[0.2em] font-heading font-semibold text-secondary">Who We Are</p>
          <h2 class="font-heading text-3xl md:text-4xl font-bold text-primary uppercase tracking-wide leading-tight">
            Moving Families &amp; Businesses for Over 15 Years
          </h2>
          <p class="text-gray-700 leading-relaxed">ManAndTruck Movers was founded on a simple belief: moving should be a fresh start, not a nightmare. Since our first move in 2009, we've grown from a single truck to a fleet of 20+ vehicles — but we've never lost that family-business commitment to every customer.</p>
          <p class="text-gray-700 leading-relaxed">Our team of trained, background-checked professionals treat every home and office with the respect it deserves. From the first phone call to the final piece of furniture placed, we're with you every step of the way.</p>
          <div class="grid grid-cols-2 gap-4 mt-2">
            <div v-for="stat in stats" :key="stat.label" class="bg-light-bg rounded-xl p-5 text-center">
              <p class="font-heading font-bold text-3xl text-primary">{{ stat.val }}</p>
              <p class="text-xs uppercase tracking-wide font-heading font-semibold text-secondary mt-1">{{ stat.label }}</p>
            </div>
          </div>
        </div>
        <div class="rounded-2xl overflow-hidden aspect-square relative">
          <img
            src="https://images.unsplash.com/photo-1698917414969-feade59e3343?w=600&h=600&fit=crop&q=80"
            alt="Our professional moving team"
            class="w-full h-full object-cover"
            loading="lazy"
          />
          <div class="absolute inset-0 bg-gradient-to-t from-primary/60 to-transparent flex items-end p-8">
            <p class="text-white font-heading text-2xl font-bold uppercase tracking-wide">Our Team</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Mission / Values -->
    <section class="py-20 bg-light-bg">
      <div class="max-w-[1280px] mx-auto px-6 text-center flex flex-col gap-10">
        <h2 class="font-heading text-3xl font-bold text-primary uppercase tracking-wide">Our Core Values</h2>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
          <div v-for="val in values" :key="val.title" class="bg-white rounded-xl p-6 shadow-card flex flex-col items-center gap-3 text-center">
            <div class="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center text-primary">
              <svg v-if="val.icon === 'badge'" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75M21 12c0 1.268-.63 2.39-1.593 3.068a3.745 3.745 0 01-.497 3.323 3.745 3.745 0 01-3.323.497 3.745 3.745 0 01-3.068 1.593c-1.268 0-2.39-.63-3.068-1.593a3.745 3.745 0 01-3.323-.497 3.745 3.745 0 01-.497-3.323A3.745 3.745 0 013 12c0-1.268.63-2.39 1.593-3.068a3.745 3.745 0 01.497-3.323 3.745 3.745 0 013.323-.497A3.745 3.745 0 0112 3c1.268 0 2.39.63 3.068 1.593a3.745 3.745 0 013.323.497 3.745 3.745 0 01.497 3.323A3.745 3.745 0 0121 12z" />
              </svg>
              <svg v-else-if="val.icon === 'star'" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" d="M11.48 3.499a.562.562 0 011.04 0l2.125 5.111a.563.563 0 00.475.345l5.518.442c.499.04.701.663.321.988l-4.204 3.602a.563.563 0 00-.182.557l1.285 5.385a.562.562 0 01-.84.61l-4.725-2.885a.563.563 0 00-.586 0L6.982 20.54a.562.562 0 01-.84-.61l1.285-5.386a.562.562 0 00-.182-.557l-4.204-3.602a.562.562 0 01.321-.988l5.518-.442a.563.563 0 00.475-.345L11.48 3.5z" />
              </svg>
              <svg v-else-if="val.icon === 'heart'" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" d="M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12z" />
              </svg>
              <svg v-else class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" d="M12 21a9.004 9.004 0 008.716-6.747M12 21a9.004 9.004 0 01-8.716-6.747M12 21c2.485 0 4.5-4.03 4.5-9S14.485 3 12 3m0 18c-2.485 0-4.5-4.03-4.5-9S9.515 3 12 3m0 0a8.997 8.997 0 017.843 4.582M12 3a8.997 8.997 0 00-7.843 4.582m15.686 0A11.953 11.953 0 0112 10.5c-2.998 0-5.74-1.1-7.843-2.918m15.686 0A8.959 8.959 0 0121 12c0 .778-.099 1.533-.284 2.253M3 12c0 .778.099 1.533.284 2.253" />
              </svg>
            </div>
            <h3 class="font-heading font-bold text-base text-primary uppercase tracking-wide">{{ val.title }}</h3>
            <p class="text-gray-700 text-sm leading-relaxed">{{ val.desc }}</p>
          </div>
        </div>
      </div>
    </section>

    <CtaStrip />
  </main>
</template>

<script setup>
import { onMounted } from 'vue'
import PageHero from '@/components/ui/PageHero.vue'
import CtaStrip from '@/components/home/CtaStrip.vue'

onMounted(() => { document.title = 'About Us | ManAndTruck Movers' })

const stats = [
  { val: '15+',   label: 'Years in Business' },
  { val: '10K+',  label: 'Happy Customers' },
  { val: '20+',   label: 'Trucks in Fleet' },
  { val: '4.9★', label: 'Google Rating' },
]

const values = [
  { icon: 'badge', title: 'Integrity',       desc: 'Honest pricing, transparent communication — always.' },
  { icon: 'star',  title: 'Excellence',      desc: 'We set a high bar and clear it on every single move.' },
  { icon: 'heart', title: 'Empathy',         desc: 'Moving is personal. We treat every job with human care.' },
  { icon: 'globe', title: 'Responsibility',  desc: 'Committed to sustainable practices and our community.' },
]
</script>
