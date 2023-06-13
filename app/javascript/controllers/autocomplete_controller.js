import { Controller } from "@hotwired/stimulus";
import TomSelect from "tom-select";

// Connects to data-controller="autocomplete"
export default class extends Controller {
  static targets = [ "artists", "songs", "genres", "one", "two", "button", "areset", "sreset" ];

  next() {
    this.oneTarget.classList.toggle("d-none");
    this.twoTarget.classList.toggle("d-none");


  }
  connect() {
    console.log("Autocomplete connected")
    const artistsTarget = this.artistsTarget;
    const songsTarget = this.songsTarget;
    const genresTarget = this.genresTarget;


    const search_artist = (item, escape) => { return `<div class="py-2 d-flex">
    <div class="icon me-3" data-action>
      <img class="img-fluid" src="${item.images[0].url}" />
    </div>
    <div>
      <div class="mb-1">
        <span class="h4">
          ${ escape(item.name) }
        </span>
      </div>
    </div>
  </div>`;
    }

    const search_song = (item, escape) => {
      console.log(item);
      return `<div class="py-2 d-flex">
    <div class="icon me-3">
      <img class="img-fluid" src="${item.album.images[0].url}" />
    </div>
    <div>
      <div class="mb-1">
        <span class="h4">
          ${ escape(item.name) }
        </span>
        <span class="text-muted">by ${ escape(item.artists[0].name) }</span>
      </div>
    </div>
  </div>`;
    }


    new TomSelect(this.artistsTarget,{
      valueField: 'id',
      labelField: 'name',
      searchField: 'name',

      // fetch remote data
      load: function(query, callback) {

        fetch(`/api/artist/${encodeURIComponent(query)}`, {headers:{'Content-Type': 'application/json'}})
          .then(response => response.json())
          .then(json => {
            callback(json);
          }).catch(()=>{
            callback();
          });

      },

      render: {
        option: function(item, escape) {
          return search_artist(item, escape)

        },
        item: function(item, escape) {
          return search_artist(item, escape)
        }
      },
    });


  // artistsSearch() {}




    new TomSelect(this.songsTarget,{
      valueField: 'id',
      labelField: 'name',
      searchField: 'name',
      // fetch remote data
      load: function(query, callback) {

        fetch(`/api/song/${encodeURIComponent(query)}`, {headers:{'Content-Type': 'application/json'}})
          .then(response => response.json())
          .then(json => {
            callback(json);
          }).catch(()=>{
            callback();
          });

      },

      render: {
        option: function(item, escape) {
          return search_song(item, escape)
        },
        item: function(item, escape) {
          return search_song(item, escape)
        }
      },
    });


  // songsSearch() {}




    new TomSelect(this.genresTarget,{
      maxItems: null,
      valueField: 'title',
      labelField: 'title',
      searchField: 'title',
      options: [
        "acoustic", "afrobeat", "alt-rock", "alternative", "ambient", "anime", "black-metal", "bluegrass", "blues",
        "bossanova", "brazil", "breakbeat", "british", "cantopop", "chicago-house", "children", "chill", "classical",
        "club", "comedy", "country", "dance", "dancehall", "death-metal", "deep-house", "detroit-techno", "disco",
        "disney", "drum-and-bass", "dub", "dubstep", "edm", "electro", "electronic", "emo", "folk", "forro", "french",
        "funk", "garage", "german", "gospel", "goth", "grindcore", "groove", "grunge", "guitar", "happy", "hard-rock",
        "hardcore", "hardstyle", "heavy-metal", "hip-hop", "holidays", "honky-tonk", "house", "idm", "indian", "indie",
        "indie-pop", "industrial", "iranian", "j-dance", "j-idol", "j-pop", "j-rock", "jazz", "k-pop", "kids", "latin",
        "latino", "malay", "mandopop", "metal", "metal-misc", "metalcore", "minimal-techno", "movies", "mpb", "new-age",
        "new-release", "opera", "pagode", "party", "philippines-opm", "piano", "pop", "pop-film", "post-dubstep", "power-pop",
        "progressive-house", "psych-rock", "punk", "punk-rock", "r-n-b", "rainy-day", "reggae", "reggaeton", "road-trip",
        "rock", "rock-n-roll", "rockabilly", "romance", "sad", "salsa", "samba", "sertanejo", "show-tunes", "singer-songwriter",
        "ska", "sleep", "songwriter", "soul", "soundtracks", "spanish", "study", "summer", "swedish", "synth-pop", "tango",
        "techno", "trance", "trip-hop", "turkish", "work-out", "world-music"].map((song) => {
            return {title: song}
        })
      ,
      create: false
    });

  }
}
