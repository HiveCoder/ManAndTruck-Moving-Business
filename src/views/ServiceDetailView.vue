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

      <section class="py-16 bg-white">
        <div class="max-w-[1200px] mx-auto px-6 grid grid-cols-1 lg:grid-cols-5 gap-6 items-stretch">
          <div class="lg:col-span-3 rounded-2xl overflow-hidden shadow-card">
            <img :src="servicePhoto(service.icon_key)" :alt="service.name" class="w-full h-[420px] object-cover" loading="lazy" />
          </div>
          <div class="lg:col-span-2 grid grid-cols-2 gap-4">
            <div class="col-span-2 bg-light-bg rounded-xl p-5 border border-border">
              <p class="text-xs uppercase tracking-[0.18em] font-heading font-semibold text-secondary">Service Highlights</p>
              <h3 class="mt-2 font-heading text-xl font-bold text-primary uppercase tracking-wide">Why Clients Choose This Service</h3>
            </div>
            <div v-for="point in serviceHighlights(service.slug)" :key="point" class="bg-white rounded-xl p-4 border border-border text-sm text-gray-700 leading-relaxed">
              {{ point }}
            </div>
          </div>
        </div>
      </section>

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
            <div
              v-for="(faq, i) in faqs"
              :key="i"
              class="faq-item border border-border rounded-xl overflow-hidden"
              :class="{ open: openFaq === i }"
            >
              <button
                @click="openFaq = openFaq === i ? null : i"
                class="w-full flex justify-between items-center px-6 py-4 text-left font-heading font-semibold text-sm uppercase tracking-wide text-primary bg-white hover:bg-light-bg transition-colors"
                :aria-expanded="openFaq === i"
              >
                {{ faq.q }}
                <span class="faq-icon text-xl leading-none shrink-0 ml-2 transition-transform duration-300" :class="openFaq === i ? 'rotate-45' : ''">+</span>
              </button>
              <div class="faq-answer">
                <p class="px-6 py-4 text-gray-700 text-sm leading-relaxed">{{ faq.a }}</p>
              </div>
            </div>
          </div>
        </div>
      </section>

      <CtaStrip />
    </template>

    <template v-else>
      <div class="py-24 text-center">
        <p class="text-gray-600 text-lg">Service not found.</p>
        <RouterLink to="/services" class="mt-4 inline-block text-secondary underline">View all services</RouterLink>
      </div>
    </template>
  </main>
</template>

<script setup>
import { ref, watch, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { supabase } from '@/lib/supabase.js'
import { getFallbackServiceBySlug } from '@/lib/contentFallbacks.js'
import PageHero from '@/components/ui/PageHero.vue'
import LoadingSpinner from '@/components/ui/LoadingSpinner.vue'
import CtaStrip from '@/components/home/CtaStrip.vue'

const route   = useRoute()
const service = ref(null)
const loading = ref(true)
const openFaq = ref(null)

const faqs = [
  { q: 'Do you offer cleaning services alongside moving?', a: 'Yes. We offer professional move-in, move-out, and deep-cleaning services that can be booked alongside your move or as a standalone service. Our certified cleaning crews handle kitchens, bathrooms, appliances, and every corner so your property is spotless for handover or possession.' },
  { q: 'How far in advance should I book my move?', a: 'For the best date and time options, we recommend booking 2 to 4 weeks ahead for local moves and 4 to 8 weeks ahead for long-distance moves. Need last-minute help? Contact us and we will check current availability.' },
  { q: 'What is included in your moving service?', a: 'Our standard moving service includes a trained moving crew, a fully equipped truck, furniture protection, loading and unloading, and placement of items in your new home. We can also add packing, unpacking, and junk removal as needed.' },
  { q: 'Do you offer packing services and moving supplies?', a: 'Yes. We offer full packing, partial packing, and fragile-only packing options. We can also provide moving boxes, tape, mattress covers, and other supplies before your move day.' },
  { q: 'How is the moving price calculated?', a: 'Pricing depends on factors such as move size, distance, access conditions (stairs or elevator), packing needs, and any specialty items. We provide transparent quotes up front so you can clearly understand all expected costs.' },
  { q: 'Are my belongings insured during the move?', a: 'Every move includes basic valuation coverage. If you want additional peace of mind, we also offer enhanced protection options. Your move coordinator can explain coverage levels and help you choose the right plan.' },
  { q: 'Can you move specialty items like pianos or antiques?', a: 'Absolutely. Our team is experienced with delicate and oversized items including pianos, antiques, artwork, and large safes. Let us know in advance so we can bring the proper equipment and crew size.' },
  { q: 'What happens if I need to reschedule?', a: 'Plans can change. If you need to reschedule, contact us as early as possible and we will do our best to move your booking to a new date that works for you. Any applicable policy details will be shared during confirmation.' },
  { q: 'Do you provide local and long-distance moving?', a: 'Yes. We handle both local and long-distance moves for homes and businesses. Whether you are moving across town or to another city, we will build a moving plan tailored to your timeline and budget.' },
]

function servicePhoto(iconKey) {
  const map = {
    'truck':       'https://images.unsplash.com/photo-1698917414969-feade59e3343?w=1400&h=900&fit=crop&q=80',
    'truck-local': 'https://images.unsplash.com/photo-1698917414969-feade59e3343?w=1400&h=900&fit=crop&q=80',
    'truck-long':  'https://images.unsplash.com/photo-1473445730015-841f29a9490b?w=1400&h=900&fit=crop&q=80',
    'boxes':       'https://images.unsplash.com/photo-1600725935160-f67ee4f6084a?w=1400&h=900&fit=crop&q=80',
    'building':    'https://images.unsplash.com/photo-1551471698-c7787ff6b7ca?w=1400&h=900&fit=crop&q=80',
    'hands':       'https://images.unsplash.com/photo-1694715669993-ea0022b470f7?w=1400&h=900&fit=crop&q=80',
    'piano':       'https://images.unsplash.com/photo-1600518464441-9154a4dea21b?w=1400&h=900&fit=crop&q=80',
    'warehouse':   'https://images.unsplash.com/photo-1600725935160-f67ee4f6084a?w=1400&h=900&fit=crop&q=80',
    'star':        'https://images.unsplash.com/photo-1600518464441-9154a4dea21b?w=1400&h=900&fit=crop&q=80',
    'cleaning':    'https://images.unsplash.com/photo-1581578731548-c64695cc6952?w=1400&h=900&fit=crop&q=80',
  }
  return map[iconKey] || 'https://images.unsplash.com/photo-1698917414969-feade59e3343?w=1400&h=900&fit=crop&q=80'
}

function serviceHighlights(slug) {
  const map = {
    'local-moving': [
      'Same-region crews with fast dispatch across Guelph and Waterloo Region.',
      'Careful in-home protection for floors, walls, and furniture edges.',
      'Flexible weekend scheduling with clear arrival communication.',
      'Efficient load and unload workflow to reduce move-day downtime.',
    ],
    'long-distance-moving': [
      'Dedicated route planning for predictable delivery timelines.',
      'Structured inventory handling for high-confidence transport.',
      'Single-point communication throughout your relocation.',
      'Ideal for intercity and interprovincial residential moves.',
    ],
    'commercial-moving': [
      'Project-style planning that limits business disruption.',
      'After-hours and weekend execution options for office moves.',
      'Department labeling and placement flow for fast setup.',
      'Safe handling for desks, files, and key IT equipment.',
    ],
    'packing-services': [
      'Professional material selection for fragile and high-use items.',
      'Room-by-room labeling for clean unpacking and setup.',
      'Partial or full-service options based on your timeline.',
      'Optional unpack support to speed up first-day comfort.',
    ],
    'specialty-items': [
      'Experienced handling for pianos, antiques, and oversized pieces.',
      'Specialized wrapping and movement techniques by item type.',
      'Planned access paths to protect both item and property.',
      'Coordinated lift and equipment support when needed.',
    ],
    'storage': [
      'Flexible storage integration when move dates do not align.',
      'Organized pickup and redelivery scheduling support.',
      'Short-term and long-term options for staged relocations.',
      'Useful for renovation, possession gaps, and downsizing.',
    ],
    'cleaning-services': [
      'Move-in and move-out cleans that meet landlord and property standards.',
      'Deep kitchen and bathroom cleaning with professional-grade products.',
      'Post-renovation cleanup to remove dust, debris, and residue.',
      'Eco-friendly, pet-safe products safe for families and children.',
    ],
  }
  return map[slug] || map['local-moving']
}

async function fetchService(slug) {
  loading.value = true
  const { data } = await supabase.from('services').select('*').eq('slug', slug).single()
  const resolvedService = data || getFallbackServiceBySlug(slug)
  service.value = resolvedService
  if (resolvedService) document.title = `${resolvedService.name} | ManAndTruck Movers`
  loading.value = false
}

onMounted(() => fetchService(route.params.slug))
watch(() => route.params.slug, slug => slug && fetchService(slug))
</script>
