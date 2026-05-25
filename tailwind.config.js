/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{vue,js,ts}'],
  theme: {
    extend: {
      colors: {
        primary: { DEFAULT: '#1d3557', dark: '#122640' },
        secondary: { DEFAULT: '#457b9d' },
        accent: '#a8d8ea',
        'light-bg': '#eaf4f9',
        'mid-bg': '#dceef8',
        cta: '#e63946',
        border: '#d0dce8',
      },
      fontFamily: {
        heading: ['"Oswald"', 'sans-serif'],
        body: ['"Open Sans"', 'sans-serif'],
      },
      boxShadow: {
        card:    '0 4px 18px rgba(29,53,87,0.10)',
        'card-lg': '0 8px 32px rgba(29,53,87,0.16)',
      },
    },
  },
  plugins: [],
}
