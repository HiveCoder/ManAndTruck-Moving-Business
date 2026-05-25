<template>
  <main>
    <LoadingSpinner v-if="loading" />

    <template v-else-if="service">
      <PageHero
        :title="service.name"
        :subtitle="service.short_description"
        :badge="service.badge || 'Our Services'"
        :breadcrumbs="[{to:'/',label:'Home'},{to:'/services',label:'Services'},{label:service.name}]"
      />

      <section class="py-20 bg-light-bg">
        <div class="max-w-[900px] mx-auto px-6">
          <div class="prose prose-primary max-w-none text-gray-600 leading-relaxed" v-html="service.description" />
        </div>
      </section>

      <!-- FAQ Accordion -->
      <section class="py-16 bg-white">
        <div class="max-w-[800px] mx-auto px-6">
          <h2 class="font-heading text-2xl font-bold text-primary uppercase tracking-wide text-center mb-10">Frequently Asked Questions</h2>
          <div class="flex flex-col gap-3">
            <div v-for="(faq, i) in faqs" :key="i" class="border border-border rounded-xl overflow-hidden">
              <button
                @click="openFaq = openFaq === i ? null : i"
                class="w-full flex justify-between items-center px-6 py-4 text-left font-heading font-semibold text-sm uppercase tracking-wide text-primary bg-white hover:bg-light-bg transition-colors"
                :aria-expanded="openFaq === i"
              >
                {{ faq.q }}
                <span class="text-xl leading-none shrink-0 ml-2 transition-transform duration-300" :class="openFaq === i ? 'rotate-45' : ''">+</span>
              </button>
              <div class="faq-answer" :class="{ open: openFaq === i }">
                <p class="px-6 py-4 text-gray-500 text-sm leading-relaxed">{{ faq.a }}</p>
              </div>
            </div>
          </div>
        </div>
      </section>

      <CtaStrip />
    </template>

    <template v-else>
      <div class="py-24 text-center">
        <p class="text-gray-400 text-lg">Service not found.</p>
        <RouterLink to="/services" class="mt-4 inline-block text-secondary underline">View all services</RouterLink>
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
import CtaStrip from '@/components/home/CtaStrip.vue'

const route   = useRoute()
const service = ref(null)
const loading = ref(true)
const openFaq = ref(null)

const faqs = [
  { q: 'How far in advance should I book?', a: 'We recommend booking 2–4 weeks ahead for local moves and 4–8 weeks for long-distance. We can sometimes accommodate shorter notice — call to check availability.' },
  { q: 'Do you provide packing materials?', a: 'Yes! We offer professional packing services with all materials included, or we can deliver boxes and supplies to your door ahead of moving day.' },
  { q: 'Are my belongings insured?', a: 'Every move includes basic valuation coverage. Full-value protection plans are available — ask your move coordinator for details.' },
  { q: 'Can I get a binding estimate?', a: 'Absolutely. After an in-home or virtual survey we can provide a binding estimate so there are no surprises on moving day.' },
]

async function fetchService(slug) {
  loading.value = true
  const { data } = await supabase.from('services').select('*').eq('slug', slug).single()
  service.value = data || null
  if (data) document.title = `${data.name} | ManAndTruck Movers`
  loading.value = false
}

onMounted(() => fetchService(route.params.slug))
watch(() => route.params.slug, slug => slug && fetchService(slug))
</script>
