<template>
  <main>
    <PageHero
      title="Privacy Policy"
      subtitle="How we collect, use, and protect your personal information."
      badge="Legal"
      :breadcrumbs="[{ to: '/', label: 'Home' }, { label: 'Privacy Policy' }]"
    />

    <section class="py-16 bg-light-bg">
      <div class="max-w-[900px] mx-auto px-6">
        <article class="bg-white rounded-xl shadow-card p-8 flex flex-col gap-6 text-gray-700 leading-relaxed">
          <h2 class="font-heading text-2xl font-bold text-primary uppercase tracking-wide">Your Privacy Matters</h2>
          <p>We collect contact details and move request information to provide quotes, schedule services, and support your move.</p>
          <p>Information submitted through our forms is used only for service communication, booking coordination, and customer support.</p>
          <p>We do not sell personal information. We limit access to authorized staff and service providers who support operations.</p>
          <p>You can request correction or deletion of your data by submitting a request through our contact form.</p>
          <RouterLink to="/contact" class="inline-block px-6 py-3 bg-primary text-white font-heading font-semibold text-sm uppercase tracking-wide rounded-lg hover:bg-primary-dark transition-colors">Contact Us</RouterLink>
        </article>
      </div>
    </section>
  </main>
</template>

<script setup>
import { onMounted } from 'vue'
import PageHero from '@/components/ui/PageHero.vue'

onMounted(() => {
  document.title = 'Privacy Policy | ManAndTruck Movers'
})
</script>
