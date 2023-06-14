import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {

  static targets = ["bpm", "mode"]
  connect() {

  }

  display(event) {
    let value = event.target.value
    console.log(value)
    this.bpmTarget.innerText = `BPM ${value}`
  }

  mode(event) {
    let value = event.target.value
    if (value === "1") {
      this.modeTarget.innerText = `Mode: Major`
    } else {
      this.modeTarget.innerText = `Mode: Minor`
    }
  }
}
