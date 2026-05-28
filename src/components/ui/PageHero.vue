<template>
  <section class="relative overflow-hidden bg-gradient-to-br from-primary-dark via-primary to-secondary py-20">
    <div class="max-w-[1280px] mx-auto px-6 relative z-10 text-center text-white">
      <p v-if="badge" class="inline-block mb-3 px-3 py-1 bg-white/15 rounded-full text-xs uppercase tracking-widest font-heading font-semibold text-accent">
        {{ badge }}
      </p>
      <h1 class="font-heading text-4xl md:text-5xl font-bold uppercase tracking-wide mb-4 text-white">{{ title }}</h1>
      <p v-if="subtitle" class="text-white/90 text-lg max-w-2xl mx-auto">{{ subtitle }}</p>
      <nav aria-label="Breadcrumb" v-if="breadcrumbs && breadcrumbs.length" class="mt-6 flex justify-center gap-2 text-sm text-white/80">
        <span v-for="(crumb, i) in breadcrumbs" :key="i" class="flex items-center gap-2">
          <RouterLink v-if="crumb.to" :to="crumb.to" class="hover:text-white transition-colors">{{ crumb.label }}</RouterLink>
          <span v-else class="text-white font-semibold">{{ crumb.label }}</span>
          <span v-if="i < breadcrumbs.length - 1" class="text-white/60">›</span>
        </span>
      </nav>
    </div>
    <!-- Background decorative circle -->
    <div class="absolute -right-20 -top-20 w-72 h-72 rounded-full bg-white/5 pointer-events-none" aria-hidden="true"></div>
    <div class="absolute -left-10 -bottom-10 w-52 h-52 rounded-full bg-white/5 pointer-events-none" aria-hidden="true"></div>
  </section>
</template>

<script setup>
defineProps({
  title:       { type: String, required: true },
  subtitle:    { type: String, default: null },
  badge:       { type: String, default: null },
  breadcrumbs: { type: Array,  default: () => [] },
})
</script>
