document.addEventListener('turbo:load', function() {
  particlesJS.load('particles-js', './particlesjs.json', function() {
    console.log('callback - particles.js config loaded');
  });
});