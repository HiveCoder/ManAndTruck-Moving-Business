import { ref, computed, onMounted, onUnmounted, nextTick, watch } from 'vue'

/**
 * Generic slider composable.
 * @param {number|import('vue').Ref<number>} itemCountRef - number of items (or a ref to it)
 * @param {object} options
 * @param {number}   [options.autoplayInterval=4500]
 * @param {function} [options.visibleFn] - (windowWidth) => number of visible cards
 */
export function useSlider(itemCountRef, options = {}) {
  const { autoplayInterval = 4500, visibleFn } = options

  const containerRef  = ref(null)
  const current       = ref(0)
  const containerWidth = ref(0)

  // Accept plain number or a ref
  const itemCount = computed(() =>
    typeof itemCountRef === 'object' && 'value' in itemCountRef
      ? itemCountRef.value
      : itemCountRef
  )

  const visibleCount = computed(() => {
    if (typeof visibleFn === 'function') return visibleFn()
    const w = containerWidth.value || window.innerWidth
    if (w >= 1200) return 4
    if (w >= 900)  return 3
    if (w >= 600)  return 2
    return 1
  })

  const totalSlides = computed(() =>
    Math.max(1, itemCount.value - visibleCount.value + 1)
  )

  const cardWidth  = computed(() =>
    visibleCount.value > 0 ? containerWidth.value / visibleCount.value : 0
  )

  const translateX = computed(() => current.value * cardWidth.value)

  function updateWidth() {
    if (containerRef.value) {
      containerWidth.value = containerRef.value.offsetWidth
    }
  }

  function goTo(index) {
    current.value = Math.max(0, Math.min(index, totalSlides.value - 1))
  }

  function next() {
    goTo(current.value + 1 >= totalSlides.value ? 0 : current.value + 1)
  }

  function prev() {
    goTo(current.value <= 0 ? totalSlides.value - 1 : current.value - 1)
  }

  let autoTimer = null

  function startAuto() {
    autoTimer = setInterval(next, autoplayInterval)
  }

  function stopAuto() {
    clearInterval(autoTimer)
    autoTimer = null
  }

  function resetAuto() {
    stopAuto()
    startAuto()
  }

  // Reset current when totalSlides shrinks (e.g., on resize)
  watch(totalSlides, (n) => {
    if (current.value >= n) current.value = Math.max(0, n - 1)
  })

  // Touch support
  let touchStartX = 0
  function onTouchStart(e) { touchStartX = e.touches[0].clientX }
  function onTouchEnd(e) {
    const dx = e.changedTouches[0].clientX - touchStartX
    if (Math.abs(dx) > 50) { dx < 0 ? next() : prev(); resetAuto() }
  }

  function onResize() { updateWidth() }

  onMounted(async () => {
    await nextTick()
    updateWidth()
    startAuto()
    window.addEventListener('resize', onResize)
  })

  onUnmounted(() => {
    stopAuto()
    window.removeEventListener('resize', onResize)
  })

  return {
    containerRef,
    current,
    totalSlides,
    cardWidth,
    translateX,
    visibleCount,
    goTo,
    next,
    prev,
    stopAuto,
    resetAuto,
    onTouchStart,
    onTouchEnd,
  }
}
