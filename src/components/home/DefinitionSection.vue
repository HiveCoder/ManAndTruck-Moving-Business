<template>
  <section class="py-16 bg-primary text-white">
    <div class="max-w-[900px] mx-auto px-6 text-center flex flex-col gap-6">
      <h2 class="font-heading text-3xl md:text-4xl font-bold uppercase tracking-wide text-white">
        What Does <span class="text-accent">“Full-Service Moving”</span> Actually Mean?
      </h2>
      <p class="text-white/90 text-lg leading-relaxed">
        It means you don't lift a finger. Our crews handle every step — from carefully packing your kitchen to reassembling your bedroom furniture in your new home. We bring the truck, the materials, and the manpower. You just walk in the door.
      </p>
      <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mt-4">
        <div v-for="step in steps" :key="step.label"
          class="bg-white/10 backdrop-blur-sm border border-white/20 rounded-xl p-5 flex flex-col items-center gap-2 text-center">
          <div class="w-10 h-10 rounded-full bg-white/20 flex items-center justify-center text-white shrink-0">
            <svg v-if="step.icon === 'phone'" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 6.75c0 8.284 6.716 15 15 15h2.25a2.25 2.25 0 002.25-2.25v-1.372c0-.516-.351-.966-.852-1.091l-4.423-1.106c-.44-.11-.902.055-1.173.417l-.97 1.293c-.282.376-.769.542-1.21.38a12.035 12.035 0 01-7.143-7.143c-.162-.441.004-.928.38-1.21l1.293-.97c.363-.271.527-.734.417-1.173L6.963 3.102a1.125 1.125 0 00-1.091-.852H4.5A2.25 2.25 0 002.25 4.5v2.25z" />
            </svg>
            <svg v-else-if="step.icon === 'boxes'" class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" d="M20.25 7.5l-.625 10.632a2.25 2.25 0 01-2.247 2.118H6.622a2.25 2.25 0 01-2.247-2.118L3.75 7.5M10 11.25h4M3.375 7.5h17.25c.621 0 1.125-.504 1.125-1.125v-1.5c0-.621-.504-1.125-1.125-1.125H3.375c-.621 0-1.125.504-1.125 1.125v1.5c0 .621.504 1.125 1.125 1.125z" />
            </svg>
            <svg v-else class="w-5 h-5" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 12l8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25" />
            </svg>
          </div>
          <p class="font-heading font-bold text-sm uppercase tracking-wide text-white">{{ step.label }}</p>
          <p class="text-white/85 text-xs leading-relaxed">{{ step.desc }}</p>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
const steps = [
  { icon: 'phone', label: 'Book Your Move',    desc: 'Call, chat, or fill out our quick form to get a free estimate in minutes.' },
  { icon: 'boxes', label: 'We Pack & Load',    desc: 'Our crew arrives on time, packs, wraps, and loads with care.' },
  { icon: 'home',  label: 'Settle Right In',   desc: 'We unload, place every item, and you\'re at home from day one.' },
]
</script>
