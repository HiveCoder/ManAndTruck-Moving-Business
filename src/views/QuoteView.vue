<template>
  <main>
    <PageHero title="Get Your Free Quote" subtitle="Fill out the form below and we'll get back to you with a detailed estimate within 24 hours." badge="Free Estimate"
      :breadcrumbs="[{to:'/',label:'Home'},{label:'Get a Quote'}]" />

    <section class="py-20 bg-light-bg">
      <div class="max-w-[760px] mx-auto px-6">
        <div class="bg-white rounded-xl shadow-card-lg p-8 md:p-10">
          <h2 class="font-heading font-bold text-xl text-primary uppercase tracking-wide mb-2">Move Details</h2>
          <p class="text-gray-600 text-sm mb-8">All fields marked * are required.</p>

          <form @submit.prevent="submit" novalidate class="flex flex-col gap-5">

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <label class="form-label">Moving From (Postal Code) *</label>
                <input v-model="form.from_zip" type="text" pattern="[A-Za-z][0-9][A-Za-z][ -]?[0-9][A-Za-z][0-9]" maxlength="7" class="form-input uppercase" :class="{ 'border-red-400': errors.from_zip }" placeholder="M5V 2T6" />
              </div>
              <div>
                <label class="form-label">Moving To (Postal Code) *</label>
                <input v-model="form.to_zip"   type="text" pattern="[A-Za-z][0-9][A-Za-z][ -]?[0-9][A-Za-z][0-9]" maxlength="7" class="form-input uppercase" :class="{ 'border-red-400': errors.to_zip }"   placeholder="L6P 3A1" />
              </div>
            </div>

            <div>
              <label class="form-label">Preferred Move Date</label>
              <WeekendDatePicker
                v-model="form.move_date"
                :min-date="minMoveDate"
                :disabled="form.no_date"
                :invalid="!!errors.move_date"
                placeholder="Select a weekend date"
                @update:modelValue="validateMoveDate"
              />
              <div v-if="form.move_date && !form.no_date" class="mt-2 inline-flex items-center gap-2 px-3 py-1 rounded-full bg-secondary/10 text-secondary text-xs font-heading font-semibold uppercase tracking-wide">
                Selected: {{ formatMoveDate(form.move_date) }}
              </div>
              <p class="mt-1 text-xs text-gray-600">Scheduling is available on Saturdays and Sundays only, minimum 2 weeks in advance.</p>
              <label class="flex items-center gap-2 mt-2 text-xs text-gray-700 cursor-pointer">
                <input v-model="form.no_date" type="checkbox" class="accent-secondary w-4 h-4" />
                I don't have a date yet — flexible
              </label>
            </div>

            <label class="flex items-center gap-2 text-sm text-gray-600 cursor-pointer">
              <input v-model="form.include_packing" type="checkbox" class="accent-secondary w-4 h-4" />
              Include full packing &amp; unpacking services
            </label>

            <hr class="border-border" />
            <p class="font-heading font-semibold text-sm text-secondary uppercase tracking-wide">Your Contact Information</p>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <label class="form-label">Full Name *</label>
                <input v-model="form.name" type="text" class="form-input" :class="{ 'border-red-400': errors.name }" placeholder="Jane Smith" />
              </div>
              <div>
                <label class="form-label">Phone Number *</label>
                <input v-model="form.phone" type="tel" class="form-input" :class="{ 'border-red-400': errors.phone }" placeholder="(416) 555-0136" />
              </div>
            </div>
            <div>
              <label class="form-label">Email Address *</label>
              <input v-model="form.email" type="email" class="form-input" :class="{ 'border-red-400': errors.email }" placeholder="jane@example.com" />
            </div>

            <label class="flex items-start gap-2 text-xs text-gray-700 cursor-pointer">
              <input v-model="form.consent" type="checkbox" class="accent-secondary w-4 h-4 mt-0.5 shrink-0" required />
              I agree to be contacted about my quote. See our <RouterLink to="/privacy" class="underline text-secondary">Privacy Policy</RouterLink>.
            </label>

            <div class="border border-border rounded-xl p-4 bg-light-bg/50 flex flex-col gap-3">
              <p class="font-heading font-semibold text-xs text-secondary uppercase tracking-wide">AI-Assisted Move Planner</p>
              <textarea
                v-model="assistantInput"
                rows="3"
                class="form-input resize-none"
                placeholder="Optional: Tell us your move details (home size, stairs/elevator, specialty items, preferred timing)."
              ></textarea>
              <button
                type="button"
                @click="generateAssistantPlan"
                class="self-start px-4 py-2 bg-primary text-white font-heading font-semibold text-xs uppercase tracking-wide rounded-lg hover:bg-primary-dark transition-colors"
              >
                Generate Plan
              </button>

              <div v-if="assistantPlan" class="bg-white border border-border rounded-xl p-4 flex flex-col gap-3 text-sm">
                <p class="text-gray-700 leading-relaxed"><span class="font-semibold text-primary">Summary:</span> {{ assistantPlan.summary }}</p>
                <div>
                  <p class="font-semibold text-primary mb-1">Checklist</p>
                  <ul class="list-disc pl-5 text-gray-700 space-y-1">
                    <li v-for="item in assistantPlan.checklist" :key="item">{{ item }}</li>
                  </ul>
                </div>
                <div>
                  <p class="font-semibold text-primary mb-1">Timeline</p>
                  <ul class="list-disc pl-5 text-gray-700 space-y-1">
                    <li v-for="step in assistantPlan.timeline" :key="step">{{ step }}</li>
                  </ul>
                </div>
                <div v-if="assistantPlan.riskFlags.length">
                  <p class="font-semibold text-primary mb-1">Watchouts</p>
                  <ul class="list-disc pl-5 text-gray-700 space-y-1">
                    <li v-for="risk in assistantPlan.riskFlags" :key="risk">{{ risk }}</li>
                  </ul>
                </div>
              </div>
            </div>

            <p v-if="errorMsg"  class="text-red-500 text-xs"   role="alert">{{ errorMsg }}</p>
            <p v-if="successMsg" class="text-green-600 text-sm font-semibold text-center" role="status">{{ successMsg }}</p>

            <button type="submit" :disabled="loading"
              class="w-full py-4 bg-cta text-white font-heading font-bold text-base uppercase tracking-widest rounded-xl hover:bg-red-700 hover:shadow-lg transition-all duration-200 disabled:opacity-60 disabled:cursor-not-allowed mt-2">
              {{ loading ? 'Sending…' : 'Request My Free Quote' }}
            </button>

            <p class="text-center text-xs text-gray-600">No obligation. We'll contact you within 24 hours.</p>
          </form>
        </div>
      </div>
    </section>
  </main>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { supabase } from '@/lib/supabase.js'
import { sendLeadEmail } from '@/lib/leadInbox.js'
import { firstBookableWeekend, formatDateInput, isValidMoveDate } from '@/lib/scheduling.js'
import { buildMoveAssistantPlan } from '@/lib/moveAssistant.js'
import PageHero from '@/components/ui/PageHero.vue'
import WeekendDatePicker from '@/components/ui/WeekendDatePicker.vue'

onMounted(() => { document.title = 'Get a Free Quote | ManAndTruck Movers' })

const postalCodeRegex = /^[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d$/
const minMoveDate = formatDateInput(firstBookableWeekend())

const form = reactive({ from_zip: '', to_zip: '', move_date: '', no_date: false, include_packing: false, name: '', phone: '', email: '', consent: false })
const errors    = reactive({})
const errorMsg  = ref('')
const successMsg = ref('')
const loading   = ref(false)
const assistantInput = ref('')
const assistantPlan = ref(null)

function formatMoveDate(value) {
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

function normalizePostalCode(value) {
  return value.trim().toUpperCase()
}

function generateAssistantPlan() {
  assistantPlan.value = buildMoveAssistantPlan({
    fromPostal: normalizePostalCode(form.from_zip),
    toPostal: normalizePostalCode(form.to_zip),
    moveDate: form.no_date ? '' : form.move_date,
    includePacking: form.include_packing,
    notes: assistantInput.value,
  })
}

function validateMoveDate() {
  if (form.no_date || !form.move_date) return true
  const valid = isValidMoveDate(form.move_date)
  if (!valid) {
    errors.move_date = true
    errorMsg.value = 'Move dates must be on Saturday or Sunday, at least 2 weeks in advance.'
  } else {
    delete errors.move_date
  }
  return valid
}

function validate() {
  const e = {}
  if (!postalCodeRegex.test(form.from_zip.trim())) e.from_zip = true
  if (!postalCodeRegex.test(form.to_zip.trim()))   e.to_zip   = true
  if (!form.no_date && !form.move_date) e.move_date = true
  if (!form.no_date && form.move_date && !isValidMoveDate(form.move_date)) e.move_date = true
  if (!form.name.trim())  e.name  = true
  if (!form.phone.trim()) e.phone = true
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.email)) e.email = true
  Object.keys(errors).forEach(k => delete errors[k])
  Object.assign(errors, e)
  return Object.keys(e).length === 0
}

async function submit() {
  errorMsg.value = ''
  successMsg.value = ''
  if (!validate()) {
    errorMsg.value = errors.move_date
      ? 'Move dates must be on Saturday or Sunday, at least 2 weeks in advance.'
      : 'Please fill in all required fields correctly.'
    return
  }
  if (!validateMoveDate()) return
  if (!form.consent) { errorMsg.value = 'Please agree to be contacted.'; return }
  loading.value = true
  try {
    const fromPostal = normalizePostalCode(form.from_zip)
    const toPostal = normalizePostalCode(form.to_zip)
    const moveDate = form.no_date ? null : form.move_date
    const cleanName = form.name.trim()
    const cleanPhone = form.phone.trim()
    const cleanEmail = form.email.trim()

    const { error } = await supabase.from('quote_requests').insert([{
      from_zip: fromPostal, to_zip: toPostal,
      move_date: moveDate,
      no_date: form.no_date, include_packing: form.include_packing,
      name: cleanName, phone: cleanPhone, email: cleanEmail,
    }])
    if (error) throw error

    const emailDelivered = await sendLeadEmail({
      subject: `New Free Quote Request - ${cleanName}`,
      name: cleanName,
      replyTo: cleanEmail,
      lines: [
        `Name: ${cleanName}`,
        `Phone: ${cleanPhone}`,
        `Customer Email: ${cleanEmail}`,
        `From Postal: ${fromPostal}`,
        `To Postal: ${toPostal}`,
        `Move Date: ${moveDate || 'Flexible / not selected'}`,
        `Include Packing: ${form.include_packing ? 'Yes' : 'No'}`,
        '',
        `AI Notes: ${assistantInput.value.trim() || 'None provided'}`,
      ],
    })

    successMsg.value = emailDelivered
      ? 'Quote request submitted and delivered to our inbox. We\'ll reach out within 24 hours.'
      : 'Quote saved, but email relay is currently unavailable. Please call us at (416) 555-0136.'
    Object.assign(form, { from_zip: '', to_zip: '', move_date: '', no_date: false, include_packing: false, name: '', phone: '', email: '', consent: false })
    Object.keys(errors).forEach(k => delete errors[k])
  } catch (err) {
    errorMsg.value = 'Something went wrong. Please call us at (416) 555-0136.'
    console.error(err)
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.form-label { @apply block text-xs font-heading font-semibold uppercase tracking-wide text-gray-700 mb-1; }
.form-input  { @apply w-full px-4 py-2.5 text-sm border border-border rounded-lg focus:outline-none focus:ring-2 focus:ring-secondary/40 focus:border-secondary transition-all duration-200; }
</style>
