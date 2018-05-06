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

            console.log(marketName);
        }
    });
}