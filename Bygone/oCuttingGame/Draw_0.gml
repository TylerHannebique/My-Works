//UI
draw_sprite_ext(sCuttingBoard,0,global.camx+global.camw/2,global.camy+global.camh/2-50,1,1,0,c_white,1);

draw_sprite_ext(sCookingMeter,0,global.camx+global.camw/2,global.camy/2+sliderY,1,1,0,c_white,1);

//move sliders
if(moveSlider){
	sliderX=min(sliderX+sliderSpeed,sprite_get_width(sCookingMeter)-6);
	if(moveKnife) knifeX=min(knifeX+sliderSpeed/2.5,sprite_get_width(sCookingMeter)-3);
	if(sliderX>=sprite_get_width(sCookingMeter)-6){
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
	invisibleSliderX=min(invisibleSliderX+sliderSpeed,sprite_get_width(sCookingMeter)-3);

	if(invisibleSliderX>=sprite_get_width(sCookingMeter)-6){
		invisibleSliderX=0;	
		moveInvisSlider=false;
	}
}

//draw stuff
with(oCuttingBeat){
	draw_self();
	//draw_text(x,y-100,x);
}

draw_sprite_ext(sCombatSlider,0,global.camx+global.camw/2-(sprite_get_width(sCookingMeter)/2)+3+sliderX,global.camy+sliderY,1,1,0,c_white,1);

//carrot
	
for(var i=0; i<array_length(carrotCuts); i++){
	
	//actual carrot
	//draw_sprite_part_ext(sCarrot,0,_startX,0,_endX-_startX,60,global.camw+carrotX-sprite_get_xoffset(sCarrot)*2,global.camh-100-sprite_get_yoffset(sCarrot)*2,2,2,c_white,1);
	draw_sprite_part_ext(sCarrot,0,carrotCuts[i].startX,0,carrotCuts[i].endX-carrotCuts[i].startX,60,
		global.camx+global.camw/2+carrotCuts[i].startX-(sprite_get_xoffset(sCarrot))+carrotCuts[i].xOffset+carrotX-((array_length(carrotCuts)-i)*2),
		global.camy+global.camh/2-50-(sprite_get_yoffset(sCarrot))+carrotCuts[i].yOffset,
		1,1,c_white,1);
	
	//cuts
	draw_sprite_part_ext(sCarrot,2,carrotCuts[i].startX,0,1,60,
		global.camx+global.camw/2+carrotCuts[i].startX-(sprite_get_xoffset(sCarrot))+carrotCuts[i].xOffset+carrotX-((array_length(carrotCuts)-i)*2),
		global.camy+global.camh/2-50-(sprite_get_yoffset(sCarrot))+carrotCuts[i].yOffset,
		1,1,c_white,1);
	
} //-((array_length(carrotCuts)-i)*4)


if(moveInCarrot) carrotX=lerp(carrotX,0,0.12);

//knife
draw_sprite_ext(sKnife,0,global.camx+global.camw/2-(sprite_get_width(sCookingMeter)/4)+3+knifeX,global.camy+global.camh/2-50+knifeOffset,1,1,0,c_white,1);
if(resetKnife and !moveInCarrot){
	var prevKnifeX=knifeX;
	if(swipeSpeed>=15){
		knifeX=lerp(knifeX,0,0.15);
	}else{
		swipeSpeed+=1;
		knifeX-=swipeSpeed;
	}
	
	for(var i=0; i<array_length(carrotCuts); i++){
		//if(((knifeX*2.5)/((sprite_get_width(sCookingMeter)*2-12)) * sprite_get_width(sCarrot))-15 <= carrotCuts[i].endX){
		if(((knifeX*2.5)/((sprite_get_width(sCookingMeter)-6)) * sprite_get_width(sCarrot))-6 <= (sprite_get_width(sCarrot)-13)-((array_length(carrotCuts)-i)*4)){
			carrotCuts[i].xOffset-=swipeSpeed;
			carrotCuts[i].yOffset+=carrotCuts[i].yVel;
		}
	}
}

if(swipe){
	knifeOffset=12;
		
}else{
	knifeOffset=max(knifeOffset-3,0);
}

//invisible slider
//draw_sprite_ext(sCombatSlider,0,global.camx+global.camw/2-(sprite_get_width(sCookingMeter)/2)+3+invisibleSliderX,global.camy+sliderY,1,1,0,c_black,1);

//draw_text(100,100,sliderX/(sprite_get_width(sCookingMeter)*2-12));



