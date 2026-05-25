<template>
  <main class="py-24 flex items-center justify-center min-h-[60vh]">
    <div class="text-center flex flex-col items-center gap-6 px-6">
      <div class="w-24 h-24 rounded-full bg-primary/10 flex items-center justify-center text-primary mx-auto">
        <svg class="w-14 h-14" fill="none" viewBox="0 0 24 24" stroke-width="1.2" stroke="currentColor">
          <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 18.75a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m3 0h6m-9 0H3.375a1.125 1.125 0 01-1.125-1.125V14.25m17.25 4.5a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m3 0h1.125c.621 0 1.129-.504 1.09-1.124a17.902 17.902 0 00-3.213-9.193 2.056 2.056 0 00-1.58-.86H14.25M16.5 18.75h-2.25m0-11.177v-.958c0-.568-.422-1.048-.987-1.106a48.554 48.554 0 00-10.026 0 1.106 1.106 0 00-.987 1.106v7.635m12-6.677v6.677m0 4.5v-4.5m0 0h-12" />
        </svg>
      </div>
      <h1 class="font-heading text-5xl font-bold text-primary uppercase tracking-wide">404</h1>
      <p class="text-2xl font-heading font-semibold text-gray-600 uppercase tracking-wide">Page Not Found</p>
      <p class="text-gray-700 text-base max-w-md">Looks like this page took a wrong turn. Let us help you get back on track.</p>
      <div class="flex flex-wrap justify-center gap-4 mt-2">
        <RouterLink to="/"       class="px-6 py-3 bg-primary text-white font-heading font-bold text-sm uppercase tracking-wide rounded-lg hover:bg-primary-dark transition-colors">Back to Home</RouterLink>
        <RouterLink to="/quote"  class="px-6 py-3 border-2 border-primary text-primary font-heading font-bold text-sm uppercase tracking-wide rounded-lg hover:bg-primary hover:text-white transition-all">Get a Quote</RouterLink>
      </div>
    </div>
  </main>
</template>

<script setup>
import { onMounted } from 'vue'
onMounted(() => { document.title = '404 Not Found | ManAndTruck Movers' })
</script>
