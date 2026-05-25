<template>
  <main>
    <PageHero
      title="Accessibility"
      subtitle="Our commitment to accessible digital and service experiences."
      badge="Legal"
      :breadcrumbs="[{ to: '/', label: 'Home' }, { label: 'Accessibility' }]"
    />

    <section class="py-16 bg-light-bg">
      <div class="max-w-[900px] mx-auto px-6">
        <article class="bg-white rounded-xl shadow-card p-8 flex flex-col gap-6 text-gray-700 leading-relaxed">
          <h2 class="font-heading text-2xl font-bold text-primary uppercase tracking-wide">Accessibility Statement</h2>
          <p>We aim to provide an accessible website experience across modern browsers, desktops, and mobile devices.</p>
          <p>If you encounter accessibility barriers, please contact us so we can improve quickly.</p>
          <p>We actively review color contrast, keyboard navigation, and readable content structure as we update the site.</p>
          <RouterLink to="/contact" class="inline-block px-6 py-3 bg-primary text-white font-heading font-semibold text-sm uppercase tracking-wide rounded-lg hover:bg-primary-dark transition-colors">Report an Issue</RouterLink>
        </article>
      </div>
    </section>
  </main>
</template>

<script setup>
import { onMounted } from 'vue'
import PageHero from '@/components/ui/PageHero.vue'

onMounted(() => {
  document.title = 'Accessibility | ManAndTruck Movers'
})
</script>
