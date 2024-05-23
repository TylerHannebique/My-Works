if(keyboard_check_pressed(vk_space) and moveSlider and instance_exists(oCuttingBeat)){
	audio_play_sound(sfxKnife,100,0,global.master_vol * global.sfx_volume);
	//var closestBeat=instance_nearest(global.camw-sprite_get_width(sCookingMeter)+6+sliderX,global.camh+180,oCuttingBeat);
	
	//var _f = abs((global.camw-sprite_get_width(sCookingMeter)+6+sliderX)-closestBeat.x);
	var closestBeat=instance_nearest(global.camx+global.camw/2-(sprite_get_width(sCookingMeter)/2)+3+sliderX,global.camy+global.camh+180,oCuttingBeat);
	
	var _f = abs((global.camx+global.camw/2-(sprite_get_width(sCookingMeter)/2)+3+sliderX)-closestBeat.x);
	if(_f <= 10){
		var _c = #1ed451;
		var _t = "perfect";
		counts[0]++;
	}else if(_f <= 15){
		var _c = #28b550;
		var _t = "great";
		counts[1]++;
	}else if(_f <= 20){
		var _c = #249645;
		var _t = "good";
		counts[2]++;
	}else if(_f <= 25){
		var _c = #f69974;
		var _t = "ok";
		counts[3]++;
	}else if(_f <= 30){
		var _c = #b93864;
		var _t = "bad";
		counts[4]++;
	}else{
		var _c = #b93864;
		var _t = "miss";
		counts[5]++;
	}
	
	//instance_create_depth(global.camx+125+sliderX/2,global.camy+global.camh/2+85,depth-9999999999,oBattleFloatingText,{font: spr_main_font, col: _c, text: _t});
	instance_create_depth(global.camx+125+sliderX,global.camy+global.camh/2+85,depth-9999999999,oBattleFloatingText,{font: spr_main_font, col: _c, text: _t});
	
	instance_destroy(closestBeat);
	
	//knife
	//knifeOffset=25;
	knifeOffset=12;
	/*
	array_push(carrotCuts,
	{
		startX: (sliderX/((sprite_get_width(sCookingMeter)*2-12)) * sprite_get_width(sCarrot))-18,
		endX: 180,
		xOffset: 0,
		yOffset: 0,
		yVel: random_range(-0.5,0.5),
	});
	
	//change end of prev portion
	carrotCuts[array_length(carrotCuts)-2].endX = (sliderX/((sprite_get_width(sCookingMeter)*2-12)) * sprite_get_width(sCarrot))-18;
	//change yOffset of prev portion
	//carrotCuts[array_length(carrotCuts)-2].yOffset = random_range(-3,3)
	
	*/
	
	array_push(carrotCuts,
	{
		startX: (sliderX/((sprite_get_width(sCookingMeter)-6)) * sprite_get_width(sCarrot))-18,
		endX: 180,
		xOffset: 0,
		yOffset: 0,
		yVel: carrotCuts[array_length(carrotCuts)-1].yVel+random_range(-0.1,0.1)
	});
	
	//change end of prev portion
	carrotCuts[array_length(carrotCuts)-2].endX = (sliderX/((sprite_get_width(sCookingMeter)-6)) * sprite_get_width(sCarrot))-18;
	//change yOffset of prev portion
	//carrotCuts[array_length(carrotCuts)-2].yOffset = random_range(-3,3)
	
	with(oCameraManager){
		screenShake=3;
		shakeIntensity=1;
	}
	
}



audio_sound_gain(cookingSong,global.master_vol * global.music_volume,0);


