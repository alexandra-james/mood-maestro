import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

// Connects to data-controller="typed-js"
export default class extends Controller {
  connect() {
    new Typed(this.element, {
      strings: ["Create Spotify playlists", "Get songs for every mood"],
      typeSpeed: 50,
      backSpeed: 20,
      backDelay: 1000,
      startDelay: 0,
      loop: true
    })
  }
}
