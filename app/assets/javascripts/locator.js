var map;
var latitude = 40;
var longitude = -105;

$(document).ready(function() {
  if ($('.map-locator').length) {
    addLocator();
  }
});

function addLocator() { 
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
    displayRoutes();
    submitLocation();

    // Holds mousedown state for events. if this
    // flag is active, we move the point on `mousemove`.
    var isDragging;

    // Is the cursor over a point? if this
    // flag is active, we listen for a mousedown event.
    var isCursorOverPoint;

    var coordinates = document.getElementById('coordinates');

    var canvas = map.getCanvasContainer();

    var geojson = {
        "type": "FeatureCollection",
        "features": [{
            "type": "Feature",
            "geometry": {
                "type": "Point",
                "coordinates": [-105.283016, 39.999696]
            }
        }]
    };

    function mouseDown() {
        if (!isCursorOverPoint) return;

        isDragging = true;

        // Set a cursor indicator
        canvas.style.cursor = 'grab';

        // Mouse events
        map.on('mousemove', onMove);
        map.once('mouseup', onUp);
    }

    function onMove(e) {
        if (!isDragging) return;
        var coords = e.lngLat;

        // Set a UI indicator for dragging.
        canvas.style.cursor = 'grabbing';

        // Update the Point feature in `geojson` coordinates
        // and call setData to the source layer `point` on it.
        geojson.features[0].geometry.coordinates = [coords.lng, coords.lat];
        map.getSource('point').setData(geojson);
    }

    function onUp(e) {
        if (!isDragging) return;
        var coords = e.lngLat;

        // Print the coordinates of where the point had
        // finished being dragged to on the map.
        coordinates.style.display = 'block';
        coordinates.innerHTML = 'Longitude: ' + coords.lng + '<br />Latitude: ' + coords.lat;
        canvas.style.cursor = '';

        // console.log(coords.lat)
        // console.log(coords.lat)

        // $('#issue-latitude').val(coords.lat + '');
        // $('#issue-longitude').val(coords.lng + '');

        isDragging = false;

        // Unbind mouse events
        map.off('mousemove', onMove);
    }

      console.log('hello');
    // map.on('load', function() {

        // Add a single point to the map
        map.addSource('point', {
            "type": "geojson",
            "data": geojson
        });

        map.addLayer({
            "id": "point",
            "type": "circle",
            "source": "point",
            "paint": {
                "circle-radius": 10,
                "circle-color": "#3887be"
            }
        });

        // If a feature is found on map movement,
        // set a flag to permit a mousedown events.
        map.on('mousemove', function(e) {
            var features = map.queryRenderedFeatures(e.point, { layers: ['point'] });

            // Change point and cursor style as a UI indicator
            // and set a flag to enable other mouse events.
            if (features.length) {
                map.setPaintProperty('point', 'circle-color', '#3bb2d0');
                canvas.style.cursor = 'move';
                isCursorOverPoint = true;
                map.dragPan.disable();
            } else {
                map.setPaintProperty('point', 'circle-color', '#3887be');
                canvas.style.cursor = '';
                isCursorOverPoint = false;
                map.dragPan.enable();
            }
        });

        // Set `true` to dispatch the event before other functions call it. This
        // is necessary for disabling the default map dragging behaviour.
        map.on('mousedown', mouseDown, true);
    // });
  });
};

function submitLocation() {
  $('#submit-location').on("click", function(event) {
    event.preventDefault();
    longitude = $('.coordinates').text().split(' ')[1].match(/(\d|\.|-)+/)[0];
    latitude = $('.coordinates').text().split(' ')[2];
    var issueId = $('#issue-id').data().issueId
    $.ajax({
      url: '/issues/' + issueId,
      type: 'PUT',
      data: "coordinates=" + latitude + ' ' + longitude
    });
  });
};
