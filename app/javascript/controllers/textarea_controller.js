import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["textarea"]

  connect() {
    this.textareaTargets.forEach((textarea) => {
      this.initializeTextarea(textarea);
      textarea.addEventListener("input", () => this.adjustHeight(textarea));
    });
  }

  initializeTextarea(textarea) {
    textarea.style.height = 'auto';
    let scrollHeight = textarea.scrollHeight;
    textarea.style.height = scrollHeight + 'px';
  }

  adjustHeight(textarea) {
    textarea.style.height = 'auto';
    let scrollHeight = textarea.scrollHeight;
    textarea.style.height = scrollHeight + 'px';
  }
}