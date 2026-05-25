<template>
  <main>
    <PageHero
      title="Admin: Quote Requests"
      subtitle="Review incoming requests and verify weekend-only scheduling compliance."
      badge="Admin"
      :breadcrumbs="[{ to: '/', label: 'Home' }, { label: 'Admin Quotes' }]"
    />

    <section class="py-16 bg-light-bg">
      <div class="max-w-[1280px] mx-auto px-6">
        <div class="mb-6 rounded-xl border border-secondary/20 bg-secondary/5 p-4">
          <p class="font-heading font-semibold text-sm uppercase tracking-wide text-secondary">Scheduling Rule</p>
          <p class="text-sm text-gray-700 mt-1">Moves must be booked on Saturday or Sunday only, and at least 2 weeks in advance. Requests marked flexible can have no move date.</p>
        </div>

        <div class="bg-white rounded-xl shadow-card overflow-hidden">
          <div class="px-5 py-4 border-b border-border flex items-center justify-between gap-4">
            <h2 class="font-heading font-bold text-lg uppercase tracking-wide text-primary">Latest Quote Requests</h2>
            <button
              type="button"
              class="px-4 py-2 bg-primary text-white text-xs font-heading font-semibold uppercase tracking-wide rounded hover:bg-primary-dark transition-colors"
              @click="fetchQuotes"
              :disabled="loading"
            >
              {{ loading ? 'Refreshing...' : 'Refresh' }}
            </button>
          </div>

          <div v-if="loading" class="p-8">
            <LoadingSpinner />
          </div>

          <div v-else-if="errorMsg" class="p-6 text-sm text-red-600">{{ errorMsg }}</div>

          <div v-else-if="!quotes.length" class="p-8 text-center text-gray-600 text-sm">No quote requests found.</div>

          <div v-else class="overflow-x-auto">
            <table class="min-w-full text-sm">
              <thead class="bg-light-bg text-gray-700 uppercase text-[11px] tracking-wide">
                <tr>
                  <th class="text-left px-4 py-3">Created</th>
                  <th class="text-left px-4 py-3">Customer</th>
                  <th class="text-left px-4 py-3">Route</th>
                  <th class="text-left px-4 py-3">Move Date</th>
                  <th class="text-left px-4 py-3">Rule Check</th>
                  <th class="text-left px-4 py-3">Packing</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="quote in quotes" :key="quote.id" class="border-t border-border">
                  <td class="px-4 py-3 text-gray-700">{{ formatDateTime(quote.created_at) }}</td>
                  <td class="px-4 py-3">
                    <p class="font-semibold text-primary">{{ quote.name }}</p>
                    <p class="text-gray-600 text-xs">{{ quote.email }}</p>
                    <p class="text-gray-600 text-xs">{{ quote.phone }}</p>
                  </td>
                  <td class="px-4 py-3 text-gray-700">{{ quote.from_zip }} to {{ quote.to_zip }}</td>
                  <td class="px-4 py-3 text-gray-700">
                    <span v-if="quote.no_date || !quote.move_date" class="text-xs px-2 py-1 rounded-full bg-gray-100 text-gray-600">Flexible</span>
                    <span v-else>{{ formatDate(quote.move_date) }}</span>
                  </td>
                  <td class="px-4 py-3">
                    <span
                      class="text-xs px-2 py-1 rounded-full font-semibold"
                      :class="validateRule(quote).ok ? 'bg-green-100 text-green-700' : 'bg-red-100 text-red-700'"
                    >
                      {{ validateRule(quote).label }}
                    </span>
                  </td>
                  <td class="px-4 py-3 text-gray-700">{{ quote.include_packing ? 'Yes' : 'No' }}</td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </section>
  </main>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import { supabase } from '@/lib/supabase.js'
import { isValidMoveDate } from '@/lib/scheduling.js'
import PageHero from '@/components/ui/PageHero.vue'
import LoadingSpinner from '@/components/ui/LoadingSpinner.vue'

const quotes = ref([])
const loading = ref(true)
const errorMsg = ref('')

function formatDate(value) {
  if (!value) return ''
  const date = new Date(`${value}T12:00:00`)
  if (Number.isNaN(date.getTime())) return value
  return date.toLocaleDateString('en-CA', {
    weekday: 'short',
    month: 'short',
    day: 'numeric',
    year: 'numeric',
  })
}

function formatDateTime(value) {
  if (!value) return '-'
  const date = new Date(value)
  if (Number.isNaN(date.getTime())) return value
  return date.toLocaleString('en-CA', {
    month: 'short',
    day: 'numeric',
    year: 'numeric',
    hour: 'numeric',
    minute: '2-digit',
  })
}

function validateRule(quote) {
  if (quote.no_date || !quote.move_date) {
    return { ok: true, label: 'Flexible (No Date)' }
  }
  const ok = isValidMoveDate(quote.move_date)
  return { ok, label: ok ? 'Compliant' : 'Outside Rule' }
}

async function fetchQuotes() {
  loading.value = true
  errorMsg.value = ''
  try {
    const { data, error } = await supabase
      .from('quote_requests')
      .select('id,created_at,from_zip,to_zip,move_date,no_date,include_packing,name,phone,email')
      .order('created_at', { ascending: false })
      .limit(200)

    if (error) throw error
    quotes.value = data || []
  } catch (err) {
    errorMsg.value = 'Unable to load quote requests. Check your Supabase permissions and table policies.'
    console.error(err)
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  document.title = 'Admin Quote Requests | ManAndTruck Movers'
  fetchQuotes()
})
</script>
