import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="increment"
export default class extends Controller {
  static targets = [ "display", "value" ]

  connect() {
    console.log("Hello, Stimulus!")
  }

  down(e) {
    e.preventDefault()
    let currentValue = parseInt(this.displayTarget.textContent)
    if (currentValue === 1) {
      return;
    } else {
      let newValue = currentValue - 1;
      this.displayTarget.textContent = newValue;
      this.valueTarget.value = newValue;
    }
  }

  up(e) {
    e.preventDefault()
    let max_level = 49;
    let currentValue = parseInt(this.displayTarget.textContent)
    if (currentValue === max_level) {
      return;
    } else {
      let newValue = currentValue + 1;
      this.displayTarget.textContent = newValue;
      this.valueTarget.value = newValue;
    }
  }
}
