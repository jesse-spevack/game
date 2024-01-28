import { Controller } from "@hotwired/stimulus"
import confetti from "https://cdn.skypack.dev/canvas-confetti"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    confetti();
  }
}
