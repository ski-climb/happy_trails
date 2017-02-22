
function addMap() { mapboxgl.accessToken = 'pk.eyJ1IjoibmJlMTA1IiwiYSI6ImNpemVrMTVqZDIxZmQzM3A5d3dycmt2dDQifQ.aFcLtyBqOJY3-V-4B-9MKg';
  var map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/outdoors-v9',
    center: [-105.339, 40.008],
    zoom: 10
  });

  map.addControl(new mapboxgl.NavigationControl());
  map.addControl(new mapboxgl.GeolocateControl(), 'top-left');


  // for(var i = 0; i < issues.length; i++) {
  //
  //   var el = document.createElement('div');
  //   el.id = 'marker-' + issues[i].id;
  //   el.classList.add("marker");
  //   el.classList.add(issues[i].severity);
  //   el.classList.add(issues[i].current_user);
  //   el.classList.add(issues[i].resolved);
  //
  //   new mapboxgl.Marker(el, {offset:[-25, -25]})
  //     .setLngLat(issues[i].coordinates)
  //     .addTo(map);
  // }
};


$(document).ready(function() {
  if ($('.map-issues').length) {
    addMap();
  }
})
