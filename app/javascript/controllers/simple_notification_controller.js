import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["body"]
  // static classes = ["hidden"]

  connect() {
    console.log("Hello from simple_notification_controller.js")
  }

  openNotification() {
    this.bodyTarget.classList.remove("transition", "ease-in", "duration-100", "opacity-0");
    this.bodyTarget.classList.add("transform", "ease-out", "duration-300", "transition", "translate-y-0", "opacity-100", "sm:translate-x-0");
  }

  closeNotification() {
    console.log("Hello from closeNotification()")
    this.bodyTarget.classList.remove("transform", "ease-out", "duration-300", "transition", "translate-y-0", "opacity-100", "sm:translate-x-0");
    this.bodyTarget.classList.add("transition", "ease-in", "duration-100", "opacity-0");
  }
}
