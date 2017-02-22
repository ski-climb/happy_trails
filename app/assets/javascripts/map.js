$(document).ready(function() {
  if ($('.map-issues').length) {
    addMap();
  }
})

function addMap() { mapboxgl.accessToken = 'pk.eyJ1IjoibmJlMTA1IiwiYSI6ImNpemVrMTVqZDIxZmQzM3A5d3dycmt2dDQifQ.aFcLtyBqOJY3-V-4B-9MKg';
  var map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/outdoors-v9',
    center: [-105.339, 40.008],
    zoom: 10
  });

  map.addControl(new mapboxgl.NavigationControl());
  map.addControl(new mapboxgl.GeolocateControl(), 'top-left');
  // latitude:     39.983567,
  // longitude:    -105.291288
  //   "coordinates": [-105.291288, 39.983567]


  // var marker = new mapboxgl.Marker()
  //   .setLngLat([-105.284937, 39.981358])
  //   .addTo(map);


var el = document.createElement('div');
el.id = 'marker';


new mapboxgl.Marker(el, {offset:[-25, -25]})
    .setLngLat([-105.291288, 39.983567])
    .addTo(map);


};


