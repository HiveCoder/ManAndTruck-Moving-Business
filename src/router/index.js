import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '@/views/HomeView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  scrollBehavior(to, _from, savedPosition) {
    if (savedPosition) return savedPosition
    if (to.hash)       return { el: to.hash, behavior: 'smooth' }
    return { top: 0, behavior: 'smooth' }
  },
  routes: [
    { path: '/',                name: 'home',           component: HomeView },
    { path: '/services',        name: 'services',       component: () => import('@/views/ServicesView.vue') },
    { path: '/services/:slug',  name: 'service-detail', component: () => import('@/views/ServiceDetailView.vue') },
    { path: '/about',           name: 'about',          component: () => import('@/views/AboutView.vue') },
    { path: '/locations',       name: 'locations',      component: () => import('@/views/LocationsView.vue') },
    { path: '/reviews',         name: 'reviews',        component: () => import('@/views/ReviewsView.vue') },
    { path: '/blog',            name: 'blog',           component: () => import('@/views/BlogView.vue') },
    { path: '/blog/:slug',      name: 'blog-post',      component: () => import('@/views/BlogPostView.vue') },
    { path: '/contact',         name: 'contact',        component: () => import('@/views/ContactView.vue') },
    { path: '/quote',           name: 'quote',          component: () => import('@/views/QuoteView.vue') },
    { path: '/privacy',         name: 'privacy',        component: () => import('@/views/PrivacyView.vue') },
    { path: '/terms',           name: 'terms',          component: () => import('@/views/TermsView.vue') },
    { path: '/accessibility',   name: 'accessibility',  component: () => import('@/views/AccessibilityView.vue') },
    { path: '/admin/quotes',    name: 'admin-quotes',   component: () => import('@/views/AdminQuotesView.vue') },
    { path: '/:pathMatch(.*)*', name: 'not-found',      component: () => import('@/views/NotFoundView.vue') },
  ],
})

export default router
