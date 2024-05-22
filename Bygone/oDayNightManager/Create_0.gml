hour=12;
milHour=12;
timeOfDay=11;
minute=0;
timeSpeed=60;
alarm[0]=timeSpeed;

darkness=0;
maxDarkness=0.7;
lightColor=c_black;
drawDaylight=false;

enum DAYPHASE{
	SUNRISE = 5.5,
	DAYTIME = 8,
	SUNSET = 18.5,
	NIGHTTIME = 21
}

function mergeNum(num1,num2,amt){
	var diff=num1-num2;
	return num1 - (diff*amt);
}