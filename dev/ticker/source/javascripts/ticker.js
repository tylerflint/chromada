//var on = true;
function clock()
{
	var currentTime = new Date();

	var weekdays = new Array("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday");
	var weekday = currentTime.getDay();

	var day = currentTime.getDate();
	day = (day < 10) ? day = "0" + day : day;

	var months = new Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
	var month = currentTime.getMonth();

	var year = currentTime.getFullYear();
	year += ''

	$('.weekday').html(weekdays[weekday]);
	$('.date').html(day + " " + months[month] + " " + (year.substr(2)));

	var hours = currentTime.getHours();
	hours = (hours > 12) ? hours - 12 : hours;
	hours = (hours == 0) ? hours = 1 : hours;

	var minutes = currentTime.getMinutes();
	minutes = (minutes < 10) ? minutes = "0" + minutes : minutes;
	
	//var seconds = currentTime.getSeconds();
	//seconds = (seconds < 10) ? seconds = "0" + seconds : seconds;
	
	/*
	if(on)
	{
		$('.time').html(hours + "<span style='position:absolute; top:0px; left:28px;'>:</span>" + minutes);
		on = false;
	}else{
		$('.time').html(hours + "<span style='position:absolute; top:0px; left:28px;'></span>" + minutes);
		on = true;
	}
	*/
	
	$('.time').html(hours + ":" + minutes);
	
	if(hours < 11){
		$('.indicator').html('am');
	}else{
		$('.indicator').html('pm');
	}
	
	$('.clock .wrapper').css({"left": ($('.clock').width() - $('.clock .wrapper').width())/2});
	$('.clock .wrapper').css({"top": ($('.clock').height() - $('.clock .wrapper').height())/2});

	$('.calendar .wrapper').css({"left": ($('.calendar').width() - $('.calendar .wrapper').width())/2});
	$('.calendar .wrapper').css({"top": ($('.calendar').height() - $('.calendar .wrapper').height())/2});
}

var Ticker = {
	init:function(){
		Ticker.setupWindow();  
	},
	
	minimize:function(){
		nativeWindow.minimize();  
	},
	
	move:function(){
		nativeWindow.startMove();  
	},
	
	quit:function(){
		var exitingEvent = new air.Event(air.Event.EXITING, false, true);  
		
		air.NativeApplication.nativeApplication.dispatchEvent(exitingEvent);  
		
		if (!exitingEvent.isDefaultPrevented()){  
			air.NativeApplication.nativeApplication.exit();  
		}  
	},
	
	setupWindow:function(){
		$('.minimize').bind('click', function(event){
			event.preventDefault();
			Ticker.minimize();
		});
		
		$('.close').bind('click', function(event){
			event.preventDefault();
			Ticker.quit();
		});
		
		$('.handle').bind('mousedown', function(event){
			event.preventDefault();
			Ticker.move();
		});
	}
};

function openExternalURL($href){
	var request = new air.URLRequest($href);
	try {
		air.navigateToURL(request);
	}catch(error){
		air.Introspector.Console.log(error);
	};
};