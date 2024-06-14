import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "modal" ]

  connect() {
    this.clickTimestamp = localStorage.getItem('clickTimestamp') || 0;
  }

  checkClick(event) {
    if (window.innerWidth <= 640) {
      console.log('スマホの場合は制限かけない');
      return;
    }
    const now = new Date().getTime();

    if (this.clickTimestamp && (now - this.clickTimestamp) < 5000) {
      event.stopPropagation();
      event.preventDefault();
      this.showModal();
    } else {
      this.clickTimestamp = now;
      localStorage.setItem('clickTimestamp', this.clickTimestamp);
    }
  }


  showModal() {
    this.modalTarget.style.display = 'flex';
    setTimeout(() => this.hideModal(), 3000);
  }

  hideModal() {
    this.modalTarget.style.display = 'none';
  }
}