import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hidden-input"
export default class extends Controller {
  static targets = ["display", "field", "submit"]
  static values = {
    response: { type: String, default: "" },
  }

  connect() {
    this.displayTarget.innerText = this.responseValue
  }

  handleKeyboardInput(event) {
    if (/^\d$/.test(event.key)) {
      this.updateDisplay(parseInt(event.key), "append");
    } else if (event.key === "Backspace") {
      this.updateDisplay(null, "delete");
    } else if (event.key === "Enter") {
      this.submitTarget.click();
    }
  }

  updateDisplay(userInput, operation) {
    if (operation === "append") {
      this.appendInput(this.responseValue, userInput);
    } else if (operation === "delete") {
      this.responseValue = this.responseValue.slice(0, -1);
      this.displayTarget.innerText = this.responseValue;
      this.fieldTarget.value = this.responseValue;
    }

    if (this.responseValue.length === 0) {
      this.submitTarget.disabled = true;
    } else {
      this.submitTarget.disabled = false;
    }

  }

  keyPress(event) {
    const userInput = event.target.innerText;
    const operation = event.target.dataset.operation;
  
    this.updateDisplay(userInput, operation);
  }

  appendInput(currentResponse, userInput) {
    this.responseValue = currentResponse + userInput 
    this.displayTarget.innerText = this.responseValue 
    this.fieldTarget.value = this.responseValue 
  }
}
