import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
  connect() {
  }

  playlist(event) {
    const playlistId = event.currentTarget.dataset.id
    console.log(playlistId)
    let url = `/api/playlist/${playlistId}`
    fetch(url)
      .then(response => response.json())
      .then((data) => console.log("playlist-details", data))
  };
}
