
if(minute<59){
	minute++;
}else{
	minute=0;
	if(hour<12){
		hour++;
	}else hour=1;
	
	if(milHour<23){
		milHour++;
		timeOfDay=milHour
	}else{
		milHour=0;
		timeOfDay=0;
	}
	
}

alarm[0]=timeSpeed;

