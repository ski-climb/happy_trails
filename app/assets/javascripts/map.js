var API = "https://pampered-trails.herokuapp.com"
var map;
var issues;
var personId;


$(document).ready(function() {
  if ($('.map-issues').length) {
    addMap();
  }
  if (document.cookie) {
    personId = document.cookie.match(/\d+/)[0];
  }
});

function getPoints() {
  return $.get({
    url: API + "/api/v1/issues"
  })
  .done(function(data) {
    issues = data;
    renderPoints(data)
  })
  .fail(function() {
    console.log("fail");
  });
}

function renderPoints(issues) {
  for(var i = 0; i < issues.length; i++) {

    var el = document.createElement('div');
    el.id = 'marker-' + issues[i].id;
    el.classList.add("pin");
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
    getPoints(); 
    togglePoints();
    displayRoutes();
    showIsssue();

  });
};

function togglePoints() {
  $("#toggles").change(function(event) {
    toggleByAttribute(event);
  });
};

function toggleByAttribute(visibleId) {
  var visibleId = event.target.id
  if (event.target.checked) {
    $(".pin").hide();
    if($(".pin").length){
      $("." + visibleId).show();
    }
  }
}

function displayRoutes() {
  return $.get({
    url: API + "/api/v1/users/" + personId + "/recent_routes"
  })
  .done(function(data) {
    for(var i = 0; i < data.length; i++){
      addRoute(i, data[i]);
    }
  })
  .fail(function() {
    console.log("fail");
  });
}

function addRoute(i, summaryPolyline) {
  var points = polyline.decode(summaryPolyline);
  var route = points.map(function(val) {
    return [val[1], val[0]];
  });

   map.addLayer({
        "id": "route-" + i,
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
            "line-color": '#FC4C02',
            "line-width": 3
        }
    });
};

function showIsssue() {
    $('#map').on("click", ".pin", function(event) {
      var id = this.id.match(/\d+/)[0];

      event.preventDefault();
      $.getScript(API + "/issues/" + id, function( data, textStatus, jqxhr) {
      });
    });
};
