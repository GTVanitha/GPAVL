function routefinder() {
	var src = $("#source").val();
	var dst = $("#dest").val();

	if(!src) {
		alert("source field is empty");
		return false;
	}

	if (!dst) {
		alert("destination field is empty");
                return false;
        }

	if(src === dst) {
		alert("source and destination is same");
		return false;
	}
	
	$.ajax({
		type: "GET",
		url: "/findroute",
		data: 'src='+src+'&dst='+dst,
		datatype: "json",
		success: function(data){
			if(data.status == 'ok'){
				var src_len=data.srcstop.length;
				var dst_len=data.dststop.length;
				var bus_nos=[];//array contain valid bus no's
				var route_no=[];//array contain valid route no's
				var routes=[];//array contain valid routes

				if(src_len && dst_len){
					for(var i=0; i<src_len; i++) {
					 for (var j=0; j<dst_len; j++) {
						if(data.srcstop[i].dupno == data.dststop[j].dupno) {
							$('#shadow').show();
							$('#routes').show();
							$('#routes').append("<p>Bus No: "+data.srcstop[i].rno+"  Route: "+data.srcstop[i].route+"</p>");
							bus_nos.push(data.srcstop[i].dupno);
							route_no.push(data.srcstop[i].rno);
							routes.push(data.srcstop[i].route);
						}	
				 	 }
					}	
					window.localStorage.setItem( "buses", JSON.stringify(bus_nos) );
					window.localStorage.setItem( "routeno", JSON.stringify(route_no) );
					window.localStorage.setItem( "routes", JSON.stringify(routes) );
				}
				else { 
					alert("Not a valid route");
					console.log("Not a valid route"); 
				}
			}
			else { 
				alert("Information not available");
				console.log("no item found");
			}
		}
	})
} 
