import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="particles"
export default class extends Controller {
  connect() {
    particlesJS.load('particles-js', '/particlesjs-config.json', function() {
      console.log('コネクト時: particles.jsをロード');
    });
  }
}
