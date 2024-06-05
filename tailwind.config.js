module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
        animation: {
            "focus-in-expand": "focus-in-expand 1.5s cubic-bezier(0.250, 0.460, 0.450, 0.940)   both",
            "slide-out-right": "slide-out-right 0.5s cubic-bezier(0.550, 0.085, 0.680, 0.530) 3s both"
        },
        keyframes: {
            "focus-in-expand": {
                "0%": {
                    "letter-spacing": "-.5em",
                    filter: "blur(12px)",
                    opacity: "0"
                },
                to: {
                    filter: "blur(0)",
                    opacity: "1"
                }
            },
            "slide-out-right": {
              "0%": {
                  transform: "translateX(0)",
                  opacity: "1"
              },
              to: {
                  transform: "translateX(1000px)",
                  opacity: "0"
              }
          }
        },
    }
  },
  plugins: [
    require('daisyui')
  ],
  daisyui: {
    themes: ["night",],
  },

}
