<template>
  <section class="py-20 bg-mid-bg">
    <div class="max-w-[1280px] mx-auto px-6">
      <div class="text-center mb-12">
        <p class="text-sm uppercase tracking-[0.2em] font-heading font-semibold text-secondary mb-2">What We Do</p>
        <h2 class="font-heading text-3xl md:text-4xl font-bold text-primary uppercase tracking-wide">Our Moving Services</h2>
      </div>

      <LoadingSpinner v-if="loading" />

      <template v-else-if="services.length">
        <AppSlider :items="services" :visible-fn="visibleFn" :autoplay-interval="5500">
          <template #item="{ item }">
            <div class="px-3 py-2">
              <div class="bg-white rounded-xl shadow-card overflow-hidden hover:shadow-card-lg hover:-translate-y-1 transition-all duration-300 flex flex-col h-full">
                <div class="h-40 overflow-hidden relative">
                  <img :src="servicePhoto(item.icon_key)" :alt="item.name" class="w-full h-full object-cover" loading="lazy" />
                  <span v-if="item.badge" class="absolute top-2 right-2 px-2 py-0.5 bg-cta text-white text-[0.67rem] font-heading font-bold uppercase tracking-wide rounded-full">{{ item.badge }}</span>
                </div>
                <div class="p-5 flex flex-col gap-3 flex-1">
                  <h3 class="font-heading font-bold text-base text-primary uppercase tracking-wide">{{ item.name }}</h3>
                  <p class="text-gray-700 text-sm leading-relaxed flex-1">{{ item.short_description }}</p>
                  <RouterLink :to="`/services/${item.slug}`" class="mt-2 text-secondary font-semibold text-sm font-heading uppercase tracking-wide hover:text-primary transition-colors">
                    Learn More →
                  </RouterLink>
                </div>
              </div>
            </div>
          </template>
        </AppSlider>
      </template>

      <p v-else-if="error" class="text-center text-red-500 text-sm">Failed to load services.</p>

      <div class="text-center mt-10">
        <RouterLink to="/services" class="inline-block px-8 py-3 bg-primary text-white font-heading font-bold text-sm uppercase tracking-widest rounded-lg hover:bg-primary-dark transition-colors duration-200">
          View All Services
        </RouterLink>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { supabase } from '@/lib/supabase.js'
import { fallbackServices } from '@/lib/contentFallbacks.js'
import AppSlider from '@/components/ui/AppSlider.vue'
import LoadingSpinner from '@/components/ui/LoadingSpinner.vue'

const services = ref([])
const loading  = ref(true)
const error    = ref(false)

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

function visibleFn() {
  const w = window.innerWidth
  if (w >= 1200) return 4
  if (w >= 900)  return 3
  if (w >= 600)  return 2
  return 1
}

onMounted(async () => {
  try {
    const { data, error: err } = await supabase
      .from('services')
      .select('id, name, slug, short_description, icon_key, badge, featured')
      .order('display_order')
    if (err) throw err
    services.value = (data && data.length) ? data : fallbackServices
  } catch {
    services.value = fallbackServices
    error.value = false
  } finally {
    loading.value = false
  }
})
</script>
