<template>
  <Transition name="fade">
    <button
      v-if="visible"
      class="fixed bottom-6 right-6 z-30 w-11 h-11 rounded-full bg-primary text-white border-none shadow-card-lg flex items-center justify-center text-xl cursor-pointer hover:bg-secondary hover:scale-110 transition-all duration-200"
      aria-label="Back to top"
      @click="scrollToTop"
    >
      &#8679;
    </button>
  </Transition>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

const visible = ref(false)

function onScroll() { visible.value = window.scrollY > 400 }
function scrollToTop() { window.scrollTo({ top: 0, behavior: 'smooth' }) }

onMounted(() => window.addEventListener('scroll', onScroll, { passive: true }))
onUnmounted(() => window.removeEventListener('scroll', onScroll))
</script>

<style scoped>
.fade-enter-active, .fade-leave-active { transition: opacity 0.3s, transform 0.3s; }
.fade-enter-from, .fade-leave-to { opacity: 0; transform: translateY(8px); }
</style>
