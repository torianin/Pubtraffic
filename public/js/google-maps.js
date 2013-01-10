var button = 0;
var toDelete = 0;
var map;
var allMarkers = [];
var infoWindow;


function check(button) 
{
toDelete = button.id;
}; 

function show() 
{
infoWindow.open(map,allMarkers[toDelete-1]);
}; 

function usun() 
{
allMarkers[toDelete-1].setVisible(false);
infoWindow.close();
$('#' + (toDelete)).remove();
}; 

function initialize() {

var mapOptions = {
  center: new google.maps.LatLng(51.106540, 17.038396),
  zoom: 13,
  mapTypeId: google.maps.MapTypeId.TERRAIN,
  disableDoubleClickZoom: true,
};
map = new google.maps.Map(document.getElementById("map_canvas"),
  mapOptions);

infoWindow = new google.maps.InfoWindow({
  content: "To tutaj"
});

google.maps.event.addListener(map, "dblclick", function(event) {
  var lat = event.latLng.lat();
  var lng = event.latLng.lng();
  var markerLatLng = new google.maps.LatLng(lat, lng);
  var marker = new google.maps.Marker({
	position: markerLatLng, 
	map: map, 
  });   
  allMarkers.push(marker);
  // populate yor box/field with lat, lng
  button = button + 1;
  $("#map ol").append($("<button id=\""+button+"\" value=\""+lat + "," + lng +"\" onclick=\"check(this)\"></button>").html(lat + "," + lng ));
  alert("Lat=" + lat + "; Lng=" + lng + button);
});
}