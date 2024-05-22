//battleState();

//cursor control
var _keyUp = keyboard_check_pressed(global.key_mapped[0,0]) or keyboard_check_pressed(global.key_mapped[0,1]);
var _keyDown = keyboard_check_pressed(global.key_mapped[1,0]) or keyboard_check_pressed(global.key_mapped[1,1]);
var _keyLeft = keyboard_check_pressed(global.key_mapped[2,0]) or keyboard_check_pressed(global.key_mapped[2,1]);
var _keyRight = keyboard_check_pressed(global.key_mapped[3,0]) or keyboard_check_pressed(global.key_mapped[3,1]);
var _keyEsc = keyboard_check_pressed(vk_escape);
var _keyConfirm = keyboard_check_pressed(global.key_mapped[5,0]) or keyboard_check_pressed(global.key_mapped[5,1]);
var _keySpace = keyboard_check(vk_space);
var _moveH = _keyRight - _keyLeft;
var _moveV = _keyDown - _keyUp;

//main controls
if(playerControl){
	
	//check if box alread selected
	var flash=false;
	with(oBattleOption) if(flashing) flash=true;
	
	//main menu controls
	if(!attackSub and !skills and !flash and !inventory){
		if(_moveH==1) {box_c++ audio_play_sound(sfx_ui_hover_over_option,1,0,global.master_vol * global.sfx_volume)};
		if(_moveH==-1) {box_c-- audio_play_sound(sfx_ui_hover_over_option,1,0,global.master_vol * global.sfx_volume)};
		if(_moveV==1) {box_r++ audio_play_sound(sfx_ui_hover_over_option,1,0,global.master_vol * global.sfx_volume)};
		if(_moveV==-1) {box_r-- audio_play_sound(sfx_ui_hover_over_option,1,0,global.master_vol * global.sfx_volume)};
		box_r=clamp(box_r,0,1);
		box_c=clamp(box_c,0,1);
	}

	if(_keyEsc){
		if(attack){
			attack=false;
			audio_play_sound(sfx_ui_cancel,99,false,global.master_vol * global.sfx_volume);
		}else if(selectedItem!=-1){
			selectedItem=-1;
			audio_play_sound(sfx_ui_cancel,99,false,global.master_vol * global.sfx_volume);
		}else if (skills or attackSub or inventory or environment){ //back to main menu
			skills=false;
			attack=false;
			environment=false;
			attackSub=false;
			inventory=false;
			inventoryIndex=0;
			skillIndex=0;
			MainButtons();
			audio_play_sound(sfx_ui_cancel,99,false,global.master_vol * global.sfx_volume);
		}else if(array_length(playerMoves)>0){ //go back to previous character
			array_pop(playerMoves);
			turn--;
			turnCount--;
			currentUser=unitTurnOrder[turn];
			with(oPortraitExpression) if(base==other.currentUser) instance_destroy();
			audio_play_sound(sfx_ui_cancel,99,false,global.master_vol * global.sfx_volume);
			
		}
	}

//skill menu
	if(skills and !attack){
		if(_moveV==1) {skillIndex++ audio_play_sound(sfx_ui_hover_over_option,1,0,global.master_vol * global.sfx_volume)};
		if(_moveV==-1) {skillIndex-- audio_play_sound(sfx_ui_hover_over_option,1,0,global.master_vol * global.sfx_volume)};
		skillIndex=abs((skillIndex%array_length(currentUser.skills)));
		
		
		if (_keyConfirm){ 
			selectedSkill=currentUser.skills[skillIndex];
			
			if(currentUser.skills[skillIndex]==global.actionLibrary.smoke){ //if you dont need to select a target
				audio_play_sound(sfx_battle_confirm_target,99,0,global.master_vol * global.sfx_volume);
				array_push(playerMoves, [currentUser, selectedSkill, [enemyUnits[enemyIndex]], selectedSkill.minigame]);
				//thumbs up
				with(currentUser){
					instance_create_depth(x,y,-99999,oPortraitDone,{sprite_index: sprites.done, base: id});
				}
				
				if(array_length(playerMoves) >= array_length(partyUnits)){ //start all actions
					playerAttackIndex=0;
					alarm[4]=30;
					sliderIndex=0;
					turn=0;
					playerControl=false;
					attack=false;
					attackSub=false;
					skills=false;
					environment=false;
				}else{
					alarm[0]=1; //next character
				}
			}else{ //select target
				alarm[3]=1;
				audio_play_sound(sfx_ui_select, 99, false,global.master_vol * global.sfx_volume);
			}
		}
	}
	
//attack menu
	if(attackSub and !attack){
		if(_moveV==1) {attackIndex++ audio_play_sound(sfx_ui_hover_over_option,1,0,global.master_vol * global.sfx_volume)};
		if(_moveV==-1) {attackIndex-- audio_play_sound(sfx_ui_hover_over_option,1,0,global.master_vol * global.sfx_volume)};
		attackIndex=abs((attackIndex%array_length(currentUser.attacks)));
		if (_keyConfirm){
			selectedSkill=currentUser.attacks[attackIndex];
			invPX=0;
			invPY=0;
			invChar=pMatrix[0,0];
			alarm[3]=1;
			audio_play_sound(sfx_ui_select, 99, false,global.master_vol * global.sfx_volume);
		}
	}
	
	//environment menu
	if(environment and !attack){
		if(_moveV==1) {environmentIndex++; audio_play_sound(sfx_ui_hover_over_option,1,0,global.master_vol * global.sfx_volume);};
		if(_moveV==-1) {environmentIndex--; audio_play_sound(sfx_ui_hover_over_option,1,0,global.master_vol * global.sfx_volume);};
		environmentIndex=abs((environmentIndex%array_length(global.environmentList)));
		if (_keyConfirm){
			selectedSkill=global.environmentList[environmentIndex];
			alarm[3]=1;
			audio_play_sound(sfx_ui_select, 99, false);
		}
	}
	
//inventory menu
	if(inventory){
		if(selectedItem==-1 and array_length(global.inventoryList)>0){
			if(_moveV==1) {inventoryIndex=(inventoryIndex+1)%array_length(global.inventoryList) audio_play_sound(sfx_ui_hover_over_option,1,0,global.master_vol * global.sfx_volume)};
			if(_moveV==-1) {inventoryIndex=(inventoryIndex-1+array_length(global.inventoryList))%array_length(global.inventoryList) audio_play_sound(sfx_ui_hover_over_option,1,0,global.master_vol * global.sfx_volume)}
			//inventoryIndex=abs((inventoryIndex%array_length(global.inventoryList)));
			if (_keyConfirm){
				selectedItem=inventoryIndex;
				audio_play_sound(sfx_ui_select, 99, false,global.master_vol * global.sfx_volume);
				switch(currentUser.partyNum){
					case 0: 
						invPX=0;
						invPY=0;
						break;
					case 1:
						invPX=1;
						invPY=0;
					case 2: 
						invPX=1;
						invPY=1;
						break;
					case 3:
						invPX=0;
						invPY=1;
						break;
				}
				
			}
		}else{
			if(_keyLeft){ invPX=0 audio_play_sound(sfx_ui_hover_over_option,1,0,global.master_vol * global.sfx_volume)};
			if(_keyRight){ invPX=1 audio_play_sound(sfx_ui_hover_over_option,1,0,global.master_vol * global.sfx_volume)} ;
			if(_keyUp){ invPY=0 audio_play_sound(sfx_ui_hover_over_option,1,0,global.master_vol * global.sfx_volume) };
			if(_keyDown){ invPY=1 audio_play_sound(sfx_ui_hover_over_option,1,0,global.master_vol * global.sfx_volume)} ;
			invChar=pMatrix[invPY,invPX];
			
			if(_keyConfirm){
				audio_play_sound(sfx_battle_confirm_target,99,0,global.master_vol * global.sfx_volume);
				var char=findChar(invChar)
				//global.inventoryList[selectedItem][0].effect(char);
				global.inventoryList[selectedItem].count--;
				refreshInventory(global.inventoryList);
				array_push(playerMoves, [currentUser, global.inventoryList[selectedItem].listItem, [char], -1]);
				inventoryIndex=0;
				selectedItem=-1;
				inventory=false;
				if(array_length(playerMoves) >= array_length(partyUnits)){ //start all actions
					playerAttackIndex=0;
					alarm[4]=30;
					sliderIndex=0;
					turn=0;
					playerControl=false;
					attack=false;
					attackSub=false;
					skills=false;
					environment=false;
				}else{
					alarm[0]=1; //next character
				}
			}
		}
	}

//attack submenu
	if(attack){
		if(_moveH==1) if(enemyIndex<array_length(enemyUnits)-1) {enemyIndex++ audio_play_sound(sfx_ui_hover_over_option,1,0,global.master_vol * global.sfx_volume)}; else enemyIndex=0 ;
		if(_moveH==-1) if(enemyIndex>0) {enemyIndex-- audio_play_sound(sfx_ui_hover_over_option,1,0,global.master_vol * global.sfx_volume)}; else enemyIndex=array_length(enemyUnits)-1;
		if (_keyConfirm){
			audio_play_sound(sfx_battle_confirm_target,99,0,global.master_vol * global.sfx_volume);
			array_push(playerMoves, [currentUser, selectedSkill, [enemyUnits[enemyIndex]], selectedSkill.minigame]);
			//thumbs up
			with(currentUser){
				instance_create_depth(x,y,-99999,oPortraitDone,{sprite_index: sprites.done, base: id});
			}
			
			if(array_length(playerMoves) >= array_length(partyUnits)){ //start all actions
				playerAttackIndex=0;
				alarm[4]=30;
				sliderIndex=0;
				turn=0;
				playerControl=false;
				attack=false;
				attackSub=false;
				skills=false;
				environment=false;
			}else{
				alarm[0]=1; //next character
			}

			

			
			
			
			
			//BeginAction(currentUser, unitTurnOrder[turn].actions[0], [enemyUnits[enemyIndex]] );
		}
	}
}
arrow+=0.25;

//minigames
if(slider and sliderActive){
	
	if(!sliderControl){
		
		if(_keyConfirm){
			sliderShake=1;
			sliderActive=0;
			alarm[5]=20;
			alarm[2]=35;
			var _crit=getCritical(currentUser.luck);
			var _dmgX=1;
			if (_crit) _dmgX=2;
	
			switch(minigame){
				case MINIGAMES.PUNCH:
					var _f = sliderX/(sprite_get_width(sPunchGame)-8);
					if(_f <= 0.25){
						var _c = #b93864;
						var _t = "bad";
						array_push(damageOutputs,_f*_dmgX);
						audio_play_sound(sfx_battle_attack_punch,99,false,global.master_vol * global.sfx_volume);
					}else if(_f <= 0.5){
						var _c = #f69974;
						var _t = "ok";
						array_push(damageOutputs,_f*_dmgX);
						audio_play_sound(sfx_battle_attack_punch,99,false,global.master_vol * global.sfx_volume);
					}else if(_f <= 0.75){
						var _c = #7bd596;
						var _t = "good";
						array_push(damageOutputs,_f*_dmgX);
						audio_play_sound(sfx_battle_attack_punch,99,false,global.master_vol * global.sfx_volume);
					}else if(_f <= 0.99){
						var _c = #7bd596;
						var _t = "great";
						array_push(damageOutputs,_f*_dmgX);
						audio_play_sound(sfx_battle_attack_punch,99,false,global.master_vol * global.sfx_volume);
					}else{
						var _c = #7bd596;
						var _t = "perfect";
						array_push(damageOutputs,1*_dmgX);
						audio_play_sound(sfx_battle_attack_perfect,99,false,global.master_vol * global.sfx_volume);
						audio_play_sound(sfx_battle_attack_punch,99,false,global.master_vol * global.sfx_volume);
					}
					damageBonuses[(currentUser.partyNum+1)mod array_length(global.party)]+=floor(_f*10);
					break;
				case MINIGAMES.KICK:
					var _g = sprite_get_width(sSmokeGame)/2+greenX;
					if(sliderX >= _g-14 and sliderX <= _g+14){
						array_push(damageOutputs,1*_dmgX);
						var _c = #7bd596;
						var _t = "perfect";
						damageBonuses[(currentUser.partyNum+1)mod array_length(global.party)]+=10;
						audio_play_sound(sfx_battle_attack_perfect,99,false,global.master_vol * global.sfx_volume);
						audio_play_sound(sfx_battle_attack_punch,99,false,global.master_vol * global.sfx_volume);
					}else{
						array_push(damageOutputs,0);
						var _c = #b93864;
						var _t = "miss";
						sliderMiss=1;
						audio_play_sound(sfx_battle_attack_failed,99,false,global.master_vol * global.sfx_volume);
						audio_play_sound(sfx_battle_attack_punch,99,false,global.master_vol * global.sfx_volume);
					}
					break;
			}
			audio_stop_sound(sfx_battle_slider_loop);
			if(_crit and _t!="miss"){
				instance_create_depth(cam_x+220+sliderX,cam_y+410,depth-9999999999,oBattleFloatingText,{font: spr_main_font, col: _c, text: "CRITICAL!"});
			}else{
				instance_create_depth(cam_x+220+sliderX,cam_y+410,depth-9999999999,oBattleFloatingText,{font: spr_main_font, col: _c, text: _t});
			}
			DamageEnemy();
		}
	}else{
		
		switch(minigame){
			case MINIGAMES.ICE:
				minigameTimer--;
				if(minigameTimer<=0){
					audio_stop_sound(sfx_battle_slider_loop);
					var _g = sprite_get_width(sIceGame)/2+greenX;
					if(sliderX >= _g-20 and sliderX <= _g+20){
						array_push(damageOutputs,1);
						var _c = #7bd596;
						var _t = "perfect";
						damageBonuses[(currentUser.partyNum+1)mod array_length(global.party)]+=2;
						audio_play_sound(sfx_battle_attack_perfect,99,false,global.master_vol * global.sfx_volume);
						audio_play_sound(sfx_battle_attack_punch,99,false,global.master_vol * global.sfx_volume);
						audio_stop_sound(sfx_battle_slider_loop);
					}else{
						array_push(damageOutputs,0);
						var _c = #b93864;
						var _t = "miss";
						sliderMiss=1;
						audio_play_sound(sfx_battle_attack_failed,99,false,global.master_vol * global.sfx_volume);
					}
					sliderShake=1;
					sliderActive=0;
					alarm[2]=35;
					alarm[5]=20;
					instance_create_depth(cam_x+220+sliderX,cam_y+410,depth-9999999999,oBattleFloatingText,{font: spr_main_font, col: _c, text: _t});
					DamageEnemy();
				}
				if(_keySpace){
					sliderX=min(sliderX+sliderSpeed,sprite_get_width(sIceGame));
				}else sliderX=max(sliderX-sliderSpeed,0);
				break;
			case MINIGAMES.SMOKE:
			
				if(_keySpace){
					if(!minigameStarted){
						minigameStarted=true;
						audio_play_sound(sfx_battle_slider_loop,99,false,global.master_vol * global.sfx_volume);
					}
					sliderX=min(sliderX+sliderSpeed,sprite_get_width(sSmokeGame));
				}else if(minigameStarted){
					audio_stop_sound(sfx_battle_slider_loop);
					var _g = sprite_get_width(sSmokeGame)/2+greenX;
					if(sliderX >= _g-20 and sliderX <= _g+20){
						array_push(damageOutputs,1);
						var _c = #7bd596;
						var _t = "perfect";
						damageBonuses[(currentUser.partyNum+1)mod array_length(global.party)]+=2;
						audio_play_sound(sfx_battle_attack_perfect,99,false,global.master_vol * global.sfx_volume);
					}else{
						array_push(damageOutputs,0);
						var _c = #b93864;
						var _t = "miss";
						sliderMiss=1;
						audio_play_sound(sfx_battle_attack_failed,99,false,global.master_vol * global.sfx_volume);
					}
					sliderShake=1;
					sliderActive=0;
					alarm[2]=35;
					alarm[5]=20;
					instance_create_depth(cam_x+220+sliderX,cam_y+410,depth-9999999999,oBattleFloatingText,{font: spr_main_font, col: _c, text: _t});
					//DamageEnemy();
				}
				break;
		}
		
	}
	
}

//sfx End For Minigames 
if(sliderActive = false and sfx_played_minigame = true){
	audio_stop_sound(sfx_battle_slider_loop);
	sfx_played_minigame = false;
}
