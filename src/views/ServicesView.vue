<template>
  <main>
    <PageHero title="Our Moving Services" subtitle="From studio apartments to corporate offices — we move it all." badge="What We Offer"
      :breadcrumbs="[{to:'/',label:'Home'},{label:'Services'}]" />

    <section class="py-20 bg-light-bg">
      <div class="max-w-[1280px] mx-auto px-6">
        <LoadingSpinner v-if="loading" />
        <div v-else-if="services.length" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          <RouterLink
            v-for="s in services" :key="s.id"
            :to="`/services/${s.slug}`"
            class="bg-white rounded-xl shadow-card overflow-hidden group hover:shadow-card-lg hover:-translate-y-1 transition-all duration-300 flex flex-col"
          >
            <div class="h-44 overflow-hidden relative">
              <img :src="servicePhoto(s.icon_key)" :alt="s.name" class="w-full h-full object-cover" loading="lazy" />
              <span v-if="s.badge" class="absolute top-2 right-2 px-2 py-0.5 bg-cta text-white text-[0.67rem] font-heading font-bold uppercase tracking-wide rounded-full">{{ s.badge }}</span>
            </div>
            <div class="p-6 flex flex-col gap-3 flex-1">
              <h2 class="font-heading font-bold text-lg text-primary uppercase tracking-wide group-hover:text-secondary transition-colors">{{ s.name }}</h2>
              <p class="text-gray-700 text-sm leading-relaxed flex-1">{{ s.short_description }}</p>
              <span class="text-secondary font-semibold text-sm font-heading uppercase tracking-wide">Learn More →</span>
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

onMounted(async () => {
  const { data } = await supabase.from('services').select('*').order('display_order')
  services.value = data || []
  loading.value  = false
})
</script>
