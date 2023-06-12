import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dashboard"
export default class extends Controller {
  connect() {
  }
}

const findPlaylist = (query) => {
  fetch('/api/playlist/:id')
    .then(response => response.json())
    .then((data) => console.log("data", data))
};
