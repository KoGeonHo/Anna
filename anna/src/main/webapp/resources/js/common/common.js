
$(function(){
	$("#menu-btn").click(function(){
		
		if($("#menu").css("left") != "0px"){
			
			$("#menu").css("left","0px");
			
		}else{
			
			$("#menu").css("left","100%");
			
		}
		
	});
	
	$(".main").mousemove(function(){
		NavSlideUp();
	});
});