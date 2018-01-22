
function preview(file) {  
	var prevDiv = document.getElementById('preview');  
	if (file.files && file.files[0]) {  
		var reader = new FileReader();  
		reader.onload = function(evt){  
			prevDiv.innerHTML = '<img src="' + evt.target.result + '" />';  
		}    
 		reader.readAsDataURL(file.files[0]);  
	} else {  
		prevDiv.innerHTML = '<div class="img" style="filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\'' + file.value + '\'"></div>';  
	}  
}
$(function() {
	$("#addCooper").on("click",function() {
		var html = '<div class="col-sm-12 mTop15 cooperChild">'
				+ '<div class="col-sm-8">'
				+ '<input class="form-control cooperName" type="text">'
				+ '</div>'
				+ '<div class="col-sm-4">'
				+ '<button type="button" class="btn btn-danger">删除</button>'
				+ '</div>' + '</div>';
		$(html).insertAfter($(this));
	});
	
	$("#addLink").on("click",function() {
		var html = '<div class="col-sm-12 mTop15 linkChild">'
				+ '<div class="col-sm-8">'
				+ '<input class="form-control linkName" type="text">'
				+ '</div>'
				+ '<div class="col-sm-4">'
				+ '<button type="button" class="btn btn-danger">删除</button>'
				+ '</div>' + '</div>';
		$(html).insertAfter($(this));
	});
	$("#cooperList").on("click", '.btn-danger', function() {
		var $this = $(this);
		$this.parent().parent().remove();
	});
	$("#linkList").on("click", '.btn-danger', function() {
		var $this = $(this);
		$this.parent().parent().remove();
	});
	
})