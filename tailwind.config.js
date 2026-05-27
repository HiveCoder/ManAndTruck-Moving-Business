/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{vue,js,ts}'],
  theme: {
    extend: {
      colors: {
        primary: { DEFAULT: '#1d3557', dark: '#122640' },
        secondary: { DEFAULT: '#2a9d8f' },
        accent: '#94e4da',
        'light-bg': '#edf9f7',
        'mid-bg': '#c9ede9',
        cta: '#e63946',
        border: '#aeddd8',
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
