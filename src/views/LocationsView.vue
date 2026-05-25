<template>
  <main>
    <PageHero title="Ontario Service Areas" subtitle="Guelph-based movers serving cities across Ontario, with strongest local coverage around Guelph and Waterloo Region." badge="Service Areas"
      :breadcrumbs="[{to:'/',label:'Home'},{label:'Locations'}]" />

    <section class="py-20 bg-light-bg">
      <div class="max-w-[1280px] mx-auto px-6">
        <LoadingSpinner v-if="loading" />
        <div v-else-if="locations.length" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
          <div
            v-for="loc in locations" :key="loc.id"
            class="bg-white rounded-xl shadow-card p-6 flex flex-col gap-3 hover:shadow-card-lg hover:-translate-y-1 transition-all duration-300"
          >
            <div class="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center text-primary">
              <svg class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1115 0z" />
              </svg>
            </div>
            <h2 class="font-heading font-bold text-lg text-primary uppercase tracking-wide">{{ loc.name }}</h2>
            <p class="text-gray-700 text-sm leading-relaxed flex-1">{{ loc.description }}</p>
            <div class="flex flex-col gap-1 text-sm text-gray-600">
              <p v-if="loc.address">{{ loc.address }}</p>
              <a v-if="loc.phone" :href="`tel:${loc.phone.replace(/\D/g,'')}`" class="text-secondary hover:text-primary transition-colors font-semibold">{{ loc.phone }}</a>
            </div>
          </div>
        </div>
        <p v-else class="text-center text-gray-600">No locations found.</p>
      </div>
    </section>

    <CtaStrip />
  </main>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { supabase } from '@/lib/supabase.js'
import PageHero from '@/components/ui/PageHero.vue'
import LoadingSpinner from '@/components/ui/LoadingSpinner.vue'
import CtaStrip from '@/components/home/CtaStrip.vue'

onMounted(() => { document.title = 'Locations | ManAndTruck Movers Ontario' })

const locations = ref([])
const loading   = ref(true)

const ontarioCities = [
  'Guelph',
  'Barrie', 'Belleville', 'Brampton', 'Brantford', 'Brockville', 'Burlington',
  'Cambridge', 'Clarence-Rockland', 'Cornwall',
  'Dryden',
  'Elliot Lake',
  'Greater Sudbury',
  'Hamilton',
  'Kawartha Lakes', 'Kenora', 'Kingston', 'Kitchener',
  'London',
  'Markham', 'Mississauga',
  'Niagara Falls', 'North Bay',
  'Orillia', 'Oshawa', 'Ottawa', 'Owen Sound',
  'Pembroke', 'Peterborough', 'Pickering', 'Port Colborne',
  'Quinte West',
  'Sarnia', 'Sault Ste. Marie', 'St. Catharines', 'St. Thomas', 'Stratford',
  'Temiskaming Shores', 'Thorold', 'Thunder Bay', 'Timmins', 'Toronto',
  'Vaughan',
  'Waterloo', 'Welland', 'Windsor', 'Woodstock'
]

function slugify(value) {
  return value
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/(^-|-$)/g, '')
}

function fallbackLocations() {
  return ontarioCities.map((name, idx) => ({
    id: `fallback-${slugify(name)}`,
    name,
    slug: slugify(name),
    description: name === 'Guelph'
      ? 'Head office and primary dispatch hub for Ontario moves.'
      : `Serving ${name} and surrounding Ontario communities with residential and commercial moving services.`,
    address: '',
    phone: '(416) 555-0136',
    active: true,
    display_order: idx + 1,
  }))
}

function mergeLocations(primary, fallback) {
  const bySlug = new Map()
  fallback.forEach((loc) => bySlug.set(loc.slug, loc))
  primary.forEach((loc) => {
    const slug = loc.slug || slugify(loc.name || '')
    if (!slug || !bySlug.has(slug)) return
    bySlug.set(slug, {
      ...bySlug.get(slug),
      ...loc,
      slug,
    })
  })

  return Array.from(bySlug.values()).sort((a, b) => {
    const ao = Number.isFinite(a.display_order) ? a.display_order : 9999
    const bo = Number.isFinite(b.display_order) ? b.display_order : 9999
    if (ao !== bo) return ao - bo
    return (a.name || '').localeCompare(b.name || '')
  })
}

onMounted(async () => {
  try {
    const { data } = await supabase.from('locations').select('*').eq('active', true).order('display_order')
    locations.value = mergeLocations(data || [], fallbackLocations())
  } catch (_err) {
    locations.value = fallbackLocations()
  }
  loading.value = false
})
</script>
