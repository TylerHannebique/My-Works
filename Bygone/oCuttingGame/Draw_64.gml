//UI
/*
draw_sprite_ext(sCuttingBoard,0,global.camw,global.camh-100,2,2,0,c_white,1);

draw_sprite_ext(sCookingMeter,0,global.camw,sliderY,2,2,0,c_white,1);

//move sliders
if(moveSlider){
	sliderX=min(sliderX+sliderSpeed,sprite_get_width(sCookingMeter)*2-12);
	if(moveKnife) knifeX=min(knifeX+sliderSpeed/2.5,sprite_get_width(sCookingMeter)-12);
	if(sliderX>=sprite_get_width(sCookingMeter)*2-12){
		sliderX=0;	
		moveSlider=false;
		moveKnife=false;
		resetKnife=true; //move back to start
		swipe=true; //keep knife in down position
		swipeSpeed=0;
		moveInCarrot=false;
		alarm[6]=30;
	}
}
if(moveInvisSlider){
	invisibleSliderX=min(invisibleSliderX+sliderSpeed,sprite_get_width(sCookingMeter)*2-12);

	if(invisibleSliderX>=sprite_get_width(sCookingMeter)*2-12){
		invisibleSliderX=0;	
		moveInvisSlider=false;
	}
}

//draw stuff
with(oCuttingBeat){
	draw_self();
	//draw_text(x,y-100,x);
}

draw_sprite_ext(sCombatSlider,0,global.camw-sprite_get_width(sCookingMeter)+6+sliderX,sliderY,2,2,0,c_white,1);

//carrot
	
for(var i=0; i<array_length(carrotCuts); i++){
	
	//actual carrot
	//draw_sprite_part_ext(sCarrot,0,_startX,0,_endX-_startX,60,global.camw+carrotX-sprite_get_xoffset(sCarrot)*2,global.camh-100-sprite_get_yoffset(sCarrot)*2,2,2,c_white,1);
	draw_sprite_part_ext(sCarrot,0,carrotCuts[i].startX,0,carrotCuts[i].endX-carrotCuts[i].startX,60,
		global.camw+carrotCuts[i].startX-(sprite_get_xoffset(sCarrot)*2)+(carrotCuts[i].startX)+carrotCuts[i].xOffset-((array_length(carrotCuts)-i)*4)+carrotX,
		global.camh-100-(sprite_get_yoffset(sCarrot)*2)+carrotCuts[i].yOffset,
		2,2,c_white,1);
	
	//cuts
	if(i!=array_length(carrotCuts)){
		draw_sprite_part_ext(sCarrot,2,carrotCuts[i].startX,0,2,60,
			global.camw+carrotCuts[i].startX-(sprite_get_xoffset(sCarrot)*2)+(carrotCuts[i].startX)+carrotCuts[i].xOffset-((array_length(carrotCuts)-i)*4)+carrotX,
			global.camh-100-(sprite_get_yoffset(sCarrot)*2)+carrotCuts[i].yOffset,
			2,2,c_white,1);
	}
	
	//if(i!=0){
		//draw_sprite_part_ext(sCarrot,2,carrotCuts[i].startX,0,2,60,
		///	global.camw+carrotCuts[i].startX-(sprite_get_xoffset(sCarrot)*2)+(carrotCuts[i].startX)+carrotCuts[i].xOffset-((array_length(carrotCuts)-i)*4)+carrotX,
		//	global.camh-100-(sprite_get_yoffset(sCarrot)*2)+carrotCuts[i].yOffset,
		//	2,2,c_white,1);
	//}
	
} //-((array_length(carrotCuts)-i)*4)


if(moveInCarrot) carrotX=lerp(carrotX,0,0.12);

//knife
draw_sprite_ext(sKnife,0,global.camw-sprite_get_width(sCookingMeter)/2+6+knifeX,global.camh-100+knifeOffset,2,2,0,c_white,1);
if(resetKnife and !moveInCarrot){
	var prevKnifeX=knifeX;
	if(swipeSpeed>=30){
		knifeX=lerp(knifeX,0,0.15);
	}else{
		swipeSpeed+=2;
		knifeX-=swipeSpeed;
	}
	
	for(var i=0; i<array_length(carrotCuts); i++){
		//if(((knifeX*2.5)/((sprite_get_width(sCookingMeter)*2-12)) * sprite_get_width(sCarrot))-15 <= carrotCuts[i].endX){
		if(((knifeX*2.5)/((sprite_get_width(sCookingMeter)*2-12)) * sprite_get_width(sCarrot))-15 <= (sprite_get_width(sCarrot)-26)-((array_length(carrotCuts)-i)*4)){
			carrotCuts[i].xOffset-=swipeSpeed;
			carrotCuts[i].yOffset+=carrotCuts[i].yVel;
		}
	}
}

if(swipe){
	knifeOffset=25;
		
}else{
	knifeOffset=max(knifeOffset-5,0);
}

//invisible slider
draw_sprite_ext(sCombatSlider,0,global.camw-sprite_get_width(sCookingMeter)+6+invisibleSliderX,global.camh+180,2,2,0,c_black,1);

//draw_text(100,100,sliderX/(sprite_get_width(sCookingMeter)*2-12));



