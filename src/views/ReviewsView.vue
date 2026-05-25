<template>
  <main>
    <PageHero title="Customer Reviews" subtitle="Don't take our word for it — hear from real customers." badge="What People Say"
      :breadcrumbs="[{to:'/',label:'Home'},{label:'Reviews'}]" />

    <section class="py-20 bg-light-bg">
      <div class="max-w-[1280px] mx-auto px-6">

        <!-- Summary bar -->
        <div class="bg-white rounded-xl shadow-card p-6 flex flex-wrap items-center gap-6 mb-10">
          <div class="text-center">
            <p class="font-heading font-bold text-5xl text-primary">4.9</p>
            <p class="text-yellow-400 text-xl leading-none mt-1">★★★★★</p>
            <p class="text-xs text-gray-600 uppercase tracking-wide font-heading font-semibold mt-1">Overall Rating</p>
          </div>
          <div class="h-16 w-px bg-border hidden sm:block"></div>
          <div class="flex flex-col gap-1">
            <p class="font-heading font-bold text-xl text-primary">10,000+ Happy Customers</p>
            <p class="text-gray-700 text-sm">Verified reviews from Google, Yelp, and Facebook</p>
          </div>
          <a href="https://g.page/r/review" rel="noopener noreferrer"
            class="ml-auto px-5 py-2.5 bg-primary text-white font-heading font-bold text-xs uppercase tracking-widest rounded-lg hover:bg-primary-dark transition-colors">
            Leave a Review
          </a>
        </div>

        <LoadingSpinner v-if="loading" />
        <div v-else-if="reviews.length" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          <div
            v-for="r in reviews" :key="r.id"
            class="bg-white rounded-xl shadow-card p-6 flex flex-col gap-3 hover:shadow-card-lg transition-shadow duration-300"
          >
            <div class="flex items-center justify-between">
              <span class="text-yellow-400 text-base tracking-tight">{{ '★'.repeat(r.rating) }}</span>
              <span class="text-xs text-gray-600 uppercase tracking-wide font-heading font-semibold">{{ r.source }}</span>
            </div>
            <p class="text-gray-600 text-sm leading-relaxed italic flex-1">"{{ r.review_text }}"</p>
            <div>
              <p class="font-heading font-bold text-sm text-primary">{{ r.author_name }}</p>
              <p v-if="r.location" class="text-xs text-gray-600">{{ r.location }}</p>
            </div>
          </div>
        </div>
        <p v-else class="text-center text-gray-600">No reviews yet.</p>
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

onMounted(() => { document.title = 'Reviews | ManAndTruck Movers' })

const reviews = ref([])
const loading = ref(true)

onMounted(async () => {
  const { data } = await supabase.from('reviews').select('*').eq('approved', true).order('id', { ascending: false })
  reviews.value = data || []
  loading.value = false
})
</script>
