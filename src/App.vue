<template>
  <AnnouncementBar />
  <AppHeader />
  <RouterView />
  <AppFooter />
  <BackToTop />
</template>

<script setup>
import AnnouncementBar from '@/components/layout/AnnouncementBar.vue'
import AppHeader      from '@/components/layout/AppHeader.vue'
import AppFooter      from '@/components/layout/AppFooter.vue'
import BackToTop      from '@/components/ui/BackToTop.vue'
</script>
