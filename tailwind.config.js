import { fontFamily } from "tailwindcss/defaultTheme";

/** @type {import('tailwindcss').Config} */
export default {
  darkMode: ["class"],
  content: ["./index.html", "./src/**/*.{js,jsx,ts,tsx}"],
  theme: {
    container: {
      center: true,
      padding: "2rem",
      screens: {
        "2xl": "1400px",
      },
    },
    extend: {
      fontFamily: {
        sans: ["Inter", ...fontFamily.sans],
      },
      colors: {
        border: "hsl(214, 32%, 91%)",
        input: "hsl(214, 32%, 91%)",
        ring: "hsl(240, 5%, 64%)",
        background: "hsl(0, 0%, 100%)",
        foreground: "hsl(222, 47%, 11%)",
        primary: {
          DEFAULT: "hsl(243, 75%, 59%)",
          foreground: "hsl(0, 0%, 100%)",
        },
        secondary: {
          DEFAULT: "hsl(240, 4.8%, 95.9%)",
          foreground: "hsl(222, 47%, 11%)",
        },
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
};
