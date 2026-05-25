<template>
  <div class="overflow-hidden relative" ref="containerRef" @touchstart="onTouchStart" @touchend="onTouchEnd">
    <!-- Track -->
    <div
      class="slider-track"
      :style="{ transform: `translateX(-${translateX}px)` }"
    >
      <div
        v-for="(item, i) in items"
        :key="i"
        :style="{ width: `${cardWidth}px`, flexShrink: '0' }"
      >
        <slot name="item" :item="item" :index="i" />
      </div>
    </div>

    <!-- Prev -->
    <button
      v-if="items.length > visibleCount"
      class="absolute left-0 top-1/2 -translate-y-1/2 w-9 h-9 rounded-full bg-white border-2 border-border flex items-center justify-center text-primary text-xl shadow-card hover:bg-primary hover:text-white hover:border-primary transition-all duration-200 z-10"
      aria-label="Previous"
      @click="prev(); resetAuto()"
    >&#8249;</button>

    <!-- Next -->
    <button
      v-if="items.length > visibleCount"
      class="absolute right-0 top-1/2 -translate-y-1/2 w-9 h-9 rounded-full bg-white border-2 border-border flex items-center justify-center text-primary text-xl shadow-card hover:bg-primary hover:text-white hover:border-primary transition-all duration-200 z-10"
      aria-label="Next"
      @click="next(); resetAuto()"
    >&#8250;</button>
  </div>

  <!-- Dots -->
  <div v-if="totalSlides > 1" class="flex justify-center gap-2 mt-6" aria-label="Slide indicators">
    <button
      v-for="i in totalSlides"
      :key="i - 1"
      :class="['w-2.5 h-2.5 rounded-full border-none p-0 cursor-pointer transition-all duration-200', current === i - 1 ? 'bg-secondary scale-125' : 'bg-border']"
      :aria-label="`Go to slide ${i}`"
      @click="goTo(i - 1); resetAuto()"
    />
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useSlider } from '@/composables/useSlider.js'

const props = defineProps({
  items:            { type: Array,    required: true },
  visibleFn:        { type: Function, default: null },
  autoplayInterval: { type: Number,   default: 4500 },
})

const itemCount = computed(() => props.items.length)

const {
  containerRef,
  current,
  totalSlides,
  cardWidth,
  translateX,
  visibleCount,
  goTo,
  next,
  prev,
  resetAuto,
  onTouchStart,
  onTouchEnd,
} = useSlider(itemCount, {
  autoplayInterval: props.autoplayInterval,
  visibleFn: props.visibleFn,
})
</script>
