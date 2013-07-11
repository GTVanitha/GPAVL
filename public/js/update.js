function update() { 	
	var rno = localStorage.getItem('rno');//get value from local storage
	//var watch_id = '';    // ID of the geolocation
	var tracking_data = []; // Array containing GPS position objects

	// Start tracking the User
	var watch_id = navigator.geolocation.watchPosition(
	// Success
	function(position){
		var lat = position.coords.latitude;
		var lon = position.coords.longitude;
		var utime = position.timestamp;

		$("#lat").html(lat);
		$("#long").html(lon);
		$('#utime').html(utime);
		$.ajax({
        	        type: "POST",
                	url: "/update",
	                data: 'vid='+rno+'&lat='+lat+'&lon='+lon+'&utime='+utime,
	        });

	},

// Error
	function(error){
		console.log(error);
       	 },
// Settings
        { frequency: 3000, enableHighAccuracy: true });

	//stop tracking gps value
	$("#terminate").on('click', function() {
		navigator.geolocation.clearWatch(watch_id);
		alert("Tracking stopped");
		var url = "/";
        	$(location).attr('href',url);
		
	});
}
