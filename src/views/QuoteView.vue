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
                <label class="form-label">Moving From (ZIP) *</label>
                <input v-model="form.from_zip" type="text" inputmode="numeric" pattern="[0-9]{5}" maxlength="5" class="form-input" :class="{ 'border-red-400': errors.from_zip }" placeholder="10001" />
              </div>
              <div>
                <label class="form-label">Moving To (ZIP) *</label>
                <input v-model="form.to_zip"   type="text" inputmode="numeric" pattern="[0-9]{5}" maxlength="5" class="form-input" :class="{ 'border-red-400': errors.to_zip }"   placeholder="90210" />
              </div>
            </div>

            <div>
              <label class="form-label">Preferred Move Date</label>
              <input v-model="form.move_date" type="date" :min="today" class="form-input" :disabled="form.no_date" :class="{ 'opacity-50': form.no_date }" />
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
                <input v-model="form.phone" type="tel" class="form-input" :class="{ 'border-red-400': errors.phone }" placeholder="(555) 000-0000" />
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
import PageHero from '@/components/ui/PageHero.vue'

onMounted(() => { document.title = 'Get a Free Quote | ManAndTruck Movers' })

const today = new Date().toISOString().split('T')[0]
const form = reactive({ from_zip: '', to_zip: '', move_date: '', no_date: false, include_packing: false, name: '', phone: '', email: '', consent: false })
const errors    = reactive({})
const errorMsg  = ref('')
const successMsg = ref('')
const loading   = ref(false)

function validate() {
  const e = {}
  if (!/^\d{5}$/.test(form.from_zip)) e.from_zip = true
  if (!/^\d{5}$/.test(form.to_zip))   e.to_zip   = true
  if (!form.name.trim())  e.name  = true
  if (!form.phone.trim()) e.phone = true
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.email)) e.email = true
  Object.assign(errors, e)
  return Object.keys(e).length === 0
}

async function submit() {
  errorMsg.value = ''
  successMsg.value = ''
  if (!validate()) { errorMsg.value = 'Please fill in all required fields correctly.'; return }
  if (!form.consent) { errorMsg.value = 'Please agree to be contacted.'; return }
  loading.value = true
  try {
    const { error } = await supabase.from('quote_requests').insert([{
      from_zip: form.from_zip, to_zip: form.to_zip,
      move_date: form.no_date ? null : form.move_date,
      no_date: form.no_date, include_packing: form.include_packing,
      name: form.name.trim(), phone: form.phone.trim(), email: form.email.trim(),
    }])
    if (error) throw error
    successMsg.value = 'Quote request submitted! We\'ll reach out within 24 hours.'
    Object.assign(form, { from_zip: '', to_zip: '', move_date: '', no_date: false, include_packing: false, name: '', phone: '', email: '', consent: false })
    Object.keys(errors).forEach(k => delete errors[k])
  } catch (err) {
    errorMsg.value = 'Something went wrong. Please call us at (555) 123-4567.'
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
