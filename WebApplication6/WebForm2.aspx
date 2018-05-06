f<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="WebApplication6.WebForm2" MaintainScrollPositionOnPostBack="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

	<title>BLUE STEEL</title>

	<meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
	<meta charset="utf-8"/>
	<meta property="og:type" content="website" />

	<link rel="stylesheet" type="text/css" href="css/reset.css"/>
	<link rel="stylesheet" type="text/css" href="css/style.css"/>
	<link rel="stylesheet" type="text/css" href="css/colortip-1.0-jquery.css"/>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" /><%--  integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	    crossorigin="anonymous">--%>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/10.0.0/bootstrap-slider.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-slider/10.0.0/css/bootstrap-slider.css" />

	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCaIDPJncTpCdga4ABZcVCd5WJp08BHt48&libraries=geometry,places,maps"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"<%-- integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
	    crossorigin="anonymous"--%>></script>
	<script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js"></script>
	<!-- <script language="javascript" type="text/javascript" src="js/map2.js"></script> -->
	<script type="text/javascript" src="js/colortip-1.0-jquery.js"></script>
	<script type="text/javascript" src="js/popup.js"></script>
	<!--[if lt IE 9]>
		<script src="/js/html5shiv.min.js"></script>
	<![endif]-->
	<script>
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
			// DEFAULT LOAD
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


				var accessURL = "http://search.ams.usda.gov/farmersmarkets/v1/data.svc/locSearch?lat=" + latitude + "&lng=" +
					longitude;
				var canaryURL = "https://api.housecanary.com/v2/zip/affordability_ts_forecast"

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
										var latLong = decodeURIComponent(googleLink.substring(googleLink.indexOf("=") + 1, googleLink.lastIndexOf(
											"(")));
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

									// google.maps.event.addListener(allMarkers, 'click', function () {
									// 	infowindow.setContent(this.html);
									// 	infowindow.open(map, this);
									// });


									//  Make an array of the LatLng's of the markers you want to show
									//  Create a new viewpoint bound

									//var bounds = new google.maps.LatLngBounds();

                                    //  Go through each...

                                    //for (var i = 0, LtLgLen = allLatlng.length; i < LtLgLen; i++) {

                                    //  And increase the bounds to take this point

                                    // bounds.extend(allLatlng[i]);

                                    //}

                                    //  Fit these bounds to the map

                                    //     map.fitBounds (bounds);


								}
							});
						}); //end .each
					}
				});
			}

			// SOCIAL SCORE
			function gogo1() {

				var quarter = []; //returned from the API
				var allLatlng = []; //returned from the API
				var allMarkers = []; //returned from the API
				var marketName = []; //returned from the API
				var latitude = document.getElementById('latitude').value
				var longitude = document.getElementById('longitude').value


				var accessURL = "https://api.spatial.ai/neighborhood/point/social_score?lat=" + latitude + "&lng=" + longitude +
					"&apikey=08qVgavpISw7BD9TPEC8Pmj8kmXmrN2D";
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
	</script>

</head>
<!-- INITIAL CITY SELECTION -->
<div class="moving-zone">
	<div class="popup">
		<div class="popup-content">
			<div class="popup-text">
				Select a
				<b>city</b>
				<br/>
				<select id="activitySelector" onchange="if (this.selectedIndex) doSomething();" style="color:black;">
					<option>Choose a city</option>
					<script>
						var myArray = new Array("Amarillo", "Arlington", "Austin", "Brownsville", "Carrollton", "Corpus Christi",
							"Dallas", "El Paso", "Fort Worth", "Frisco", "Garland", "Grand Prairie", "Houston", "Irving", "Killeen",
							"Laredo", "Lubbock", "McAllen", "McKinney", "Mesquite", "Pasadena", "Plano", "San Antonio", "Waco");
						for (i = 0; i < myArray.length; i++) {
							//document.write('<option id = "city" value="' + myArray[i] + '">' + myArray[i] + '</option>');
							document.getElementById("activitySelector").innerHTML += ('<option id = "city" value="' + myArray[i] + '">' +
								myArray[i] + '</option>');
						}
					</script>
				</select>
			</div>
		</div>
	</div>
</div>

<body>
	<!-- HEADER -->
	<nav class="navbar navbar-default navbar-fixed-top" style="position:sticky;margin-bottom: 0;">
		<div class="container">
			<ul class="nav navbar-nav">
				<li>
					<a data-toggle="modal" href="#myModal">Favorites</a>
				</li>
			</ul>
			<ul class="nav navbar-right"><li>
            <input type="hidden" style="display:none;" value="USER_ID"/></li>
				<li><button type="button" class="btn btn-default navbar-btn">Sign Out</button></li>

				<li><p class="navbar-text">Signed in as 
					<a href="#" class="navbar-link">Steve Nolan</a>
				</p></li>

			</ul>
		</div>
	</nav>

	<!-- SIDEBAR START -->
	<div id="control" width:20%;>
		<form method="get" id="chooseZip" style="display:none;">
			<div class="row text-center">
				<h3 style="color:cornflowerblue;margin-bottom:0px;">Blue </h3>
				<h3 style="color:darkgray;margin-top:0px;">Steel</h3>
			</div>
			<hr />
			<div class="row text-center">
				<p id="cityLabel" style="font-size:18px;">Current City: </p>
				<button class="btn-xs btn-warning">Change</button>
				<button class="btn-xs btn-danger" data-toggle="modal" data-target="#basicModal3">Filter</button>
			</div>
			<hr />
			<div class="row text-center" style="margin-left:0;margin-right:0;">
				<a title="Tooltip">Crime</a>
				<div id="label" class="range">
					<input id="range" type="range" min=0 max=10 value=0 step="2" />
					<span>x</span>
				</div>
				<hr />
				<input type="text" id="latitude" readonly hidden="yes" />
				<input type="text" id="longitude" readonly hidden="yes" />
			</div>
			<div class="row text-center">
				<a title="Price per month">Price</a>
				<br>
				<input id="ex2" type="text" class="span2" value="" data-slider-min="50" data-slider-max="1000" data-slider-step="50" data-slider-value="[200,600]"
				    style="width:80%;" />
				<script>
					// With JQuery
					$("#ex2").slider({
						formatter: function (value) {
							return '$' + value;
						},
						tooltip_position: 'bottom',
						tooltip_split: true,
					});
					// Without JQuery
					var slider = new Slider('#ex2', {
						formatter: function (value) {
							return '$' + value;
						},
						tooltip_position: 'bottom',
						tooltip_split: true
					});
				</script>
			</div>

			<hr/>
			<div class="row text-center">
				<a title="Tooltip" style="padding-right:6%;">Toggle</a>
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
				<hr/>
			</div>
			<input type="text" id="myInput" onkeyup="myFunction()" class="form-control" placeholder="Search.." autocomplete="search">
			<div style="height: auto;
			overflow-y: scroll;
			max-height: 250px;">
				<table class="table table-striped" id="myTable">
					<thead>
						<th>#</th>
						<th>Category</th>
					</thead>
					<tbody id="type_holder" style="height: 125px; overflow-y: scroll;">
						<!--- <div id="type_holder" style="height: 200px; overflow-y: scroll;"> -->
						<!-- Dynamic Content -->
						<!-- </div> -->
					</tbody>
				</table>
			</div>
			<script src="https://www.gstatic.com/firebasejs/4.3.1/firebase.js"></script>
			<script>
				var map;
				var infowindow;
				var autocomplete;
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

				function renderMap() {
					// Get the user defined values
					var address = document.getElementById("activitySelector").value + ", Texas"
					var radius = 100000;

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

							var mapLoc = new google.maps.LatLng(selLocLat, selLocLng);

							map = new google.maps.Map(document.getElementById('map-canvas'), {
								center: mapLoc,
								zoom: 11
							});

							var request = {
								location: mapLoc,
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
				};

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
							place.place_id + '"></input>' +
							'<a href="#addtoFavorites&place=' + place.place_id + '&name=' + place.name +
							'"><i class="glyphicon glyphicon-star-empty" style="color:grey;"></i></a>');
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
			</script>
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
			<div class="row text-center" style="display: flex;padding-top:15px;">
				<input type="button" class="btn-5 btn" value="Filter" id="submit" onclick="renderMap();" style="background-color:grey;margin-left: 10%;
			width: 80%;">
			</div>

			<div class="row text-center force-to-bottom" style="display: inline-flex;width:15%;margin-left:2%;">
				<div class="col-lg">
					<input type="button" href="#" class="btn btn-md btn-success" data-toggle="modal" data-target="#basicModal" style="    width: -webkit-fill-available;
				margin-right: 2px;" value="Register"></input>
				</div>
				<div class="col">
					<input type="button" href="#" class="btn btn-md btn-primary" data-toggle="modal" data-target="#basicModal2" style="    width: -webkit-fill-available;
				margin-right: 2px;" value="Login"></input>
				</div>
			</div>
		</form>

	</div>
	<!-- SIDEBAR END -->

	<div id="map-canvas"></div>

	<!-- MODAL START -->
	<div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel">Registration</h4>
				</div>

				<form action="" method="POST">
					<div class="modal-body" style="padding-bottom: 0px;padding: 0;">
						<div class="col-md-6">
							<div class="form-group">
								<label>First Name</label>
								<input type="text" name="first_name" class="form-control" required>
							</div>
							<div class="form-group">
								<label>Last Name</label>
								<input type="text" name="last_name" class="form-control" required>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label>Telephone :</label>
								<input type="tel" name="phone" class="form-control" required>
							</div>
							<div class="form-group">
								<label>E-mail</label>
								<input type="email" name="email" class="form-control" required>
							</div>
						</div>

						<div class="text-center" style="padding-left: 10%; padding-right: 10%;">
							<div class="form-group">
								<label>Password</label>
								<input type="password" name="first_name" class="form-control" required>
							</div>
							<div class="form-group">
								<label>Confirm Password</label>
								<input type="password" name="last_name" class="form-control" required>
							</div>
							<div class="form-group">
								<button type="reset" class="btn btn-danger" data-dismiss="modal">Close</button>
								<button type="submit" class="btn btn-primary">Register</button>
							</div>
						</div>

					</div>
					<div class="modal-footer">

					</div>
				</form>
			</div>
		</div>
	</div>

	<div class="modal fade" id="basicModal2" tabindex="-1" role="dialog" aria-labelledby="basicModal2" aria-hidden="true" runat="server">
		<div class="modal-dialog" runat="server">
			<div class="modal-content" runat="server">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
					<h4 class="modal-title">Log In</h4>
				</div>
                <div class="modal-body" runat="server">
                        <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label1" runat="server" Text="Username"></asp:Label>
&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="TextBox1" runat="server" TextMode="Password"></asp:TextBox>
        </div>
        <p>
            <asp:Label ID="Label2" runat="server" Text="Password"></asp:Label>
&nbsp;&nbsp;&nbsp;
            <asp:TextBox ID="TextBox2" runat="server" TextMode="Password"></asp:TextBox>
        </p>
                             <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Log In" Width="202px" />
                            
                                   <asp:Label ID="Label3" runat="server" Text="Label" Visible="true"></asp:Label>                      
                           
        <br />
        <br />

    </form>
                </div>
			</div>
		</div>
        
	</div>

    <!-- FAVORITE MODAL -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">Modal title</h4>
				</div>
				<div class="modal-body text-center">
					<table class="table">
						<thead>
							<tr>
								<th scope="col">#</th>
								<th scope="col">Address</th>
								<th scope="col">XXX</th>
								<th scope="col">Apply</th>
								<th scope="col">Remove</th>
							</tr>
						</thead>
						<tbody class="table text-center">
							<tr>
								<th scop="row">1</th>
								<td>2</td>
								<td>2</td>
								<td>
									<button class="btn btn-primary">Apply</button>
								</td>
								<td>
									<button class="glyphicon glyphicon-remove-sign btn" style="color:red;"></button>
								</td>
							</tr>
							<tr>
								<th scop="row">2</th>
								<td>3</td>
								<td>3</td>
								<td>
									<button class="btn btn-primary">Apply</button>
								</td>
								<td>
										<button class="glyphicon glyphicon-remove-sign btn" style="color:red;"></button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	<!-- MODAL END -->

	<script>
		function doSomething() {
			var y = document.getElementById("chooseZip");
			y.style.display = "block"
			document.getElementById("cityLabel").textContent = document.getElementById("activitySelector").value + ", Texas";
		};
	</script>

</body>
<script src="js/script.js"></script>
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
        </html>
<%--    <title></title>
</head>
<body>

</body>
</html>--%>


