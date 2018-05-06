$(function () {
  function start() {
    var coords = [];
    var address = document.getElementById("activitySelector").addEventListener("change", addActivityItem, false);
  }

  function showResult(result) {
    console.log("Latitude:" + result.geometry.location.lat())
    console.log("Longitude:" + result.geometry.location.lng())
    document.getElementById('latitude').value = result.geometry.location.lat();
    document.getElementById('longitude').value = result.geometry.location.lng();
    var latitude = result.geometry.location.lat();
    var longitude = result.geometry.location.lng();
    coords = [latitude, longitude];
    console.log(coords)

    map = new google.maps.Map(document.getElementById('map-canvas'), {
      center: new google.maps.LatLng(latitude, longitude),
      zoom: 12,
      //   mapTypeIds: ['roadmap', 'satellite', 'hybrid', 'terrain',
      //                 'styled_map']
      mapTypeId: google.maps.MapTypeId.ROADMAP,
    });
    var infoWindow = new google.maps.InfoWindow({
      map: map
    });
    gogo()
    gogo1()
  }

  function getLatitudeLongitude(callback, address) {
    // If adress is not supplied, use default value 'Ferrol, Galicia, Spain'
    address = document.getElementById("activitySelector").value + ", Texas"
    // Initialize the Geocoder
    geocoder = new google.maps.Geocoder();
    if (geocoder) {
      geocoder.geocode({
        'address': address
      }, function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          callback(results[0]);
        }
      });
    }
  }


  function addActivityItem() {
    var full = document.getElementById("activitySelector").value + ", Texas"
    getLatitudeLongitude(showResult, full)
  }
  window.addEventListener("load", start, false);

  var mapOptions = {
    zoom: 12,
    center: new google.maps.LatLng(53.3478, -6.2597),
    panControl: false,
    panControlOptions: {
      position: google.maps.ControlPosition.BOTTOM_LEFT
    },
    zoomControl: true,
    zoomControlOptions: {
      style: google.maps.ZoomControlStyle.LARGE,
      position: google.maps.ControlPosition.RIGHT_CENTER
    },
    scaleControl: false

  };



  //Adding infowindow option
  infowindow = new google.maps.InfoWindow({
    content: "holding..."
  });

  function gogo() {

    var marketId = []; //returned from the API
    var allLatlng = []; //returned from the API
    var allMarkers = []; //returned from the API
    var marketName = []; //returned from the API
    var infowindow = null;
    var pos;
    var userCords;
    var tempMarkerHolder = [];
    var latitude = document.getElementById('latitude').value
    var longitude = document.getElementById('longitude').value


    var accessURL = "http://search.ams.usda.gov/farmersmarkets/v1/data.svc/locSearch?lat=" + latitude + "&lng=" + longitude;

    $.ajax({
      type: "GET",
      contentType: "application/json; charset=utf-8",
      url: accessURL,
      dataType: 'jsonp',
      success: function (data) {

        $.each(data.results, function (i, val) {
          marketId.push(val.id);
          marketName.push(val.marketname);
        });

        //console.log(marketName);

        var counter = 0;
        //Now, use the id to get detailed info
        $.each(marketId, function (k, v) {
          $.ajax({
            type: "GET",
            contentType: "application/json; charset=utf-8",
            // submit a get request to the restful service mktDetail.
            url: "http://search.ams.usda.gov/farmersmarkets/v1/data.svc/mktDetail?id=" + v,
            dataType: 'jsonp',
            success: function (data) {

              for (var key in data) {

                var results = data[key];

                //console.log(results);

                //The API returns a link to Google maps containing lat and long. This pulls it apart.
                var googleLink = results['GoogleLink'];
                var latLong = decodeURIComponent(googleLink.substring(googleLink.indexOf("=") + 1, googleLink.lastIndexOf("(")));

                var split = latLong.split(',');

                //covert values to floats, to play nice with .LatLng() below.
                var latitude = parseFloat(split[0]);
                var longitude = parseFloat(split[1]);

                //set the markers.	  
                myLatlng = new google.maps.LatLng(latitude, longitude);

                allMarkers = new google.maps.Marker({
                  position: myLatlng,
                  map: map,
                  title: marketName[counter],
                  html: '<div class="markerPop">' +
                    '<h1>' + marketName[counter].substring(4) + '</h1>' + //substring removes distance from title
                    '<h3>' + results['Address'] + '</h3>' +
                    '<p>' + results['Products'].split(';') + '</p>' +
                    '<p>' + results['Schedule'] + '</p>' +
                    '</div>'
                });

                //put all lat long in array
                allLatlng.push(myLatlng);
                //Put the marketrs in an array
                tempMarkerHolder.push(allMarkers);
                counter++;
              };

              google.maps.event.addListener(allMarkers, 'click', function () {
                infowindow.setContent(this.html);
                infowindow.open(map, this);
              });


              //  Make an array of the LatLng's of the markers you want to show
              //  Create a new viewpoint bound
              var bounds = new google.maps.LatLngBounds();
              //  Go through each...
              for (var i = 0, LtLgLen = allLatlng.length; i < LtLgLen; i++) {
                //  And increase the bounds to take this point
                bounds.extend(allLatlng[i]);
              }
              //  Fit these bounds to the map
              //     map.fitBounds (bounds);


            }
          });
        }); //end .each
      }
    });
  }

  function gogo1() {

    var quarter = []; //returned from the API
    var allLatlng = []; //returned from the API
    var allMarkers = []; //returned from the API
    var marketName = []; //returned from the API
    var latitude = document.getElementById('latitude').value
    var longitude = document.getElementById('longitude').value


    var accessURL = "https://api.spatial.ai/neighborhood/point/social_score?lat=" + latitude + "&lng=" + longitude + "&apikey=08qVgavpISw7BD9TPEC8Pmj8kmXmrN2D";

    $.ajax({
      type: "GET",
      url: accessURL,
      success: function (data) {
        console.log(data.results);
        console.log(data)

      }
    });
  }




});