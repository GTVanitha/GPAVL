function register() {
	var r_no = $("#rno").val();

	if(!r_no){
		alert("Route number must not be empty");
		return false;
	}
	
	$.ajax({
		type: "GET",
		url: "/register",
		data: 'vid='+r_no,
		datatype: "json",
		success: function(data){
			if(data.status == 'error'){
				alert(data.status+ "\n" + data.message);
				return false;
			}
			alert(data.message);
			window.localStorage.setItem('rno',r_no);
		}
	})
}	
