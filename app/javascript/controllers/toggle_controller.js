import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["hiddenField", "innerSwitch", "outerSwitch"]

  connect() {
    if(this.hiddenFieldTarget.value === "true") {
      this.toggleOn();
    } else {
      this.toggleOff();
    }
  }

  toggleOn() {
    this.outerSwitchTarget.classList.remove("bg-gray-200")
    this.innerSwitchTarget.classList.remove("translate-x-0")
    this.outerSwitchTarget.classList.add("bg-cyan-600")
    this.innerSwitchTarget.classList.add("translate-x-5")
  }

  toggleOff() {
    this.outerSwitchTarget.classList.remove("bg-cyan-600")
    this.innerSwitchTarget.classList.remove("translate-x-5")
    this.outerSwitchTarget.classList.add("bg-gray-200")
    this.innerSwitchTarget.classList.add("translate-x-0")
  }

  toggleInput() {
    if(this.hiddenFieldTarget.value === "true") {
      this.toggleOff();
      this.hiddenFieldTarget.value = "false"
    } else {
      this.toggleOn();
      this.hiddenFieldTarget.value = "true"
    }
  }
}
