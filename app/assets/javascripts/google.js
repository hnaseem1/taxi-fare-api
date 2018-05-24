

// locationButton and locationButton2 are responsible for get the user location (LAT & LONG) from the browser -> make a request to GOOGLE to convert the position in a address -> fill in the information in the respective field

var locationButton = document.getElementById('get-location-data')
locationButton.addEventListener('click', function() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
        myposition = position
       var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
        };

      response = $.ajax({
        url: 'https://maps.googleapis.com/maps/api/geocode/json?latlng='+pos.lat+', '+pos.lng+'&key=AIzaSyDxHtxeT7TcaPqz8y2tPRWbqIwB9ROdZfk',
        method: 'GET',
        dataType: 'json'
      }).done(function(data) {
        document.getElementById('autocomplete').value = response.responseJSON.results[0].formatted_address
      })
    })
  }
})

var locationButton2 = document.getElementById('get-location-data2')
locationButton2.addEventListener('click', function() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
        myposition = position
       var pos = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };

      response = $.ajax({
        url: 'https://maps.googleapis.com/maps/api/geocode/json?latlng='+pos.lat+', '+pos.lng+'&key=AIzaSyDxHtxeT7TcaPqz8y2tPRWbqIwB9ROdZfk',
        method: 'GET',
        dataType: 'json'
      }).done(function(data) {
        document.getElementById('autocomplete2').value = response.responseJSON.results[0].formatted_address
      })
    })
  }
})

//==============================================================================================================


// the function below is responsible for the autocomplete feature for both address input fields

var autocomplete, autocomplete2;

function initAutocomplete() {

  autocomplete2 = new google.maps.places.Autocomplete(
      /** @type {!HTMLInputElement} */(document.getElementById('autocomplete2')),
      {types: ['geocode']});

  autocomplete = new google.maps.places.Autocomplete(
      /** @type {!HTMLInputElement} */(document.getElementById('autocomplete')),
      {types: ['geocode']});
      initMap()
}

//==============================================================================================================

// the function below is responsible for display the map and update the route when the address changes

function initMap() {
  var directionsService = new google.maps.DirectionsService;
  var directionsDisplay = new google.maps.DirectionsRenderer;
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 9,
    center: {lat: 43.7151, lng: -79.4362}
  });
  directionsDisplay.setMap(map);

  var onChangeHandler = function() {
    calculateAndDisplayRoute(directionsService, directionsDisplay);

  };
  document.getElementById('autocomplete').addEventListener('change', onChangeHandler);
  document.getElementById('autocomplete2').addEventListener('change', onChangeHandler);
  onChangeHandler()
  document.getElementById('map').style.display = ''

}

function calculateAndDisplayRoute(directionsService, directionsDisplay) {
  directionsService.route({
    origin: document.getElementById('autocomplete').value,
    destination: document.getElementById('autocomplete2').value,
    travelMode: 'DRIVING'
  }, function(response, status) {
    if (status === 'OK') {
      directionsDisplay.setDirections(response);
    }
  });
}
//==============================================================================================================
