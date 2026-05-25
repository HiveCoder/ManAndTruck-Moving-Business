<template>
  <main>
    <PageHero title="Contact Us" subtitle="Questions, quotes, or just want to talk — we're here for you." badge="Get in Touch"
      :breadcrumbs="[{to:'/',label:'Home'},{label:'Contact'}]" />

    <section class="py-20 bg-light-bg">
      <div class="max-w-[1280px] mx-auto px-6 grid grid-cols-1 lg:grid-cols-[1fr_380px] gap-12">

        <!-- Form -->
        <div class="bg-white rounded-xl shadow-card p-8">
          <h2 class="font-heading font-bold text-xl text-primary uppercase tracking-wide mb-6">Send Us a Message</h2>

          <form @submit.prevent="submitContact" novalidate class="flex flex-col gap-4">
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <label class="form-label">Full Name *</label>
                <input v-model="form.name" type="text" class="form-input" :class="{ 'border-red-400': errors.name }" placeholder="Jane Smith" />
              </div>
              <div>
                <label class="form-label">Email Address *</label>
                <input v-model="form.email" type="email" class="form-input" :class="{ 'border-red-400': errors.email }" placeholder="jane@example.com" />
              </div>
            </div>
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <label class="form-label">Phone Number</label>
                <input v-model="form.phone" type="tel" class="form-input" placeholder="(555) 000-0000" />
              </div>
              <div>
                <label class="form-label">Subject *</label>
                <select v-model="form.subject" class="form-input" :class="{ 'border-red-400': errors.subject }">
                  <option value="">Select a subject…</option>
                  <option>General Inquiry</option>
                  <option>Quote Request</option>
                  <option>Schedule a Move</option>
                  <option>Complaint / Feedback</option>
                  <option>Other</option>
                </select>
              </div>
            </div>
            <div>
              <label class="form-label">Message *</label>
              <textarea v-model="form.message" rows="5" class="form-input resize-none" :class="{ 'border-red-400': errors.message }" placeholder="Tell us how we can help…"></textarea>
            </div>

            <p v-if="errorMsg"  class="text-red-500 text-xs"  role="alert">{{ errorMsg }}</p>
            <p v-if="successMsg" class="text-green-600 text-sm font-semibold" role="status">{{ successMsg }}</p>

            <button type="submit" :disabled="loading"
              class="w-full py-3.5 bg-primary text-white font-heading font-bold text-sm uppercase tracking-widest rounded-lg hover:bg-primary-dark transition-colors disabled:opacity-60 disabled:cursor-not-allowed">
              {{ loading ? 'Sending…' : 'Send Message →' }}
            </button>
          </form>
        </div>

        <!-- Sidebar -->
        <aside class="flex flex-col gap-6">
          <div class="bg-white rounded-xl shadow-card p-6 flex flex-col gap-5">
            <h3 class="font-heading font-bold text-base text-primary uppercase tracking-wide">Contact Information</h3>
            <div v-for="info in contactInfo" :key="info.label" class="flex items-start gap-3">
              <div class="w-8 h-8 rounded-full bg-primary/10 flex items-center justify-center text-primary shrink-0 mt-0.5">
                <svg v-if="info.iconKey === 'phone'" class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 6.75c0 8.284 6.716 15 15 15h2.25a2.25 2.25 0 002.25-2.25v-1.372c0-.516-.351-.966-.852-1.091l-4.423-1.106c-.44-.11-.902.055-1.173.417l-.97 1.293c-.282.376-.769.542-1.21.38a12.035 12.035 0 01-7.143-7.143c-.162-.441.004-.928.38-1.21l1.293-.97c.363-.271.527-.734.417-1.173L6.963 3.102a1.125 1.125 0 00-1.091-.852H4.5A2.25 2.25 0 002.25 4.5v2.25z" />
                </svg>
                <svg v-else-if="info.iconKey === 'email'" class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M21.75 6.75v10.5a2.25 2.25 0 01-2.25 2.25h-15a2.25 2.25 0 01-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25m19.5 0v.243a2.25 2.25 0 01-1.07 1.916l-7.5 4.615a2.25 2.25 0 01-2.36 0L3.32 8.91a2.25 2.25 0 01-1.07-1.916V6.75" />
                </svg>
                <svg v-else-if="info.iconKey === 'clock'" class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M12 6v6h4.5m4.5 0a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
                <svg v-else class="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" />
                  <path stroke-linecap="round" stroke-linejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1115 0z" />
                </svg>
              </div>
              <div>
                <p class="font-heading font-semibold text-xs text-secondary uppercase tracking-wide">{{ info.label }}</p>
                <p class="text-gray-600 text-sm mt-0.5" v-html="info.value"></p>
              </div>
            </div>
          </div>
          <div class="bg-primary rounded-xl p-6 text-white text-center flex flex-col gap-3">
            <p class="font-heading font-bold text-sm uppercase tracking-widest">Need an immediate quote?</p>
            <RouterLink to="/quote" class="px-5 py-2.5 bg-white text-primary font-heading font-bold text-xs uppercase tracking-widest rounded-lg hover:bg-light-bg transition-colors">
              Get a Free Quote
            </RouterLink>
          </div>
        </aside>

      </div>
    </section>
  </main>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { supabase } from '@/lib/supabase.js'
import PageHero from '@/components/ui/PageHero.vue'

onMounted(() => { document.title = 'Contact Us | ManAndTruck Movers' })

const form = reactive({ name: '', email: '', phone: '', subject: '', message: '' })
const errors = reactive({})
const errorMsg  = ref('')
const successMsg = ref('')
const loading   = ref(false)

const contactInfo = [
  { iconKey: 'phone',    label: 'Phone',        value: '<a href="tel:+15551234567" class="text-secondary hover:text-primary transition-colors">(555) 123-4567</a>' },
  { iconKey: 'email',   label: 'Email',        value: '<a href="mailto:info@manandtruckmovers.com" class="text-secondary hover:text-primary transition-colors">info@manandtruckmovers.com</a>' },
  { iconKey: 'clock',   label: 'Hours',        value: 'Mon–Sat: 7am – 8pm<br/>Sunday: 9am – 5pm' },
  { iconKey: 'location', label: 'Service Area', value: 'Serving 4 locations across the metro area' },
]

function validate() {
  const e = {}
  if (!form.name.trim())    e.name    = true
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(form.email)) e.email = true
  if (!form.subject)        e.subject = true
  if (!form.message.trim()) e.message = true
  Object.assign(errors, e)
  return Object.keys(e).length === 0
}

async function submitContact() {
  errorMsg.value = ''
  successMsg.value = ''
  if (!validate()) { errorMsg.value = 'Please fill in all required fields.'; return }
  loading.value = true
  try {
    const { error } = await supabase.from('contact_messages').insert([{
      name: form.name.trim(), email: form.email.trim(),
      phone: form.phone.trim() || null, subject: form.subject, message: form.message.trim(),
    }])
    if (error) throw error
    successMsg.value = 'Message sent! We\'ll get back to you within 1 business day.'
    Object.assign(form, { name: '', email: '', phone: '', subject: '', message: '' })
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
.form-label { @apply block text-xs font-heading font-semibold uppercase tracking-wide text-gray-500 mb-1; }
.form-input  { @apply w-full px-4 py-2.5 text-sm border border-border rounded-lg focus:outline-none focus:ring-2 focus:ring-secondary/40 focus:border-secondary transition-all duration-200; }
</style>
