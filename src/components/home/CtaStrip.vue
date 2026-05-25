<template>
  <section class="py-14 bg-cta">
    <div class="max-w-[1280px] mx-auto px-6 text-center flex flex-col items-center gap-6">
      <h2 class="font-heading text-3xl md:text-4xl font-bold text-white uppercase tracking-wide">
        Ready to Move? Let's Get Started.
      </h2>
      <p class="text-white/80 text-base max-w-xl">
        Join thousands of happy customers who trusted ManAndTruck with their move. Get your free quote today — no obligation.
      </p>
      <div class="flex flex-wrap justify-center gap-4">
        <RouterLink to="/quote"
          class="px-8 py-3.5 bg-white text-cta font-heading font-bold text-sm uppercase tracking-widest rounded-lg hover:bg-red-50 transition-all duration-200 shadow-lg">
          Get a Free Quote
        </RouterLink>
        <a href="tel:+15551234567"
          class="px-8 py-3.5 border-2 border-white text-white font-heading font-bold text-sm uppercase tracking-widest rounded-lg hover:bg-white hover:text-cta transition-all duration-200">
          Call (555) 123-4567
        </a>
      </div>
    </div>
  </section>
</template>
