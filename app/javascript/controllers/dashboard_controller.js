import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
  static targets = ["details"]
  connect() {
  }

  playlist(event) {
    const playlistId = event.currentTarget.dataset.id
    console.log(playlistId)
    let url = `/api/playlist/${playlistId}`
    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then((data) => this.detailsTarget.outerHTML = data)
  };
}
