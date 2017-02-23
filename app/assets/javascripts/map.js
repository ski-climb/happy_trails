
var API = "http://pampered-trails.herokuapp.com"
var map;

$(document).ready(function() {
  if ($('.map-issues').length) {
    addMap();
  }
});

function getPoints() {
  console.log(map);
  return $.get({
    url: API + "/api/v1/issues"
  })
  .done(renderPoints)
  .fail(function(response) {
    console.log("fail");
  });
}

function renderPoints(issues) {
  for(var i = 0; i < issues.length; i++) {

    console.log(map + "cats");

    var el = document.createElement('div');
    el.id = 'marker-' + issues[i].id;
    el.classList.add("marker");
    el.classList.add(issues[i].severity);
    el.classList.add(issues[i].current_user);
    el.classList.add(issues[i].resolved);

    new mapboxgl.Marker(el, {offset:[-25, -25]})
      .setLngLat(issues[i].coordinates)
      .addTo(map);
  }
}

function addMap() { 
  mapboxgl.accessToken = 'pk.eyJ1IjoibmJlMTA1IiwiYSI6ImNpemVrMTVqZDIxZmQzM3A5d3dycmt2dDQifQ.aFcLtyBqOJY3-V-4B-9MKg';
  map = new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/mapbox/outdoors-v9',
    center: [-105.339, 40.008],
    zoom: 10
  });

  map.addControl(new mapboxgl.NavigationControl());
  map.addControl(new mapboxgl.GeolocateControl(), 'top-left');
  map.on('load', function () {
    addRoute();
    getPoints(); 
  });
};

function addRoute() {
  var points = polyline.decode("g`sqFt~y_SeB~FvO`U}LzM|FzHkVhV`SpWlG|Mh`@vCdI|CHbCxV~G|AzN`JnQb@dFjFvIPjDrAf@n@tL|_@Cj@~Of\\RU|dAhCr@e@xhAjElABpf@d[b@TbpCfUf@x@bF|NH");
  var route = points.map(function(val) {
    return [val[1], val[0]];
  });
  console.log(route);

   map.addLayer({
        "id": "route",
        "type": "line",
        "source": {
            "type": "geojson",
            "data": {
                "type": "Feature",
                "properties": {},
                "geometry": {
                    "type": "LineString",
                    "coordinates": route
                }
            }
        },
        "layout": {
            "line-join": "round",
            "line-cap": "round"
        },
        "paint": {
            "line-color": "#888",
            "line-width": 8
        }
    });
}
