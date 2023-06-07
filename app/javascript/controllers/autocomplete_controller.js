import { Controller } from "@hotwired/stimulus";
import TomSelect from "tom-select";

// Connects to data-controller="autocomplete"
export default class extends Controller {
  static targets = [ "artists" ]
  connect() {
    console.log("Autocomplete connected")
    this.tom= new TomSelect(this.artistsTarget)
  }
  artistsSearch() {
    console.log(this.artistsTarget.value)
    fetch(`/api/search/${this.artistsTarget.value}`, {headers:{'Content-Type': 'application/json'}})
  .then(data => data.json())
  .then(data => {
    console.log(data)
    this.tom.clearOptions()
    data.forEach((res) => {
      tom.addOption({value: res.name, text: res.name})
      console.log(res)
    })

  })
  }

}
