var darkLvls, colors, pStart, pEnd;

if(timeOfDay>DAYPHASE.SUNRISE and timeOfDay<=DAYPHASE.DAYTIME){ //sunrise
	darkLvls = [maxDarkness, 0.2];
	colors = [merge_color(c_black,c_navy,0.4), c_orange]
	pStart=DAYPHASE.SUNRISE;
	pEnd=DAYPHASE.DAYTIME;
}else if(timeOfDay>DAYPHASE.DAYTIME and timeOfDay<=DAYPHASE.SUNSET){ //day
	darkLvls = [0.2,0,0,0,0,0.2];
	colors = [c_orange,c_orange,c_white,c_white,c_orange,c_orange];
	pStart=DAYPHASE.DAYTIME;
	pEnd=DAYPHASE.SUNSET;
}else if(timeOfDay>DAYPHASE.SUNSET and timeOfDay<=DAYPHASE.NIGHTTIME){ //sunset
	darkLvls = [0.2,maxDarkness];
	colors = [c_orange,merge_color(c_black,c_navy,0.4)];
	pStart=DAYPHASE.SUNSET;
	pEnd=DAYPHASE.NIGHTTIME;
}else{ //nighttime
	darkLvls = [maxDarkness];
	colors = [merge_color(c_black,c_navy,0.4)];
	pStart=DAYPHASE.NIGHTTIME;
	pEnd=DAYPHASE.SUNRISE;
}

//colors
if(pStart==DAYPHASE.NIGHTTIME){
	lightColor=colors[0];
}else{
	var cc= ((timeOfDay-pStart)/(pEnd-pStart))*(array_length(colors)-1);
	var c1 = colors[floor(cc)];
	var c2 = colors[ceil(cc)];
	lightColor=merge_color(c1,c2,cc-floor(cc));
}

//darkness
if(pStart==DAYPHASE.NIGHTTIME){
	darkness=darkLvls[0];
}else{
	var dd= ((timeOfDay-pStart)/(pEnd-pStart))*(array_length(darkLvls)-1);
	var d1 = darkLvls[floor(dd)];
	var d2 = darkLvls[ceil(dd)];
	darkness=mergeNum(d1,d2,dd-floor(dd));
}

timeOfDay+=1/60/timeSpeed-0.0000001;