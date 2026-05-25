<template>
  <main>
    <LoadingSpinner v-if="loading" />

    <template v-else-if="post">
      <PageHero
        :title="post.title"
        :subtitle="post.category"
        badge="Blog"
        :breadcrumbs="[{to:'/',label:'Home'},{to:'/blog',label:'Blog'},{label:post.title}]"
      />

      <article class="py-20 bg-white">
        <div class="max-w-[800px] mx-auto px-6">
          <div class="rounded-2xl overflow-hidden border border-border shadow-card mb-8">
            <img :src="categoryPhoto(post.category)" :alt="post.category" class="w-full h-[320px] object-cover" loading="lazy" />
          </div>
          <div class="flex flex-wrap items-center gap-3 mb-8 text-xs">
            <span class="px-3 py-1 rounded-full bg-primary/10 text-primary font-heading font-semibold uppercase tracking-[0.14em]">{{ post.category }}</span>
            <span v-if="post.published_at" class="text-gray-600">Published {{ formatDate(post.published_at) }}</span>
            <span class="text-gray-600">{{ readTime(post.content) }} min read</span>
          </div>
          <div class="text-gray-700 leading-relaxed text-base [&>h2]:font-heading [&>h2]:text-2xl [&>h2]:font-bold [&>h2]:text-primary [&>h2]:uppercase [&>h2]:tracking-wide [&>h2]:mt-8 [&>h2]:mb-3 [&>p]:mb-5 [&>ul]:list-disc [&>ul]:pl-6 [&>ul]:mb-5 [&>li]:mb-2" v-html="sanitize(post.content)" />
          <div class="mt-12 pt-8 border-t border-border">
            <RouterLink to="/blog" class="text-secondary font-semibold font-heading text-sm uppercase tracking-wide hover:text-primary transition-colors">
              ← Back to Blog
            </RouterLink>
          </div>
        </div>
      </article>
    </template>

    <template v-else>
      <div class="py-24 text-center">
        <p class="text-gray-600 text-lg">Article not found.</p>
        <RouterLink to="/blog" class="mt-4 inline-block text-secondary underline">Back to Blog</RouterLink>
      </div>
    </template>
  </main>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { supabase } from '@/lib/supabase.js'
import { getFallbackBlogPostBySlug } from '@/lib/contentFallbacks.js'
import PageHero from '@/components/ui/PageHero.vue'
import LoadingSpinner from '@/components/ui/LoadingSpinner.vue'

const route   = useRoute()
const post    = ref(null)
const loading = ref(true)

function formatDate(dateStr) {
  return new Date(dateStr).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })
}

function categoryPhoto(category) {
  const map = {
    'Planning': 'https://images.unsplash.com/photo-1673064497720-5bfe5024df01?w=1200&h=650&fit=crop&q=80',
    'Tips':     'https://images.unsplash.com/photo-1600725935160-f67ee4f6084a?w=1200&h=650&fit=crop&q=80',
    'Costs':    'https://images.unsplash.com/photo-1473445730015-841f29a9490b?w=1200&h=650&fit=crop&q=80',
    'Family':   'https://images.unsplash.com/photo-1694715669993-ea0022b470f7?w=1200&h=650&fit=crop&q=80',
  }
  return map[category] || 'https://images.unsplash.com/photo-1698917414969-feade59e3343?w=1200&h=650&fit=crop&q=80'
}

function readTime(content) {
  const plainText = sanitize(content).replace(/<[^>]+>/g, ' ')
  const words = plainText.trim().split(/\s+/).filter(Boolean).length
  return Math.max(2, Math.ceil(words / 220))
}

// Basic HTML sanitization — strip script/iframe tags from DB content
function sanitize(html) {
  if (!html) return ''
  return html.replace(/<script[\s\S]*?<\/script>/gi, '').replace(/<iframe[\s\S]*?<\/iframe>/gi, '')
}

async function fetchPost(slug) {
  loading.value = true
  const { data } = await supabase.from('blog_posts').select('*').eq('slug', slug).eq('published', true).single()
  const resolvedPost = data || getFallbackBlogPostBySlug(slug)
  post.value = resolvedPost
  if (resolvedPost) document.title = `${resolvedPost.title} | ManAndTruck Movers`
  else document.title = 'Article Not Found | ManAndTruck Movers'
  loading.value = false
}

onMounted(() => fetchPost(route.params.slug))
watch(() => route.params.slug, slug => slug && fetchPost(slug))
</script>
