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

var locationButton = document.getElementById('get-location-data2')
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
        document.getElementById('autocomplete2').value = response.responseJSON.results[0].formatted_address
      })
    })
  }
})

var placeSearch, autocomplete, autocomplete2;

function initAutocomplete() {
  // Create the autocomplete object, restricting the search to geographical
  // location types.

  autocomplete2 = new google.maps.places.Autocomplete(
      /** @type {!HTMLInputElement} */(document.getElementById('autocomplete2')),
      {types: ['geocode']});

  autocomplete = new google.maps.places.Autocomplete(
      /** @type {!HTMLInputElement} */(document.getElementById('autocomplete')),
      {types: ['geocode']});
}


function geolocate() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      var circle = new google.maps.Circle({
        center: geolocation,
        radius: position.coords.accuracy
      });
      autocomplete.setBounds(circle.getBounds());
    });
  }
}
