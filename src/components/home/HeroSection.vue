<template>
  <section class="relative overflow-hidden bg-gradient-to-br from-primary-dark via-primary to-secondary min-h-[90vh] flex items-center">
    <!-- Subtle pattern overlay -->
    <div class="absolute inset-0 opacity-5 bg-[radial-gradient(circle_at_1px_1px,white_1px,transparent_0)] bg-[length:28px_28px] pointer-events-none" aria-hidden="true"></div>

    <div class="max-w-[1280px] mx-auto px-6 py-16 w-full relative z-10 grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">

      <!-- Left: headline + form -->
      <div class="flex flex-col gap-8">
        <div class="flex flex-col gap-4">
          <p class="inline-block self-start px-4 py-1 bg-accent/20 rounded-full font-heading text-[0.78rem] font-semibold uppercase tracking-[0.15em] text-accent">
            Trusted Local Movers
          </p>
          <h1 class="font-heading text-5xl md:text-6xl font-bold text-white leading-tight uppercase tracking-wide">
            Moving Made<br>
            <span class="text-accent">Simple.</span>
          </h1>
          <p class="text-white/75 text-lg max-w-lg leading-relaxed">
            Professional, careful, on-time moving services for homes and businesses. Licensed, insured, and fully dedicated to your peace of mind.
          </p>
        </div>

        <!-- Trust badges row -->
        <div class="flex flex-wrap gap-4">
          <span v-for="badge in badges" :key="badge"
            class="flex items-center gap-1.5 bg-white/10 backdrop-blur-sm border border-white/20 rounded-full px-3 py-1.5 text-xs font-semibold text-white/90 font-heading uppercase tracking-wide">
            <span class="text-accent text-sm">✓</span> {{ badge }}
          </span>
        </div>

        <!-- Quote Form Card -->
        <div class="bg-white rounded-xl shadow-card-lg p-6 text-primary">
          <p class="font-heading text-sm font-bold uppercase tracking-widest text-secondary mb-4">Get Your Free Quote</p>

          <form @submit.prevent="submitQuote" novalidate class="flex flex-col gap-3">
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
              <input v-model="form.from_zip" type="text" inputmode="numeric" pattern="[0-9]{5}" placeholder="From ZIP Code" maxlength="5" class="form-input" :class="{ 'border-red-400': errors.from_zip }" />
              <input v-model="form.to_zip"   type="text" inputmode="numeric" pattern="[0-9]{5}" placeholder="To ZIP Code"   maxlength="5" class="form-input" :class="{ 'border-red-400': errors.to_zip }" />
            </div>

            <div class="flex flex-col gap-1">
              <input v-model="form.move_date" type="date" :min="today" class="form-input" :disabled="form.no_date" :class="{ 'border-red-400': errors.move_date, 'opacity-50 cursor-not-allowed': form.no_date }" />
              <label class="flex items-center gap-2 text-xs text-gray-500 cursor-pointer">
                <input v-model="form.no_date" type="checkbox" class="accent-secondary w-4 h-4" />
                I don't have a date yet
              </label>
            </div>

            <label class="flex items-center gap-2 text-sm text-gray-600 cursor-pointer">
              <input v-model="form.include_packing" type="checkbox" class="accent-secondary w-4 h-4" />
              Include packing &amp; unpacking services
            </label>

            <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
              <input v-model="form.name"  type="text"  placeholder="Full Name"     class="form-input" :class="{ 'border-red-400': errors.name }" />
              <input v-model="form.phone" type="tel"   placeholder="Phone Number"  class="form-input" :class="{ 'border-red-400': errors.phone }" />
            </div>
            <input v-model="form.email" type="email" placeholder="Email Address" class="form-input" :class="{ 'border-red-400': errors.email }" />

            <label class="flex items-start gap-2 text-xs text-gray-500 cursor-pointer mt-1">
              <input v-model="form.consent" type="checkbox" class="accent-secondary w-4 h-4 mt-0.5 shrink-0" required />
              I agree to be contacted about my moving quote. View our
              <RouterLink to="/privacy" class="underline text-secondary">Privacy Policy</RouterLink>.
            </label>

            <p v-if="errorMsg" class="text-red-500 text-xs text-center" role="alert">{{ errorMsg }}</p>
            <p v-if="successMsg" class="text-green-600 text-sm text-center font-semibold" role="status">{{ successMsg }}</p>

            <button type="submit" :disabled="loading"
              class="w-full py-3.5 bg-cta text-white font-heading font-bold text-base uppercase tracking-widest rounded-lg transition-all duration-200 hover:bg-red-700 hover:shadow-lg disabled:opacity-60 disabled:cursor-not-allowed mt-1">
              {{ loading ? 'Sending…' : 'Get My Free Quote →' }}
            </button>
          </form>
        </div>
      </div>

      <!-- Right: moving crew photo -->
      <div class="hidden lg:block rounded-2xl overflow-hidden shadow-2xl">
        <img
          src="https://images.unsplash.com/photo-1600518464441-9154a4dea21b?w=800&h=600&fit=crop&q=80"
          alt="Professional movers at work"
          class="w-full h-full object-cover"
          loading="eager"
        />
      </div>

    </div>
  </section>
</template>

<script setup>
import { ref, reactive, computed } from 'vue'
import { supabase } from '@/lib/supabase.js'

const badges = ['Licensed & Insured', 'Free Estimates', 'No Hidden Fees', 'On-Time Guaranteed']

const today = new Date().toISOString().split('T')[0]

const form = reactive({
  from_zip: '', to_zip: '', move_date: '', no_date: false,
  include_packing: false, name: '', phone: '', email: '', consent: false,
})

const errors    = reactive({})
const errorMsg  = ref('')
const successMsg = ref('')
const loading   = ref(false)

function validate() {
  const e = {}
  if (!/^\d{5}$/.test(form.from_zip)) e.from_zip = true
  if (!/^\d{5}$/.test(form.to_zip))   e.to_zip   = true
  if (!form.no_date && !form.move_date) e.move_date = true
  if (!form.name.trim()) e.name  = true
  if (!form.phone.trim()) e.phone = true
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.email)) e.email = true
  Object.assign(errors, e)
  return Object.keys(e).length === 0
}

async function submitQuote() {
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
    successMsg.value = 'Your quote request was received! We\'ll be in touch shortly.'
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
.form-input {
  @apply w-full px-4 py-2.5 text-sm border border-border rounded-lg focus:outline-none focus:ring-2 focus:ring-secondary/40 focus:border-secondary transition-all duration-200;
}
</style>
