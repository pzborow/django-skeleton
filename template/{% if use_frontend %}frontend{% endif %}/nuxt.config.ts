// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: true },
  modules: ['@nuxt/ui'],
  css: ['~/assets/css/tailwind.css'],
  ssr: true,
  // serwer deweloperski Vite przepuszcza tylko localhost, a przez nginx przychodzi Host: nginx
  vite: { server: { allowedHosts: ['nginx'] } }
})
