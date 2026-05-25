<template>
  <main>
    <PageHero title="Our Moving Services" subtitle="From studio apartments to corporate offices — we move it all." badge="What We Offer"
      :breadcrumbs="[{to:'/',label:'Home'},{label:'Services'}]" />

    <section class="py-20 bg-light-bg">
      <div class="max-w-[1280px] mx-auto px-6">
        <div class="mb-10 flex flex-col gap-4 md:flex-row md:items-end md:justify-between">
          <div>
            <p class="text-xs uppercase tracking-[0.2em] font-heading font-semibold text-secondary">Professional Move Solutions</p>
            <h2 class="mt-2 font-heading text-2xl md:text-3xl font-bold text-primary uppercase tracking-wide">Built For Homes, Offices, And Specialty Moves</h2>
          </div>
          <div class="flex flex-wrap gap-2 text-[0.68rem]">
            <span class="px-3 py-1 rounded-full bg-white border border-border text-primary uppercase tracking-[0.14em] font-heading font-semibold">Licensed & Insured</span>
            <span class="px-3 py-1 rounded-full bg-white border border-border text-primary uppercase tracking-[0.14em] font-heading font-semibold">Weekend Availability</span>
            <span class="px-3 py-1 rounded-full bg-white border border-border text-primary uppercase tracking-[0.14em] font-heading font-semibold">Ontario Service Area</span>
          </div>
        </div>

        <LoadingSpinner v-if="loading" />
        <div v-else-if="services.length" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          <RouterLink
            v-for="s in services" :key="s.id"
            :to="`/services/${s.slug}`"
            class="bg-white rounded-2xl border border-border shadow-card overflow-hidden group hover:shadow-card-lg hover:-translate-y-1 transition-all duration-300 flex flex-col"
          >
            <div class="h-44 overflow-hidden relative">
              <img :src="servicePhoto(s.icon_key)" :alt="s.name" class="w-full h-full object-cover" loading="lazy" />
              <div class="absolute inset-0 bg-gradient-to-t from-primary/45 to-transparent"></div>
              <span v-if="s.badge" class="absolute top-3 right-3 px-2.5 py-1 bg-cta text-white text-[0.65rem] font-heading font-bold uppercase tracking-[0.14em] rounded-full">{{ s.badge }}</span>
              <span v-if="s.featured" class="absolute top-3 left-3 px-2.5 py-1 bg-primary/90 text-white text-[0.65rem] font-heading font-bold uppercase tracking-[0.14em] rounded-full">Featured</span>
              <p class="absolute bottom-3 left-3 text-white font-heading font-semibold text-xs uppercase tracking-[0.15em]">{{ serviceMeta(s.slug).coverage }}</p>
            </div>
            <div class="p-6 flex flex-col gap-3 flex-1">
              <h2 class="font-heading font-bold text-lg text-primary uppercase tracking-wide group-hover:text-secondary transition-colors">{{ s.name }}</h2>
              <p class="text-gray-700 text-sm leading-relaxed flex-1">{{ s.short_description }}</p>
              <div class="flex flex-wrap gap-2">
                <span class="px-2.5 py-1 rounded-full bg-light-bg text-[0.65rem] font-heading font-semibold uppercase tracking-[0.14em] text-primary">{{ serviceMeta(s.slug).crew }}</span>
                <span class="px-2.5 py-1 rounded-full bg-light-bg text-[0.65rem] font-heading font-semibold uppercase tracking-[0.14em] text-primary">{{ serviceMeta(s.slug).timing }}</span>
              </div>
              <div class="mt-1 pt-3 border-t border-border flex items-center justify-between">
                <span class="text-xs text-gray-600">Custom quote available</span>
                <span class="text-secondary font-semibold text-xs font-heading uppercase tracking-[0.14em]">Learn More</span>
              </div>
            </div>
          </RouterLink>
        </div>
        <p v-else class="text-center text-gray-600">No services found.</p>
      </div>
    </section>

    <CtaStrip />
  </main>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { supabase } from '@/lib/supabase.js'
import { fallbackServices } from '@/lib/contentFallbacks.js'
import PageHero from '@/components/ui/PageHero.vue'
import LoadingSpinner from '@/components/ui/LoadingSpinner.vue'
import CtaStrip from '@/components/home/CtaStrip.vue'

onMounted(() => { document.title = 'Services | ManAndTruck Movers' })

const services = ref([])
const loading  = ref(true)

function servicePhoto(iconKey) {
  const map = {
    'truck':       'https://images.unsplash.com/photo-1698917414969-feade59e3343?w=600&h=300&fit=crop&q=80',
    'truck-local': 'https://images.unsplash.com/photo-1698917414969-feade59e3343?w=600&h=300&fit=crop&q=80',
    'truck-long':  'https://images.unsplash.com/photo-1473445730015-841f29a9490b?w=600&h=300&fit=crop&q=80',
    'boxes':       'https://images.unsplash.com/photo-1600725935160-f67ee4f6084a?w=600&h=300&fit=crop&q=80',
    'building':    'https://images.unsplash.com/photo-1551471698-c7787ff6b7ca?w=600&h=300&fit=crop&q=80',
    'hands':       'https://images.unsplash.com/photo-1694715669993-ea0022b470f7?w=600&h=300&fit=crop&q=80',
    'piano':       'https://images.unsplash.com/photo-1600518464441-9154a4dea21b?w=600&h=300&fit=crop&q=80',
    'warehouse':   'https://images.unsplash.com/photo-1600725935160-f67ee4f6084a?w=600&h=300&fit=crop&q=80',
    'star':        'https://images.unsplash.com/photo-1600518464441-9154a4dea21b?w=600&h=300&fit=crop&q=80',
  }
  return map[iconKey] || 'https://images.unsplash.com/photo-1698917414969-feade59e3343?w=600&h=300&fit=crop&q=80'
}

function serviceMeta(slug) {
  const map = {
    'local-moving': {
      coverage: 'Guelph & Nearby Cities',
      crew: '2-4 Person Crew',
      timing: 'Weekend Options',
    },
    'long-distance-moving': {
      coverage: 'Ontario & Interprovincial',
      crew: 'Dedicated Crew',
      timing: 'Planned Timeline',
    },
    'commercial-moving': {
      coverage: 'Offices & Retail',
      crew: 'Project Team',
      timing: 'After-Hours Available',
    },
    'packing-services': {
      coverage: 'Full Or Partial Packing',
      crew: 'Packing Specialists',
      timing: 'Pre-Move Scheduling',
    },
    'specialty-items': {
      coverage: 'Pianos, Antiques, Safes',
      crew: 'Specialty Handlers',
      timing: 'Equipment Ready',
    },
    'storage': {
      coverage: 'Short & Long-Term',
      crew: 'Storage Coordination',
      timing: 'Flexible Redelivery',
    },
  }

  return map[slug] || {
    coverage: 'Ontario Service Area',
    crew: 'Professional Crew',
    timing: 'Flexible Scheduling',
  }
}

onMounted(async () => {
  try {
    const { data } = await supabase.from('services').select('*').order('display_order')
    services.value = (data && data.length) ? data : fallbackServices
  } finally {
    loading.value = false
  }
})
</script>
