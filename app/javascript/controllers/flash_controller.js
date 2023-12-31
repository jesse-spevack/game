import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ["message"]
  static classes = ["hidden"]

  connect() {
    setTimeout(() => {
      this.messageTarget.classList.add(this.hiddenClass);
    }, 4000);
  }
}
