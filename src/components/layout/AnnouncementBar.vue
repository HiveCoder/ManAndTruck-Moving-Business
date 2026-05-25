<template>
  <div class="bg-mid-bg h-10 flex items-center justify-center relative overflow-hidden z-50">
    <button
      class="absolute left-1 z-10 text-primary text-xl leading-none px-1 opacity-60 hover:opacity-100 transition-opacity"
      aria-label="Previous announcement"
      @click="go(-1)"
    >&#8249;</button>

    <div class="relative w-full max-w-2xl h-full overflow-hidden">
      <Transition name="ann-fade">
        <div :key="current" class="absolute inset-0 flex items-center justify-center">
          <p class="text-xs text-primary font-medium text-center px-8">
            <span v-if="slides[current].prefix">{{ slides[current].prefix }}&nbsp;</span>
            <RouterLink
              v-if="slides[current].link"
              :to="slides[current].link"
              class="text-secondary underline font-semibold hover:text-primary transition-colors"
            >{{ slides[current].linkText }}</RouterLink>
            <span v-if="slides[current].suffix">&nbsp;{{ slides[current].suffix }}</span>
          </p>
        </div>
      </Transition>
    </div>

    <button
      class="absolute right-1 z-10 text-primary text-xl leading-none px-1 opacity-60 hover:opacity-100 transition-opacity"
      aria-label="Next announcement"
      @click="go(1)"
    >&#8250;</button>
  </div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'

const slides = [
  { prefix: 'Free in-home estimates available —', link: '/contact', linkText: 'Book yours today', suffix: '' },
  { prefix: 'Rated #1 Moving Company in the region —', link: '/reviews', linkText: 'Read our reviews', suffix: '' },
  { prefix: 'Fully licensed & insured movers — Your belongings are safe with us', link: null, linkText: '', suffix: '' },
]

const current = ref(0)
let timer = null

function go(dir) {
  current.value = (current.value + dir + slides.length) % slides.length
}

function startAuto() { timer = setInterval(() => go(1), 5000) }

onMounted(startAuto)
onUnmounted(() => clearInterval(timer))
</script>
