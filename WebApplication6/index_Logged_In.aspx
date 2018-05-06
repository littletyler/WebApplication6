 <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index_Logged_In.aspx.cs" Inherits="WebApplication6.index_Logged_In" %>

<html>

<head>
    <title>BLUE STEEL</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <meta property="og:type" content="website" />

    <link rel="stylesheet" type="text/css" href="css/reset.css">
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <link rel="stylesheet" type="text/css" href="css/colortip-1.0-jquery.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/10.0.0/css/bootstrap-slider.css" />
    <link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet" />
        <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCaIDPJncTpCdga4ABZcVCd5WJp08BHt48&libraries=geometry,places,maps"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/10.0.0/bootstrap-slider.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>



    <script type="text/javascript" src="js/map2.js"></script>
    <script type="text/javascript" src="js/colortip-1.0-jquery.js"></script>
    <script type="text/javascript" src="js/popup.js"></script>


    <!-- BOOTSTRAP BUILDER DEPENDENCIES -->
    <link href="http://wenzhixin.net.cn/p/bootstrap-table/src/bootstrap-table.css" rel="stylesheet" type="text/css" />
    <link href="http://cdn.kendostatic.com/2014.1.318/styles/kendo.common.min.css" rel="stylesheet" />
    <link href="http://cdn.kendostatic.com/2014.1.318/styles/kendo.bootstrap.min.css" rel="stylesheet" />
    <link href="http://protostrap.com/Assets/gv/css/gv.bootstrap-form.css" rel="stylesheet" type="text/css" />

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->


    <!--[if lt IE 9]>
		<script src="/js/html5shiv.min.js"></script>
	<![endif]-->
</head>
<!-- INITIAL CITY SELECTION -->
    <body>
     <form runat="server">
<div class="moving-zone">
    <div class="popup">
        <div class="popup-content">
            <div class="popup-text">
                Select a
				<b>city</b>!
				<br />
                <select id="activitySelector" onchange="if (this.selectedIndex) doSomething();" style="color: black; width: 143px;">
                    <option>Choose a city</option>
                    <script>
                        var myArray = new Array("Amarillo", "Arlington", "Austin", "Brownsville", "Carrollton", "Corpus Christi",
                            "Dallas",
                            "El Paso", "Fort Worth", "Frisco", "Garland", "Grand Prairie", "Houston", "Irving", "Killeen", "Laredo",
                            "Lubbock", "McAllen", "McKinney", "Mesquite", "Pasadena", "Plano", "San Antonio", "Waco");
                        for (i = 0; i < myArray.length; i++) {
                            document.write('<option id = "city" value="' + myArray[i] + '">' + myArray[i] + '</option>');
                        }
                    </script>
                </select>
            </div>
        </div>
    </div>
</div>


    <nav class="navbar navbar-default navbar-fixed-top" runat="server" id="theDiv" style="position: sticky; margin-bottom: 0;">
        <div class="container" runat="server">
           
                <ul class="nav navbar-nav">
                    <li>
                        <a data-toggle="modal" href="#myModal">Favorites</a>
                    </li>
                </ul>
                <ul class="nav navbar-right" style="display: -webkit-inline-box;" runat="server">
                    <li>
                    <li>
                        <input type="hidden" style="display: none;" value="USER_ID" /></li>
                    <li>
                        <asp:Button type="button" CssClass="btn btn-default navbar-btn" runat="server" Text="Sign Out" OnClick="SignOutClick1"></asp:Button>
                    </li>
                    <li>
                        <p class="navbar-text">
                            Signed in as <a href="#" class="navbar-link">
                                <asp:Label ID="username" runat="server" Text="Label"></asp:Label>
                            </a>
                        </p>
                        <p runat="server" id="userid" style="display:none;"></p>
                    </li>

                </ul>
            
        </div>
    </nav>


    <!-- SIDEBAR START -->
    <div id="control">
        <form method="get" id="chooseZip" style="display: none;">
            <div class="row text-center">
                <h3 style="color: cornflowerblue; margin-bottom: 0px;">Blue </h3>
                <h3 style="color: darkgray; margin-top: 0px;">Steel</h3>
            </div>
            <div class="row text-center" style="margin-left: 0; margin-right: 0;">
                <input type="text" id="latitude" readonly hidden="yes" />
                <input type="text" id="longitude" readonly hidden="yes" />
            </div>
            <hr />
            <div class="row text-center">
                <a title="Tooltip" style="padding-right: 6%;">Filter</a>
                <input id="toggle-event" type="checkbox" data-toggle="toggle">
                <!--	<div id="console-event"></div> -->
                <script>
                    $(function () {
                        $('#toggle-event').change(function () {
                            $('#console-event').html('Toggle: ' + $(this).prop('checked'))
                            console.log("TOGGLED")
                        })
                    })
                </script>
                <hr />
            </div>
            <input type="text" id="myInput" onkeyup="myFunction()" class="form-control" placeholder="Search..">
            <div style="height: auto; overflow-y: scroll; max-height: 250px;">
                <table class="table table-striped" id="myTable">
                    <thead>
                        <th>#</th>
                        <th>Category</th>
                    </thead>
                    <tbody id="type_holder" style="height: 200px; overflow-y: scroll;">
                        <!--- <div id="type_holder" style="height: 200px; overflow-y: scroll;"> -->
                        <!-- Dynamic Content -->
                        <!-- </div> -->
                    </tbody>
                </table>
            </div>
         <%--   <script>
                var map;
                var infowindow;
                var autocomplete;
                var countryRestrict = {
                    'country': 'in'
                };
                var selectedTypes = [];
                $(document).ready(function () {
                    // type_holder
                    var types = ['airport', 'atm', 'bank', 'bus_station', 'cafe', 'campground', 'car_dealer', 'car_repair', 'church',
                        'city_hall', 'clothing_store', 'convenience_store', 'courthouse', 'dentist', 'doctor', 'embassy',
                        'fire_station', 'gym', 'hospital', 'insurance_agency', 'laundry', 'lawyer', 'library',
                        'local_government_office', 'park', 'pharmacy', 'physiotherapist', 'police', 'post_office', 'school',
                        'subway_station', 'synagogue', 'taxi_stand', 'train_station', 'transit_station', 'university'
                    ];
                    var html = '';

                    $.each(types, function (index, value) {
                        var name = value.replace(/_/g, " ");
                        html +=
                            '<tr><td><div class="form-check"><label class="form-check-label"><input type="checkbox" class="types form-check-input" value="' +
                            value + '" /></td><td>' + capitalizeFirstLetter(
                                name) + '</label></div></td></tr>';
                    });



                    $('#type_holder').html(html);
                });

                function capitalizeFirstLetter(string) {
                    return string.charAt(0).toUpperCase() + string.slice(1);
                }
                
                var element;
                function clickHand() {
                    var tog = document.getElementById("toggle-event");
                    var tog2 = document.getElementsByClassName("toggle btn btn-default off");
                    tog2.classList.remove(3);
                    console.log(tog2.classList);
                    document.getElementById("toggle-event").classList.remove("off");
                    document.getElementById("toggle-event").classList.add("on");
                }

                function renderMap() {
                   
                    

                    // Get the user defined values
                    var address = document.getElementById("activitySelector").value + ", Texas"
                    var radius = 10000;

                    // get the selected type
                    selectedTypes = [];
                    $('.types').each(function () {
                        if ($(this).is(':checked')) {
                            selectedTypes.push($(this).val());
                        }
                    });

                    var geocoder = new google.maps.Geocoder();
                    var selLocLat = document.getElementById("latitude").value;
                    var selLocLng = document.getElementById("longitude").value;

                    geocoder.geocode({
                        'address': address
                    }, function (results, status) {
                        if (status === 'OK') {

                            selLocLat = results[0].geometry.location.lat();
                            selLocLng = results[0].geometry.location.lng();

                            var pyrmont = new google.maps.LatLng(selLocLat, selLocLng);

                            map = new google.maps.Map(document.getElementById('map-canvas'), {
                                center: pyrmont,
                                zoom: 11
                            });

                            var request = {
                                location: pyrmont,
                                radius: 15000,
                                types: ["atm"],
                                radius: radius,
                                types: selectedTypes
                            };

                            infowindow = new google.maps.InfoWindow();

                            var service = new google.maps.places.PlacesService(map);
                            service.nearbySearch(request, callback);
                        } else {
                            alert('Geocode was not successful for the following reason: ' + status);
                        }
                    });
                }

                function favorite(place) {
                    var id = place;
                    console.log("favorite added");

                }

                function createMarker(place, icon) {
                    var placeLoc = place.geometry.location;
                    var marker = new google.maps.Marker({
                        map: map,
                        position: place.geometry.location,
                        icon: {
                            url: icon,
                            scaledSize: new google.maps.Size(30, 30) // pixels
                        },
                        animation: google.maps.Animation.DROP
                    });

                    google.maps.event.addListener(marker, 'click', function () {
                        infowindow.setContent(place.name + '<br>' + place.vicinity + '<br><input style="display:none;" value=" ' +
                            place.place_id + '"></input>' + '<a href="#"><i class="glyphicon glyphicon-star-empty" style="color:grey;"></a>');
                        infowindow.open(map, this);
                    });
                }

                function callback(results, status) {
                    if (status == google.maps.places.PlacesServiceStatus.OK) {
                        for (var i = 0; i < results.length; i++) {
                            createMarker(results[i], results[i].icon);
                        }
                    }
                }

                var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
            </script>--%>
            <!-- TABLE SEARCH -->
            
            <script>
                function myFunction() {
                    // Declare variables 
                    var input, filter, table, tr, td, i;
                    input = document.getElementById("myInput");
                    filter = input.value.toUpperCase();
                    table = document.getElementById("myTable");
                    tr = table.getElementsByTagName("tr");

                    // Loop through all table rows, and hide those who don't match the search query
                    for (i = 0; i < tr.length; i++) {
                        td = tr[i].getElementsByTagName("td")[0];
                        if (td) {
                            if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                                tr[i].style.display = "";
                            } else {
                                tr[i].style.display = "none";
                            }
                        }
                    }
                }
            </script>
            <div class="row text-center" style="display: flex; padding-top: 15px;">
                <input type="button" class="btn-5 btn" value="Filter" id="submit" onclick="renderMap(); clickHand();" style="background-color: grey; margin-left: 10%; width: 80%;">
            </div>

            <div CLASS="text-center" style="color:cornflowerblue">
                <br />
                Select a <b>type</b>!
				<br />
                <select id="activitySelector6" class="form-control" style="color: black;">
                    <option class="text-center">Choose a criteria</option>
                    <script>
                        var myArray = new Array("Apartment", "House", "Duplex/Triplex", "Condo", "Flat", "Loft", "Townhouse", "Assisted Living");
                        for (i = 0; i < myArray.length; i++) {
                            document.write('<option id = "type" value="' + myArray[i] + '">' + myArray[i] + '</option>');
                        }

                    </script>
                </select>
                <br />
<%--                 Select a <b>price</b>!
                <input id="ex6" type="text" class="span2" value="" data-slider-min="50" data-slider-max="1000" data-slider-step="50" data-slider-value="[200,600]"
                    style="width: 80%;" />
                    <script>
                    // With JQuery
                    $("#ex6").slider({
                        formatter: function (value) {
                            return '$' + value;
                        },
                        tooltip_position: 'bottom',
                        tooltip_split: true,
                    });
                    // Without JQuery
                    var slider = new Slider('#ex6', {
                        formatter: function (value) {
                            return '$' + value;
                        },
                        tooltip_position: 'bottom',
                        tooltip_split: true
                        });
                        
                    </script>
                <br />
                <br />
                Select # of <b>bedrooms</b>!
				<br />
                <input id="ex8" type="text" class="span2" value="" data-slider-min="1" data-slider-max="5" data-slider-step="1" data-slider-value="[1,3]"
                    style="width: 80%;" />
                    <script>
                    // With JQuery
                    $("#ex8").slider({
                        formatter: function (value) {
                            return value;
                        },
                        tooltip_position: 'bottom',
                        tooltip_split: true,
                    });
                    // Without JQuery
                    var slider = new Slider('#ex8', {
                        formatter: function (value) {
                            return value;
                        },
                        tooltip_position: 'bottom',
                        tooltip_split: true
                    });
                    </script>
                <br />
                <br />
                Select # of <b>bathrooms</b>!
				<br />
                <input id="ex9" type="text" class="span2" value="" data-slider-min="1" data-slider-max="5" data-slider-step="1" data-slider-value="[1,3]"
                    style="width: 80%;" />
                    <script>
                    // With JQuery
                    $("#ex9").slider({
                        formatter: function (value) {
                            return value;
                        },
                        tooltip_position: 'bottom',
                        tooltip_split: true,
                    });
                    // Without JQuery
                    var slider = new Slider('#ex9', {
                        formatter: function (value) {
                            return value;
                        },
                        tooltip_position: 'bottom',
                        tooltip_split: true
                    });
                    </script>
                <br />--%>

                                  <script>


                var map;
                var infowindow;
                var autocomplete;
                var countryRestrict = {
                    'country': 'in'
                };
                var selectedTypes = [];
                $(document).ready(function () {
                    // type_holder
                    var types = ['airport', 'atm', 'bank', 'bus_station', 'cafe', 'campground', 'car_dealer', 'car_repair', 'church',
                        'city_hall', 'clothing_store', 'convenience_store', 'courthouse', 'dentist', 'doctor', 'embassy',
                        'fire_station', 'gym', 'hospital', 'insurance_agency', 'laundry', 'lawyer', 'library',
                        'local_government_office', 'park', 'pharmacy', 'physiotherapist', 'police', 'post_office', 'school',
                        'subway_station', 'synagogue', 'taxi_stand', 'train_station', 'transit_station', 'university'
                    ];
                    var html = '';

                    $.each(types, function (index, value) {
                        var name = value.replace(/_/g, " ");
                        html +=
                            '<tr><td><div class="form-check"><label class="form-check-label"><input type="checkbox" class="types form-check-input" value="' +
                            value + '" /></td><td>' + capitalizeFirstLetter(
                                name) + '</label></div></td></tr>';
                    });



                    $('#type_holder').html(html);
                });

                function capitalizeFirstLetter(string) {
                    return string.charAt(0).toUpperCase() + string.slice(1);
                }
                
                var element;
                function clickHand() {
                    var tog = document.getElementById("toggle-event");
                    var tog2 = document.getElementsByClassName("toggle btn btn-default off");
                    tog2.classList.remove(3);
                    console.log(tog2.classList);
                    document.getElementById("toggle-event").classList.remove("off");
                    document.getElementById("toggle-event").classList.add("on");
                }
$(document).ready(function() {

  if(window.location.href.indexOf('#myModal') != -1) {
      $('#myModal').modal('show');
  }

});
                function renderMap() {
                   
                    

                    // Get the user defined values
                    var address = document.getElementById("activitySelector").value + ", Texas"
                    var radius = 10000;

                    // get the selected type
                    selectedTypes = [];
                    $('.types').each(function () {
                        if ($(this).is(':checked')) {
                            selectedTypes.push($(this).val());
                        }
                    });

                    var geocoder = new google.maps.Geocoder();
                    var selLocLat = document.getElementById("latitude").value;
                    var selLocLng = document.getElementById("longitude").value;

                    geocoder.geocode({
                        'address': address
                    }, function (results, status) {
                        if (status === 'OK') {

                            selLocLat = results[0].geometry.location.lat();
                            selLocLng = results[0].geometry.location.lng();

                            var pyrmont = new google.maps.LatLng(selLocLat, selLocLng);

                            map = new google.maps.Map(document.getElementById('map-canvas'), {
                                center: pyrmont,
                                zoom: 11
                            });

                            var request = {
                                location: pyrmont,
                                radius: 15000,
                                types: ["atm"],
                                radius: radius,
                                types: selectedTypes
                            };

                            infowindow = new google.maps.InfoWindow();

                            var service = new google.maps.places.PlacesService(map);
                            service.nearbySearch(request, callback);
                        } else {
                            alert('Geocode was not successful for the following reason: ' + status);
                        }
                    });
                }

                function favorite(place) {
                    var id = place;
                    console.log("favorite added");

                }

                function createMarker(place, icon) {
                    var placeLoc = place.geometry.location;
                    var marker = new google.maps.Marker({
                        map: map,
                        position: place.geometry.location,
                        icon: {
                            url: icon,
                            scaledSize: new google.maps.Size(30, 30) // pixels
                        },
                        animation: google.maps.Animation.DROP
                    });
                    var userid = document.getElementById("userid").innerHTML;
                    google.maps.event.addListener(marker, 'click', function () {
                        infowindow.setContent(place.name + '<br><div id="t">' + place.vicinity + '</div><br><a href="/favorite.aspx?place=' + place.place_id + '&userid=' + userid +'"><i class="glyphicon glyphicon-star-empty" style="color:grey;">Add to Favorites<i class="glyphicon glyphicon-star-empty" style="color:grey;"></a>');
                        infowindow.open(map, this);
                        Session["PlaceID"] = place.place_id;
                        console.log(place.place_id);
                    });
                    
                }

                function callback(results, status) {
                    if (status == google.maps.places.PlacesServiceStatus.OK) {
                        for (var i = 0; i < results.length; i++) {
                            createMarker(results[i], results[i].icon);
                        }
                    }
                }

                var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
                                   </script>
                <br />
                <div id="selections" style="text-align:left;font-size:medium;">
                <p id="price"></p>
                <p id="bedroom"></p>
                <p id="bathroom"></p></div>
                <br />
                Select an <b>availability</b>!
				<br />
                <select id="activitySelector9" class="form-control" style="color: black;">
                    <option>Any availability</option>
                    <script>
                        var myArray = new Array("Within 30 Days", "Beyond 30 Days");
                        for (i = 0; i < myArray.length; i++) {
                            document.write('<option id = "city" value="' + myArray[i] + '">' + myArray[i] + '</option>');
                        }
                    </script>
                </select>
                <br />
                Select a <b>city</b>!
				<br />
                <select id="activitySelector10" class="form-control" onchange="if (this.selectedIndex) doSomething();" style="color: black;">
                    <option>Choose a city</option>
                    <script>
                        var myArray = new Array("Amarillo", "Arlington", "Austin", "Brownsville", "Carrollton", "Corpus Christi",
                            "Dallas",
                            "El Paso", "Fort Worth", "Frisco", "Garland", "Grand Prairie", "Houston", "Irving", "Killeen", "Laredo",
                            "Lubbock", "McAllen", "McKinney", "Mesquite", "San Antonio", "Waco");
                        for (i = 0; i < myArray.length; i++) {
                            document.write('<option id = "city" value="' + myArray[i] + '">' + myArray[i] + '</option>');
                        }
                    </script>
                </select>
                <br />
            </div>
        </form>

    </div>
    <!-- SIDEBAR END -->
    <!-- MODAL START -->
    <div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="myModalLabel">Reservation</h4>
                </div>

                <form action="" method="POST">
                    <div class="modal-body">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Date Réservation</label>
                                <input type="date" name="date_reservation" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Date Retour</label>
                                <input type="date" name="date_retour" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>E-mail</label>
                                <input type="email" name="email" class="form-control">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Tél :</label>
                                <input type="tel" name="phone" class="form-control">
                            </div>
                        </div>


                        <div class="col-md-6">
                            <div class="form-group">
                                <label>Confirmé ?</label>
                                Oui
								<input type="radio" name="confirm" class="form-control">
                                Non
								<input type="radio" name="confirm" class="form-control">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="reset" class="btn btn-danger" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">Save changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <!-- FAVORITE MODAL -->
    <div class="modal fade" id="myModal" runat="server">
        <div class="modal-dialog" style="width: auto; padding-left: 10%; padding-right: 10%;"
            runat="server">
            <div class="modal-content" runat="server">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title text-center">Favorites</h4>
                </div>
                <div class="modal-body text-center" runat="server">

                    <asp:PlaceHolder ID="placeholder2" runat="server"></asp:PlaceHolder>
                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- APPLICATION MODAL -->
    <div class="modal fade" id="appModal" runat="server">
        <div class="modal-dialog" style="width: auto; padding-left: 10%; padding-right: 10%;"
            runat="server">
            <div class="modal-content" runat="server">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title text-center">Application</h4>
                </div>
                <div class="modal-body text-center" runat="server">
                    <asp:PlaceHolder ID="main" runat="server"></asp:PlaceHolder>
                    <form action="#" onsubmit="alert('You will be contacted by email soon!');" id="formentry" class="form-horizontal" role="form" data-parsley-validate novalidate>
                        <div class="container-fluid shadow">
                            <div class="row">
                                <div id="valErr" class="row viewerror clearfix hidden">
                                    <div class="alert alert-danger">Oops! Seems there are some errors..</div>
                                </div>
                                <div id="valOk" class="row viewerror clearfix hidden">
                                    <div class="alert alert-success">You have successfully applied for the government assisted housing program. We will contact you via phone or email once the process is complete. </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-group brdbot">
                                            <h3>Address</h3>
                                            <div class="controls col-sm-9">

                                                <p id="field1" data-default-label="Header" data-default-is-header="true" data-control-type="header">addr</p>
                                                <span id="errId1" class="error"></span>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row" style="display: block;">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label class="control-label control-label-left col-sm-3" for="field2">Employer<span class="req"> *</span></label>
                                                    <div class="controls col-sm-9">

                                                        <asp:TextBox runat="server" ID="field2" type="text" class="form-control k-textbox" data-role="text" placeholder="If not employed, type N/A" required="required" data-parsley-errors-container="#errId2"></asp:TextBox><span id="errId2" class="error"></span>
                                                    </div>

                                                </div>
                                                <div class="form-group" style="display: block;">
                                                    <label class="control-label control-label-left col-sm-3" for="YearsWorked">Years Worked</label>
                                                    <div class="controls col-sm-9">

                                                        <span class="k-widget k-numerictextbox form-control" style=""><span class="k-numeric-wrap k-state-default">
                                                            <asp:TextBox runat="server" type="number" step="1" min="0" class="k-formatted-value form-control k-input" tabindex="0" aria-disabled="false" aria-readonly="false" ID="YearsWorkesd" name="YearsWorked" style="display: inline-block;" data-parsley-errors-container="#errId3"></asp:TextBox><input id="YearsWorked" value="" type="text" class="form-control k-input" data-role="numeric" data-format="integer" role="spinbutton" aria-valuenow="" aria-disabled="false" aria-readonly="false" data-error-container="#errfield7" name="YearsWorked" style="display: none;" data-default="0" data-parsley-errors-container="#errId3"><span class="k-select"><span unselectable="on" class="k-link"><span unselectable="on" class="k-icon k-i-arrow-n" title="Increase value">Increase value</span></span><span unselectable="on" class="k-link"><span unselectable="on" class="k-icon k-i-arrow-s" title="Decrease value">Decrease value</span></span></span></span></span><span id="errId3" class="error"></span>
                                                    </div>

                                                </div>
                                                <div class="form-group" rel="popover" data-trigger="hover" data-content="Employer's Phone" data-original-title="" style="display: block;">
                                                    <label class="control-label control-label-left col-sm-3" for="employerPhone">Phone</label>
                                                    <div class="controls col-sm-9">

                                                        <asp:TextBox runat="server" ID="employerPhone" type="number" class="form-control k-textbox" data-role="mask" data-mask="(999) 999-9999" placeholder="" name="employerPhone" data-parsley-errors-container="#errId4"></asp:TextBox><span id="errId4" class="error"></span>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group" style="display: block;">
                                                    <label class="control-label" for="field10">Family Members in Home<span class="req"> *</span></label>
                                                    <div class="controls">

                                                        <span class="k-widget k-numerictextbox form-control" style=""><span class="k-numeric-wrap k-state-default">
                                                            <asp:TextBox runat="server" TextMode="Number" ID="fam" step="1" min="0" class="k-formatted-value form-control k-input" tabindex="0" aria-disabled="false" aria-readonly="false" style="display: inline-block;" placeholder="Total family members, including yourself" data-parsley-errors-container="#errId5"></asp:TextBox><input id="field10" value="" type="text" class="form-control k-input" data-role="numeric" data-format="integer" role="spinbutton" aria-valuenow="" aria-disabled="false" aria-readonly="false" data-error-container="#errfield10" style="display: none;" data-parsley-max="12" required="required" data-parsley-errors-container="#errId5"><span class="k-select"><span unselectable="on" class="k-link"><span unselectable="on" class="k-icon k-i-arrow-n" title="Increase value">Increase value</span></span><span unselectable="on" class="k-link"><span unselectable="on" class="k-icon k-i-arrow-s" title="Decrease value">Decrease value</span></span></span></span></span><span id="errId5" class="error"></span>
                                                    </div>

                                                </div>
                                                <div class="form-group" style="display: block;">
                                                    <label class="control-label" for="AnnualIncome">Annual Income<span class="req"> *</span></label>
                                                    <div class="controls">

                                                        <span class="k-widget k-numerictextbox form-control" style=""><span class="k-numeric-wrap k-state-default">
                                                            <asp:TextBox runat="server" TextMode="Number" ID="income" step="1000" min="0" max="100000" class="k-formatted-value form-control k-input" tabindex="0" aria-disabled="false" aria-readonly="false" placeholder="" style="display: inline-block;" data-parsley-errors-container="#errId7"></asp:TextBox> </span></span> </div>

                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group" style="display: block;">
                                                    <label class="control-label" for="field11">Number of Dependents<span class="req"> *</span></label>
                                                    <div class="controls">

                                                        <span class="k-widget k-numerictextbox form-control" style=""><span class="k-numeric-wrap k-state-default">
                                                            <asp:TextBox ID="dep" runat="server" TextMode="Number" step="1" min="0" class="k-formatted-value form-control k-input" tabindex="0" aria-disabled="false" aria-readonly="false" placeholder="" style="display: inline-block;" data-parsley-errors-container="#errId7"></asp:TextBox><input id="field11" value="" type="text" class="form-control k-input" data-role="numeric" data-format="integer" role="spinbutton" aria-valuenow="" aria-disabled="false" aria-readonly="false" data-error-container="#errfield11" style="display: none;" required="required" data-parsley-errors-container="#errId7"><span class="k-select"><span unselectable="on" class="k-link"><span unselectable="on" class="k-icon k-i-arrow-n" title="Increase value">Increase value</span></span><span unselectable="on" class="k-link"><span unselectable="on" class="k-icon k-i-arrow-s" title="Decrease value">Decrease value</span></span></span></span></span><span id="errId7" class="error"></span>
                                                    </div>

                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label control-label-left col-sm-3">Pets<span class="req"> *</span></label>
                                                    <div class="controls col-sm-9">

                                                        <label class="checkbox col-md-6" for="checkbox14">
                                                            <input type="checkbox" value="Pets" id="checkbox14" name="field13" data-parsley-mincheck="1" data-parsley-maxcheck="1" required="required" data-parsley-errors-container="#errId8">Pets</label><label class="checkbox col-md-6"><input id="checkbox27" name="field13" type="checkbox" value="No Pets" required="required" data-parsley-errors-container="#errId8">No Pets</label><span id="errId8" class="error"></span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label control-label-left col-sm-3" for="field28">Pet Type</label>
                                                    <div class="controls col-sm-9">

                                                        <asp:TextBox runat="server" ID="field28" type="text" class="form-control k-textbox" data-role="text" placeholder="Dog, cat, 10-gal fishtank, etc. . ." data-parsley-errors-container="#errId9"></asp:TextBox><span id="errId9" class="error"></span>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group group-inline pull-right" style="display: inline-block;">
                                                    <asp:Button runat="server" OnClick="Application_Button_Click"  id="button50" type="button" class="btn btn-primary" Text="Submit Application"></asp:Button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>


                            </div>
                        </div>
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>


    <!-- MODAL END -->

    <!-- an empty div for the map -->
    <div id="map-canvas"></div>
    <script>
         function doSomething() {
            var y = document.getElementById("chooseZip");
            y.style.display = "block"

            
            var e = document.getElementById("activitySelector1");
            var value = e.options[e.selectedIndex].value;
            var text = e.options[e.selectedIndex].text;
            var s = document.getElementById("activitySelector6");
            s.value = text;

            var f = document.getElementById("activitySelector3");
            var valuef = f.options[f.selectedIndex].value;
            var textf = f.options[f.selectedIndex].text;
            var d = document.getElementById("activitySelector9");
            d.value = textf;

            var r = document.getElementById("activitySelector");
            var valuer = r.options[r.selectedIndex].value;
            var textr = r.options[r.selectedIndex].text;
            var w = document.getElementById("activitySelector10");
            w.value = textr;

            

           
            var h1 = document.getElementById("ex3");
            document.getElementById("price").innerHTML = "Price Range: $" + h1.value[0] + h1.value[1] + h1.value[2] + ".00 to $" + h1.value[4] + h1.value[5] + h1.value[6] + ".00";
            var h2 = document.getElementById("ex4");
            document.getElementById("bedroom").innerHTML = "Bedroom Range: " + h2.value[0] + " to " + h2.value[2] + " bedrooms";
            var h3 = document.getElementById("ex5");
            document.getElementById("bathroom").innerHTML = "Bathroom Range: " + h3.value[0] + " to " + h3.value[2] + " bathrooms";
            
        };


    </script>
</form>
</body>


        <!--- BOOTSTRAP BUILDER DEPENDENCIES-->
    <script src="http://wenzhixin.net.cn/p/bootstrap-table/src/bootstrap-table.js" type="text/javascript"></script>
    <script src="http://protostrap.com/Assets/inputmask/js/jquery.inputmask.js" type="text/javascript"></script>
    <script src="http://cdn.kendostatic.com/2014.1.318/js/kendo.all.min.js"></script>
    <script src="http://protostrap.com/Assets/parsely/parsley.extend.js" type="text/javascript"></script>
    <script src="http://protostrap.com/Assets/parsely/2.0/parsley.js" type="text/javascript"></script>
    <script src="http://protostrap.com/Assets/download.js" type="text/javascript"></script>
    <script src="http://protostrap.com/Assets/protostrap.js" type="text/javascript"></script>


</html>
