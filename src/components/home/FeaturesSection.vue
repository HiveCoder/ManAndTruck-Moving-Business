<template>
  <section class="py-20 bg-white">
    <div class="max-w-[1280px] mx-auto px-6 flex flex-col gap-20">
      <div
        v-for="(block, i) in blocks"
        :key="block.title"
        :class="['grid grid-cols-1 lg:grid-cols-2 gap-12 items-center', i % 2 === 1 && 'lg:[&>*:first-child]:order-2']"
      >
        <!-- Visual -->
        <div class="rounded-2xl overflow-hidden shadow-card-lg aspect-[4/3] relative">
          <img :src="block.photo" :alt="block.visual" class="w-full h-full object-cover" loading="lazy" />
          <div class="absolute inset-0 bg-gradient-to-t from-primary/80 via-primary/30 to-transparent flex items-end p-8">
            <p class="text-white font-heading text-xl font-bold uppercase tracking-wide drop-shadow">{{ block.visual }}</p>
          </div>
        </div>

        <!-- Text -->
        <div class="flex flex-col gap-5">
          <p class="text-xs uppercase tracking-[0.2em] font-heading font-semibold text-secondary">{{ block.tag }}</p>
          <h2 class="font-heading text-3xl md:text-4xl font-bold text-primary uppercase tracking-wide leading-tight">{{ block.title }}</h2>
          <p class="text-gray-700 text-base leading-relaxed">{{ block.body }}</p>
          <ul class="flex flex-col gap-2">
            <li v-for="feat in block.features" :key="feat" class="flex items-start gap-3 text-sm text-gray-600">
              <span class="text-secondary text-base leading-5 shrink-0">✓</span>
              {{ feat }}
            </li>
          </ul>
          <div class="flex gap-4 mt-2">
            <RouterLink :to="block.cta.to" class="btn-primary">{{ block.cta.label }}</RouterLink>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup>
const blocks = [
  {
    tag: 'How We Work',
    title: 'Moving Starts With a Plan',
    body: 'We begin every job with a comprehensive consultation to understand your timeline, budget, and special requirements. Our experienced coordinators map out every detail so moving day is stress-free.',
    photo: 'https://images.unsplash.com/photo-1600518464441-9154a4dea21b?w=800&h=600&fit=crop&q=80',
    visual: 'Personalized Move Plan',
    features: [
      'Free in-home or virtual estimate',
      'Dedicated move coordinator assigned to your job',
      'Itemized quote — no surprises on moving day',
      'Flexible scheduling including weekends & evenings',
    ],
    cta: { to: '/quote', label: 'Get a Free Quote' },
  },
  {
    tag: 'Your Belongings, Protected',
    title: 'We Handle Every Item With Care',
    body: 'From the family heirloom to the big-screen TV, our trained crews treat every item as if it were their own. Professional packing, custom crating, and blanket-wrap protection on every move.',
    photo: 'https://images.unsplash.com/photo-1600725935160-f67ee4f6084a?w=800&h=600&fit=crop&q=80',
    visual: 'Professional Packing & Wrapping',
    features: [
      'Professional-grade packing materials included',
      'Custom crating for art, antiques & fragile items',
      'Full-value protection coverage available',
      'Trained crew members — not day labor',
    ],
    cta: { to: '/services/packing-services', label: 'Packing Services' },
  },
]
</script>

<style scoped>
.btn-primary {
  @apply inline-block px-6 py-3 bg-primary text-white font-heading font-bold text-sm uppercase tracking-wide rounded-lg hover:bg-primary-dark transition-colors duration-200;
}
</style>
