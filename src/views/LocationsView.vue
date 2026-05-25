<template>
  <main>
    <PageHero title="Our Locations" subtitle="Local movers wherever you are. Serving your community with care." badge="Service Areas"
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

onMounted(() => { document.title = 'Locations | ManAndTruck Movers' })

const locations = ref([])
const loading   = ref(true)

onMounted(async () => {
  const { data } = await supabase.from('locations').select('*').eq('active', true).order('display_order')
  locations.value = data || []
  loading.value = false
})
</script>
