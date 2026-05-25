<template>
  <div ref="rootEl" class="relative">
    <button
      type="button"
      class="w-full px-4 py-2.5 text-sm border border-border rounded-lg focus:outline-none focus:ring-2 focus:ring-secondary/40 focus:border-secondary transition-all duration-200 text-left flex items-center justify-between"
      :class="{
        'opacity-50 cursor-not-allowed': disabled,
        'border-red-400': invalid,
      }"
      :disabled="disabled"
      @click="toggleCalendar"
    >
      <span :class="selectedDate ? 'text-gray-900' : 'text-gray-500'">{{ displayValue }}</span>
      <svg class="w-4 h-4 text-gray-500" fill="none" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" aria-hidden="true">
        <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 15l3.75-3.75L15.75 15" />
      </svg>
    </button>

    <div v-if="open && !disabled" class="absolute z-30 mt-2 w-[300px] max-w-full rounded-xl border border-border bg-white shadow-card-lg p-3">
      <div class="flex items-center justify-between mb-3">
        <button type="button" class="p-1.5 rounded hover:bg-light-bg text-primary" @click="goMonth(-1)" aria-label="Previous month">&#8249;</button>
        <p class="font-heading text-sm font-bold uppercase tracking-wide text-primary">{{ monthLabel }}</p>
        <button type="button" class="p-1.5 rounded hover:bg-light-bg text-primary" @click="goMonth(1)" aria-label="Next month">&#8250;</button>
      </div>

      <div class="grid grid-cols-7 gap-1 text-[11px] font-heading font-semibold uppercase tracking-wide text-gray-500 mb-1">
        <span v-for="name in dayNames" :key="name" class="text-center py-1">{{ name }}</span>
      </div>

      <div class="grid grid-cols-7 gap-1">
        <button
          v-for="day in calendarDays"
          :key="day.key"
          type="button"
          class="h-9 rounded text-sm transition-colors"
          :class="dayClass(day)"
          :disabled="!day.inCurrentMonth || day.disabled"
          @click="selectDay(day)"
        >
          {{ day.date.getDate() }}
        </button>
      </div>

      <p class="mt-3 text-[11px] text-gray-600">Select a Saturday or Sunday at least 2 weeks from today.</p>
    </div>
  </div>
</template>

<script setup>
import { computed, onMounted, onUnmounted, ref, watch } from 'vue'
import { formatDateInput, isWeekendDate, minimumMoveDate, parseDateInput } from '@/lib/scheduling.js'

const props = defineProps({
  modelValue: { type: String, default: '' },
  minDate: { type: String, default: '' },
  disabled: { type: Boolean, default: false },
  invalid: { type: Boolean, default: false },
  placeholder: { type: String, default: 'Select move date' },
})

const emit = defineEmits(['update:modelValue'])

const dayNames = ['S', 'M', 'T', 'W', 'T', 'F', 'S']
const open = ref(false)
const rootEl = ref(null)

const selectedDate = computed(() => parseDateInput(props.modelValue))

const minSelectableDate = computed(() => {
  const fromProp = parseDateInput(props.minDate)
  if (fromProp) return fromProp
  return minimumMoveDate()
})

const currentMonth = ref(0)
const currentYear = ref(0)

watch(
  selectedDate,
  (val) => {
    const basis = val || minSelectableDate.value
    currentMonth.value = basis.getMonth()
    currentYear.value = basis.getFullYear()
  },
  { immediate: true }
)

const monthLabel = computed(() => {
  const d = new Date(currentYear.value, currentMonth.value, 1)
  return d.toLocaleDateString('en-CA', { month: 'long', year: 'numeric' })
})

const displayValue = computed(() => {
  if (!selectedDate.value) return props.placeholder
  return selectedDate.value.toLocaleDateString('en-CA', {
    weekday: 'short',
    month: 'short',
    day: 'numeric',
    year: 'numeric',
  })
})

const calendarDays = computed(() => {
  const first = new Date(currentYear.value, currentMonth.value, 1)
  const startOffset = first.getDay()
  const start = new Date(currentYear.value, currentMonth.value, 1 - startOffset)

  const days = []
  for (let i = 0; i < 42; i += 1) {
    const date = new Date(start.getFullYear(), start.getMonth(), start.getDate() + i, 12)
    const inCurrentMonth = date.getMonth() === currentMonth.value
    const weekend = isWeekendDate(date)
    const beforeWindow = date.getTime() < minSelectableDate.value.getTime()

    days.push({
      key: formatDateInput(date),
      date,
      inCurrentMonth,
      weekend,
      disabled: !weekend || beforeWindow,
      selected: props.modelValue === formatDateInput(date),
    })
  }
  return days
})

function dayClass(day) {
  if (!day.inCurrentMonth) return 'text-gray-300 cursor-not-allowed bg-gray-50'
  if (day.selected) return 'bg-secondary text-white font-semibold'
  if (day.disabled) return 'text-gray-300 cursor-not-allowed bg-gray-50'
  return 'text-primary hover:bg-light-bg'
}

function toggleCalendar() {
  open.value = !open.value
}

function goMonth(step) {
  const d = new Date(currentYear.value, currentMonth.value + step, 1)
  currentMonth.value = d.getMonth()
  currentYear.value = d.getFullYear()
}

function selectDay(day) {
  if (day.disabled) return
  emit('update:modelValue', formatDateInput(day.date))
  open.value = false
}

function onOutsideClick(e) {
  if (!open.value) return
  const root = rootEl.value
  if (root && !root.contains(e.target)) {
    open.value = false
  }
}

onMounted(() => {
  document.addEventListener('click', onOutsideClick)
})

onUnmounted(() => {
  document.removeEventListener('click', onOutsideClick)
})
</script>
