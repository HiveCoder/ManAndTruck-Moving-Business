<template>
  <main>
    <HeroSection />
    <TrustBadges />
    <WhyUsSection />
    <FeaturesSection />
    <ServicesSection />
    <DefinitionSection />
    <BlogSection />
    <CtaStrip />
  </main>
</template>

<script setup>
import { onMounted } from 'vue'
import HeroSection      from '@/components/home/HeroSection.vue'
import TrustBadges      from '@/components/home/TrustBadges.vue'
import WhyUsSection     from '@/components/home/WhyUsSection.vue'
import FeaturesSection  from '@/components/home/FeaturesSection.vue'
import ServicesSection  from '@/components/home/ServicesSection.vue'
import DefinitionSection from '@/components/home/DefinitionSection.vue'
import BlogSection      from '@/components/home/BlogSection.vue'
import CtaStrip         from '@/components/home/CtaStrip.vue'

onMounted(() => { document.title = 'ManAndTruck Movers | Professional Moving Services' })
</script>
