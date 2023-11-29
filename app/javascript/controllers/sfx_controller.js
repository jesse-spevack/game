import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sfx"
export default class extends Controller {
  static targets = ["sound"]
  static values = {
    correct: Boolean 
  }

  connect() {
    if (this.correctValue) {
      this.playCorrectSound();
    }
  }

  playCorrectSound() {
    try {
      const url = this.soundTarget.src;
      const audio = new Audio(url);
      audio.play();
    } catch (error) {
      console.error("Failed to play sound:", error);
    }
  }
}
