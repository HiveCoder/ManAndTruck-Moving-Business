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
          <div v-if="post.published_at" class="text-gray-600 text-sm mb-8">
            Published {{ formatDate(post.published_at) }}
          </div>
          <!-- prose-like styling via Tailwind Typography; fallback via inline styles -->
          <div class="text-gray-600 leading-relaxed text-base [&>h2]:font-heading [&>h2]:text-2xl [&>h2]:font-bold [&>h2]:text-primary [&>h2]:uppercase [&>h2]:tracking-wide [&>h2]:mt-8 [&>h2]:mb-3 [&>p]:mb-5 [&>ul]:list-disc [&>ul]:pl-6 [&>ul]:mb-5 [&>li]:mb-2" v-html="sanitize(post.content)" />
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
import PageHero from '@/components/ui/PageHero.vue'
import LoadingSpinner from '@/components/ui/LoadingSpinner.vue'

const route   = useRoute()
const post    = ref(null)
const loading = ref(true)

function formatDate(dateStr) {
  return new Date(dateStr).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' })
}

// Basic HTML sanitization — strip script/iframe tags from DB content
function sanitize(html) {
  if (!html) return ''
  return html.replace(/<script[\s\S]*?<\/script>/gi, '').replace(/<iframe[\s\S]*?<\/iframe>/gi, '')
}

async function fetchPost(slug) {
  loading.value = true
  const { data } = await supabase.from('blog_posts').select('*').eq('slug', slug).eq('published', true).single()
  post.value = data || null
  if (data) document.title = `${data.title} | ManAndTruck Movers`
  else document.title = 'Article Not Found | ManAndTruck Movers'
  loading.value = false
}

onMounted(() => fetchPost(route.params.slug))
watch(() => route.params.slug, slug => slug && fetchPost(slug))
</script>
