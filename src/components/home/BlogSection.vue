<template>
  <section class="py-20 bg-light-bg">
    <div class="max-w-[1280px] mx-auto px-6">
      <div class="text-center mb-12">
        <p class="text-sm uppercase tracking-[0.2em] font-heading font-semibold text-secondary mb-2">Moving Tips & Guides</p>
        <h2 class="font-heading text-3xl md:text-4xl font-bold text-primary uppercase tracking-wide">From the Blog</h2>
      </div>

      <LoadingSpinner v-if="loading" />

      <template v-else-if="posts.length">
        <AppSlider :items="posts" :visible-fn="visibleFn" :autoplay-interval="6000">
          <template #item="{ item }">
            <div class="px-3 py-2">
              <div class="bg-white rounded-xl shadow-card overflow-hidden hover:shadow-card-lg hover:-translate-y-1 transition-all duration-300 flex flex-col h-full">
                <div class="h-36 overflow-hidden">
                  <img :src="categoryPhoto(item.category)" :alt="item.category" class="w-full h-full object-cover" loading="lazy" />
                </div>
                <div class="p-5 flex flex-col gap-3 flex-1">
                  <span class="text-[0.7rem] uppercase tracking-widest font-heading font-semibold text-secondary">{{ item.category }}</span>
                  <h3 class="font-heading font-bold text-base text-primary leading-snug">{{ item.title }}</h3>
                  <p class="text-gray-500 text-sm leading-relaxed line-clamp-3 flex-1">{{ item.excerpt }}</p>
                  <RouterLink :to="`/blog/${item.slug}`" class="mt-2 text-secondary font-semibold text-sm font-heading uppercase tracking-wide hover:text-primary transition-colors">
                    Read More →
                  </RouterLink>
                </div>
              </div>
            </div>
          </template>
        </AppSlider>
      </template>

      <div class="text-center mt-10">
        <RouterLink to="/blog" class="inline-block px-8 py-3 border-2 border-primary text-primary font-heading font-bold text-sm uppercase tracking-widest rounded-lg hover:bg-primary hover:text-white transition-all duration-200">
          View All Articles
        </RouterLink>
      </div>
    </div>
  </section>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { supabase } from '@/lib/supabase.js'
import AppSlider from '@/components/ui/AppSlider.vue'
import LoadingSpinner from '@/components/ui/LoadingSpinner.vue'

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

function visibleFn() {
  const w = window.innerWidth
  if (w >= 900) return 3
  if (w >= 600) return 2
  return 1
}

onMounted(async () => {
  try {
    const { data } = await supabase
      .from('blog_posts')
      .select('id, title, slug, excerpt, category, published_at')
      .eq('published', true)
      .order('published_at', { ascending: false })
      .limit(4)
    posts.value = data || []
  } finally {
    loading.value = false
  }
})
</script>
