import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="confirm"
export default class extends Controller {
  confirm(event) {
    if(!confirm("このMUを作成しますか？")) {
      event.preventDefault();
    }
  }
}
