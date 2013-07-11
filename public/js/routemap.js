function routemap() {
	var v_buses = JSON.parse(window.localStorage.getItem("buses"));//list of valid bus numbers
	var v_routeno = JSON.parse(window.localStorage.getItem("routeno"));//list of valid route numbers
	var v_routes = JSON.parse(window.localStorage.getItem("routes"));//list of valid routes

        $('#map_canvas').gmap('getCurrentPosition',function(position,status) {
        //client position get value from gps
		if ( status === 'OK' ) {
			var clientPosition = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
			$('#map_canvas').gmap({ 'zoom':14, 'center':clientPosition});
			$('#map_canvas').gmap('addMarker',{'position': clientPosition, 'icon':"images/male-2.png"}).click(function() {
				$('#map_canvas').gmap('openInfoWindow', {'content': 'your location', draggable:true}, this);
			});
		}
		else {
			alert("position error");
		}
	});

// get the vehicle position information from database for every 10 seconds

	setInterval(function () {
		for(var i = 0; i < v_buses.length; i++) {
			var id = v_buses[i];
			var bno=v_routeno[i];
			var route=v_routes[i];
	
			$.getJSON('/route/'+id+'/'+bno+'/'+route,function(data){
				if(data.status == 'ok'){
                       		//vehicle location 
					$.each( data.markers, function(i, marker) {
					$('#map_canvas').gmap('refresh');
					$('#map_canvas').gmap('addMarker', {
								'position': new google.maps.LatLng(marker.latitude, marker.longitude),
								'bounds': true,
								'icon':"images/bus2.png" })
							.click(function() {
								$('#map_canvas').gmap('openInfoWindow', { 'content': 'Bus no: '+data.bno+'<br>Route: '+data.route }, this);
							});
					});
				}
			});
		}
	},10000);
}
