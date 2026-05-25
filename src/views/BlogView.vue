<template>
  <main>
    <PageHero title="Moving Tips & Guides" subtitle="Expert advice to make your next move smooth and stress-free." badge="The Blog"
      :breadcrumbs="[{to:'/',label:'Home'},{label:'Blog'}]" />

    <section class="py-20 bg-light-bg">
      <div class="max-w-[1280px] mx-auto px-6">
        <LoadingSpinner v-if="loading" />
        <div v-else-if="posts.length" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          <RouterLink
            v-for="p in posts" :key="p.id"
            :to="`/blog/${p.slug}`"
            class="bg-white rounded-xl shadow-card overflow-hidden group hover:shadow-card-lg hover:-translate-y-1 transition-all duration-300 flex flex-col"
          >
            <div class="h-32 overflow-hidden">
              <img :src="categoryPhoto(p.category)" :alt="p.category" class="w-full h-full object-cover" loading="lazy" />
            </div>
            <div class="p-6 flex flex-col gap-3 flex-1">
              <span class="text-[0.7rem] uppercase tracking-widest font-heading font-semibold text-secondary">{{ p.category }}</span>
              <h2 class="font-heading font-bold text-lg text-primary leading-snug group-hover:text-secondary transition-colors">{{ p.title }}</h2>
              <p class="text-gray-700 text-sm leading-relaxed line-clamp-3 flex-1">{{ p.excerpt }}</p>
              <p v-if="p.published_at" class="text-xs text-gray-600">{{ formatDate(p.published_at) }}</p>
              <span class="text-secondary font-semibold text-sm font-heading uppercase tracking-wide">Read More →</span>
            </div>
          </RouterLink>
        </div>
        <p v-else class="text-center text-gray-600">No articles published yet. Check back soon!</p>
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

onMounted(() => { document.title = 'Blog | ManAndTruck Movers' })

const posts   = ref([])
const loading = ref(true)

function categoryPhoto(category) {
  const map = {
    'Planning': 'https://images.unsplash.com/photo-1673064497720-5bfe5024df01?w=600&h=240&fit=crop&q=80',
    'Tips':     'https://images.unsplash.com/photo-1600725935160-f67ee4f6084a?w=600&h=240&fit=crop&q=80',
    'Costs':    'https://images.unsplash.com/photo-1473445730015-841f29a9490b?w=600&h=240&fit=crop&q=80',
    'Family':   'https://images.unsplash.com/photo-1694715669993-ea0022b470f7?w=600&h=240&fit=crop&q=80',
  }
  return map[category] || 'https://images.unsplash.com/photo-1698917414969-feade59e3343?w=600&h=240&fit=crop&q=80'
}

function formatDate(dateStr) {
  return new Date(dateStr).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })
}

onMounted(async () => {
  const { data } = await supabase.from('blog_posts').select('id,title,slug,excerpt,category,published_at').eq('published', true).order('published_at', { ascending: false })
  posts.value   = data || []
  loading.value = false
})
</script>
