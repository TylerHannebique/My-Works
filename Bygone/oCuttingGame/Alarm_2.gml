/// @description add beats
if(beatIndex<array_length(beatList)){
	//instance_create_depth(global.camw-sprite_get_width(sCookingMeter)+8+invisibleSliderX,sliderY,-999,oCookingBeat);
	instance_create_depth(global.camx+global.camw/2-(sprite_get_width(sCookingMeter)/2)+4+invisibleSliderX,global.camy+sliderY,-999,oCuttingBeat);
	audio_play_sound(sfxKnife,100,0,global.master_vol * global.sfx_volume);

	if(beatNumber<array_length(beatList[beatIndex])-1){
		alarm[2]=beatList[beatIndex][beatNumber];
		beatNumber++;
	}else{
		beatNumber=0;
		beatIndex++;
	}

}else instance_destroy();