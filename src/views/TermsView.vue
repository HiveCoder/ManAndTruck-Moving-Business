<template>
  <main>
    <PageHero
      title="Terms of Service"
      subtitle="Service terms for quotes, scheduling, and moving operations."
      badge="Legal"
      :breadcrumbs="[{ to: '/', label: 'Home' }, { label: 'Terms of Service' }]"
    />

    <section class="py-16 bg-light-bg">
      <div class="max-w-[900px] mx-auto px-6">
        <article class="bg-white rounded-xl shadow-card p-8 flex flex-col gap-6 text-gray-700 leading-relaxed">
          <h2 class="font-heading text-2xl font-bold text-primary uppercase tracking-wide">Service Terms</h2>
          <p>Quotes are estimates based on details provided by the customer and may adjust if scope, access conditions, or item count changes.</p>
          <p>Weekend scheduling requires advance booking and depends on crew and truck availability at time of confirmation.</p>
          <p>Customers must disclose specialty items, difficult access, or building restrictions before move day.</p>
          <p>By submitting a quote request, you consent to service communications related to pricing, scheduling, and support.</p>
          <RouterLink to="/quote" class="inline-block px-6 py-3 bg-primary text-white font-heading font-semibold text-sm uppercase tracking-wide rounded-lg hover:bg-primary-dark transition-colors">Request a Quote</RouterLink>
        </article>
      </div>
    </section>
  </main>
</template>

<script setup>
import { onMounted } from 'vue'
import PageHero from '@/components/ui/PageHero.vue'

onMounted(() => {
  document.title = 'Terms of Service | ManAndTruck Movers'
})
</script>
