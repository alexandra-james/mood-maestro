import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {

  static targets = ["bpm"]
  connect() {

  }

  display(event) {
    let value = event.target.value
    console.log(value)
    this.bpmTarget.innerText = `BPM ${value}`
  }
}
