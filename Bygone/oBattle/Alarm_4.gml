///@description  slider thingy
text_dmg=0;
textShowing=false;
with(oPortraitDone) instance_destroy();
with(oPortraitAttack) instance_destroy();

//skip player if used item
/*
while(playerAttackIndex<array_length(playerMoves) and playerMoves[playerAttackIndex][0]==-1){
	playerAttackIndex++;
	sliderIndex++;
	array_push(damageOutputs,0);
}
*/


if(sliderIndex<=array_length(playerMoves)-1){

	if(playerMoves[playerAttackIndex][3]!=-1){
		//get minigame
		minigame=playerMoves[playerAttackIndex][3];
		switch(minigame){
			case MINIGAMES.PUNCH:
				audio_play_sound(sfx_battle_slider_loop,99,1,global.master_vol * global.sfx_volume);
				sliderSpeed=random_range(8,12);
				break;
			case MINIGAMES.KICK:
				audio_play_sound(sfx_battle_slider_loop,99,1,global.master_vol * global.sfx_volume);
				greenX=random_range(-50,80);
				sliderSpeed=8;
				break;
			case MINIGAMES.ICE:
				audio_play_sound(sfx_battle_slider_loop,99,1,global.master_vol * global.sfx_volume);
				greenX=random_range(20,80);
				sliderSpeed=3;
				sliderControl=1; //can control the slider
				minigameTimer=180;
			case MINIGAMES.SMOKE:
				greenX=random_range(20,80);
				sliderSpeed=7;
				sliderControl=1;
		}
		sliderSpeed+=((playerMoves[playerAttackIndex][2][0].lvl-playerMoves[playerAttackIndex][0].lvl)*1);
		sliderSpeed=max(2,sliderSpeed);
		sliderIndex++; //which character does this game belong to
		sliderX=0; //position of the slider on the meter
		slider=true; //is the slider on screen
		sliderActive=true; //does the slider move on its own
		sliderDir=1; // direction of slider r/l
		sliderFail=0; //stop drawing the slider if this is true
		sliderMiss=0; //did you miss the attack
		minigameStarted=0; //has the minigame begun, only for games where the player decides when to begin ie. smokebomb
	}else{
		alarm[2]=1;
		sliderIndex++
		array_push(damageOutputs,0);
	}
	
	with(playerMoves[playerAttackIndex][0]){ //attacking portrait
		instance_create_depth(x,y,-99999,oPortraitAttack,{sprite_index: sprites.fight, base: id});
	}
}else{
	slider=false;
	turn=array_length(partyUnits)-1;
	playerAttackIndex=0;
	playerMoves=[]; //clear move array
	miniGames=[];
	
	KillEnemies();
	BattleNextTurn();
	damageOutputs=[];
	
}



