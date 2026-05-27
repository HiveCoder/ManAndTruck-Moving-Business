<template>
  <section class="py-20 bg-light-bg">
    <div class="max-w-[1280px] mx-auto px-6">
      <div class="text-center mb-12">
        <p class="text-sm uppercase tracking-[0.2em] font-heading font-semibold text-secondary mb-2">The ManAndTruck Difference</p>
        <h2 class="font-heading text-3xl md:text-4xl font-bold text-primary uppercase tracking-wide">Why Thousands Choose Us for Moving &amp; Cleaning</h2>
      </div>

      <AppSlider
        :items="cards"
        :visible-fn="visibleFn"
        :autoplay-interval="5000"
      >
        <template #item="{ item }">
          <div class="px-3 py-2 h-full">
            <div class="bg-white rounded-xl p-6 shadow-card flex flex-col gap-4 h-full hover:shadow-card-lg hover:-translate-y-1 transition-all duration-300">
              <div class="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center text-primary shrink-0">
                <svg v-if="item.icon === 'trophy'" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M16.5 18.75h-9m9 0a3 3 0 013 3h-15a3 3 0 013-3m9 0v-3.375c0-.621-.503-1.125-1.125-1.125h-.871M7.5 18.75v-3.375c0-.621.504-1.125 1.125-1.125h.872m5.007 0H9.497m5.007 0a7.454 7.454 0 01-.982-3.172M9.497 14.25a7.454 7.454 0 00.981-3.172M5.25 4.236c-.982.143-1.954.317-2.916.52A6.003 6.003 0 007.73 9.728M5.25 4.236V4.5c0 2.108.966 3.99 2.48 5.228M5.25 4.236V2.721C7.456 2.41 9.71 2.25 12 2.25c2.291 0 4.545.16 6.75.47v1.516M7.73 9.728a6.726 6.726 0 002.748 1.35m8.272-6.842V4.5c0 2.108-.966 3.99-2.48 5.228m2.48-5.492a46.32 46.32 0 012.916.52 6.003 6.003 0 01-5.395 4.972m0 0a6.726 6.726 0 01-2.749 1.35m0 0a6.772 6.772 0 01-3.044 0" />
                </svg>
                <svg v-else-if="item.icon === 'shield'" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75m-3-7.036A11.959 11.959 0 013.598 6 11.99 11.99 0 003 9.749c0 5.592 3.824 10.29 9 11.623 5.176-1.332 9-6.03 9-11.622 0-1.31-.21-2.571-.598-3.751h-.152c-3.196 0-6.1-1.248-8.25-3.285z" />
                </svg>
                <svg v-else-if="item.icon === 'clock'" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 6v6h4.5m4.5 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <svg v-else-if="item.icon === 'chat'" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M7.5 8.25h9m-9 3H12m-9.75 1.51c0 1.6 1.123 2.994 2.707 3.227 1.129.166 2.27.293 3.423.379.35.026.67.21.865.501L12 21l2.755-4.133a1.14 1.14 0 01.865-.501 48.172 48.172 0 003.423-.379c1.584-.233 2.707-1.626 2.707-3.228V6.741c0-1.602-1.123-2.995-2.707-3.228A48.394 48.394 0 0012 3c-2.392 0-4.744.175-7.043.513C3.373 3.746 2.25 5.14 2.25 6.741v6.018z" />
                </svg>
                <svg v-else-if="item.icon === 'users'" class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M15 19.128a9.38 9.38 0 002.625.372 9.337 9.337 0 004.121-.952 4.125 4.125 0 00-7.533-2.493M15 19.128v-.003c0-1.113-.285-2.16-.786-3.07M15 19.128v.106A12.318 12.318 0 018.624 21c-2.331 0-4.512-.645-6.374-1.766l-.001-.109a6.375 6.375 0 0111.964-3.07M12 6.375a3.375 3.375 0 11-6.75 0 3.375 3.375 0 016.75 0zm8.25 2.25a2.625 2.625 0 11-5.25 0 2.625 2.625 0 015.25 0z" />
                </svg>
                <svg v-else class="w-6 h-6" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 21a9.004 9.004 0 008.716-6.747M12 21a9.004 9.004 0 01-8.716-6.747M12 21c2.485 0 4.5-4.03 4.5-9S14.485 3 12 3m0 18c-2.485 0-4.5-4.03-4.5-9S9.515 3 12 3m0 0a8.997 8.997 0 017.843 4.582M12 3a8.997 8.997 0 00-7.843 4.582m15.686 0A11.953 11.953 0 0112 10.5c-2.998 0-5.74-1.1-7.843-2.918m15.686 0A8.959 8.959 0 0121 12c0 .778-.099 1.533-.284 2.253M3 12c0 .778.099 1.533.284 2.253" />
                </svg>
              </div>
              <h3 class="font-heading font-bold text-lg text-primary uppercase tracking-wide">{{ item.title }}</h3>
              <p class="text-gray-700 text-sm leading-relaxed flex-1">{{ item.body }}</p>
            </div>
          </div>
        </template>
      </AppSlider>
    </div>
  </section>
</template>

<script setup>
import AppSlider from '@/components/ui/AppSlider.vue'

const cards = [
  { icon: 'trophy', title: 'Award-Winning Service', body: 'Recognized as one of Ontario\'s top moving teams for consistent service quality and professionalism.' },
  { icon: 'clock', title: 'On-Time, Every Time', body: 'We respect your schedule. Our teams arrive on time, work efficiently, and finish when promised.' },
  { icon: 'chat', title: 'Transparent Pricing', body: 'No hidden fees, no surprises. Get an honest quote upfront and pay exactly what you\'re told.' },
  { icon: 'users', title: 'Dedicated Move Coordinator', body: 'Every customer gets a personal coordinator to handle the details and answer questions from start to finish.' },
  { icon: 'globe', title: 'Eco-Friendly Practices', body: 'Reusable packing materials, fuel-efficient routing, and waste-reducing practices to protect the planet.' },
  { icon: 'shield', title: 'Spotless Move-In/Out Cleans', body: 'Our certified cleaning crews deep-clean kitchens, bathrooms, and every corner so your property is ready for handover or move-in.' },
]

function visibleFn() {
  const w = window.innerWidth
  if (w >= 900) return 3
  if (w >= 600) return 2
  return 1
}
</script>
