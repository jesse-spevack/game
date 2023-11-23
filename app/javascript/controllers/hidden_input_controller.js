import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hidden-input"
export default class extends Controller {
  static targets = ["display", "field"]
  static values = {
    response: { type: String, default: "" },
  }

  connect() {
    this.displayTarget.innerText = this.responseValue
  }

  keyPress(event) {
    const userInput = event.target.innerText;
    const operation = event.target.dataset.operation;
  
    if (operation === "append") {
      this.appendInput(this.responseValue, userInput);
    } else if (operation === "delete") {
      this.responseValue = this.responseValue.slice(0, -1);
      this.displayTarget.innerText = this.responseValue;
      this.fieldTarget.value = this.responseValue;
    } else if (operation === "submit") {

    }
  }

  appendInput(currentResponse, userInput) {
    this.responseValue = currentResponse + userInput 
    this.displayTarget.innerText = this.responseValue 
    this.fieldTarget.value = this.responseValue 
  }
}
