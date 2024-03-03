import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="otp"
export default class extends Controller {
  static values = { index: Number }
  static targets = ["input", "submit", "firstInput", "error"]

  connect() {
    addEventListener("paste", (event) => this.handlePasteEvent(event));
    addEventListener("keydown", (event) => {
      if (event.key === "Backspace" || event.key === "Delete") {
        this.handleBackspace(event)
      }
    });
  }

  handlePasteEvent(event) {
    event.preventDefault();
    let paste = (event.clipboardData || window.clipboardData).getData("text");
    if (paste.length === 6 && paste.match(/^\d+$/)) {
      this.hideError()

      this.setDisplayValue(paste);
      this.inputTarget.value = paste 
      this.submit()
    } else {
      this.showError()
    }
  }

  setDisplayValue(displayValue) {
      let target = this.firstInputTarget

      displayValue.split("").forEach((value, index) => {
        console.log(value)
        target.value = value
        if (index === 5) {
          target.focus()
        } else {
          target = target.nextElementSibling
        }
      })

  }

  keyInput(event) {
    const inputValue = event.target.value;
    const isDigit = /^\d$/.test(inputValue);

    if (isDigit) {
      this.appendValue(inputValue)

      if (this.inputTarget.value.length === 6) {
        console.log("submit")
        this.submit()
      } else {
        event.target.nextElementSibling.focus()
      }
    } else {
      event.target.value = "";
    }
  }

  handleBackspace(event) {
    console.log(event)
    this.deleteValue();
    let target = event.target;
    if(target.value === "") {
      let previousInput = this.inputTarget.value.length === 2 ? target.previousElementSibling.previousElementSibling : target.previousElementSibling;
      previousInput.value = "";
      previousInput.focus();
    }
  }

  deleteValue() {
    this.inputTarget.value = this.inputTarget.value.slice(0, -1);
  }

  appendValue(value) {
    this.inputTarget.value += value;
  }

  showError() {
    this.errorTarget.classList.remove("hidden")
  }

  hideError() {
    this.errorTarget.classList.add("hidden")
  }

  submit() {
    this.submitTarget.click()
  }
}

// 123456