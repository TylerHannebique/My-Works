/// @description platformAttacks
var cx = cam_x+(cam_w/2);
var cy = UIYcenter-25;
text_dmg=0;

	
var att1 = irandom_range(0,8);
while(!array_contains(global.defenseLayout,att1) or existsTargetAlready(att1)){
	var att1 = irandom_range(0,8);
}

var att2 = irandom_range(0,8);
while(att1==att2 or !array_contains(global.defenseLayout,att2) or existsTargetAlready(att2)) att2 = irandom_range(0,8);

/*
if(enemyAttacksRemaining==2){
	var att1=3;
	var att2=4;
}else{
	var att1=1;
	var att2=2;
}
*/

//sort
if(att1>att2){
	var t=att1;
	att1=att2;
	att2=t;
}

var _slowed=(effectAlreadyApplied(EFFECTS.SLOWNESS,currentUser)!=-1);

var _blend=c_white
var speedMultiplier = 1;
if(_slowed){
	speedMultiplier = 4;
	_blend=#8DFFF9;
}

for(var i=0; i<5; i++){
	if(i==att1 or i==att2){
		switch(i){
			case 0:
				instance_create_depth(cx-51,cy-51,-999999,oTarget, {n: 0, sprite_index: sRedLeft, xLoc: -1, yLoc: -1, handIndex: i==att2 ? 1 : 0, attackSpeed: currentUser.attackSpeed*speedMultiplier, blend: _blend}) //top left
						audio_play_sound(sfx_battle_bertha_imminent_left_box,99,false,global.master_vol * global.sfx_volume)
				break;
			case 1:
				instance_create_depth(cx-51,cy,-999991,oTarget, {n: 1, sprite_index: sRedMiddle, xLoc: -1, yLoc: 0, handIndex: i==att2 ? 1 : 0, attackSpeed: currentUser.attackSpeed*speedMultiplier, blend: _blend}); //left	
					audio_play_sound(sfx_battle_bertha_imminent_center_boxes,99,false,global.master_vol * global.sfx_volume)
				break;
			case 2:
				instance_create_depth(cx-51,cy+52,-9999992,oTarget, {n: 2, sprite_index: sRedMiddle, xLoc: -1, yLoc: 1, handIndex: i==att2 ? 1 : 0, attackSpeed: currentUser.attackSpeed*speedMultiplier, blend: _blend}); //bottom left
					audio_play_sound(sfx_battle_bertha_imminent_center_boxes,99,false,global.master_vol * global.sfx_volume);
				break;
			case 3:
				instance_create_depth(cx,cy-51,-999999,oTarget, {n: 3, sprite_index: sRedMiddle, xLoc: 0, yLoc: -1, handIndex: i==att2 ? 1 : 0, attackSpeed: currentUser.attackSpeed*speedMultiplier, blend: _blend}); //top
					audio_play_sound(sfx_battle_bertha_imminent_center_boxes,99,false,global.master_vol * global.sfx_volume);
				break;
			case 4:
				instance_create_depth(cx,cy,-9999991,oTarget, {n: 4, sprite_index: sRedMiddle, xLoc: 0, yLoc: 0, handIndex: i==att2 ? 1 : 0, attackSpeed: currentUser.attackSpeed*speedMultiplier, blend: _blend}); //middle
					audio_play_sound(sfx_battle_bertha_imminent_right_box,99,false,global.master_vol * global.sfx_volume);
				break;
			case 5:
				instance_create_depth(cx,cy+52,-9999992,oTarget, {n: 5, sprite_index: sRedBottom, xLoc: 0, yLoc: 1, handIndex: i==att2 ? 1 : 0, attackSpeed: currentUser.attackSpeed*speedMultiplier, blend: _blend}); //bottom
					audio_play_sound(sfx_battle_bertha_imminent_right_box,99,false,global.master_vol * global.sfx_volume);
				break;
			case 6:
				instance_create_depth(cx+51,cy-51,-999999,oTarget, {n: 6, sprite_index: sRedRight, xLoc: 1, yLoc: -1, handIndex: i==att2 ? 1 : 0, attackSpeed: currentUser.attackSpeed*speedMultiplier, blend: _blend}); //top right
					audio_play_sound(sfx_battle_bertha_imminent_right_box,99,false,global.master_vol * global.sfx_volume);
				break;
			case 7:
				instance_create_depth(cx+51,cy,-9999991,oTarget, {n: 7, sprite_index: sRedRight, xLoc: 1, yLoc: 0, handIndex: i==att2 ? 1 : 0, attackSpeed: currentUser.attackSpeed*speedMultiplier, blend: _blend}); //right
					audio_play_sound(sfx_battle_bertha_imminent_right_box,99,false,global.master_vol * global.sfx_volume);
				break;
			case 8:
				instance_create_depth(cx+51,cy+52,-9999992,oTarget, {n: 8, sprite_index: sRedRight, xLoc: 1, yLoc: 1, handIndex: i==att2 ? 1 : 0, attackSpeed: currentUser.attackSpeed*speedMultiplier, blend: _blend}); //bottom right
					audio_play_sound(sfx_battle_bertha_imminent_right_box,99,false,global.master_vol * global.sfx_volume);
				break;
		}
	}
}



enemyAttacksRemaining--;
if(enemyAttacksRemaining>0){
	if(_slowed){
		alarm[8]=50;
	}else alarm[8]=35;
}else{
	alarm[9]=180;
}
