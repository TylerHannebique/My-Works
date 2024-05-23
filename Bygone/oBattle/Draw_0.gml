//bg
draw_set_color(c_black);
draw_rectangle(x-100,y-100,x+global.camw+100,y+global.camh+100,0);
draw_sprite(battleBackground,0,x,y);

//enemies
with(oBattleUnitEnemy){
	var _attacking=oBattle.currentUser.id==id;
	var _selected=oBattle.attack and oBattle.enemyUnits[oBattle.enemyIndex].id==id and oBattle.attack and oBattle.playerControl;

	if(_attacking or _selected){
		var c;
		if(_attacking) c=c_red; else c=c_white;
		var shade = gpu_get_fog();
		shade[0]=true;
		shade[1]=c;
		gpu_set_fog(shade);
	
		draw_sprite(sprite_index,image_index,x+1,y);
		draw_sprite(sprite_index,image_index,x-1,y);
		draw_sprite(sprite_index,image_index,x,y+1);
		draw_sprite(sprite_index,image_index,x,y-1);
	
		shade[0]=false;
		gpu_set_fog(shade);
	}
	draw_self();
	//shader_reset();
	if(array_length(oBattle.enemyUnits)>0 and oBattle.enemyUnits[oBattle.enemyIndex].id==id and oBattle.attack and oBattle.playerControl){
		draw_sprite_ext(sPointerDown, oBattle.arrow, x,y-70, 1, 1, 0, c_white, sin(get_timer()/250000)+1);
	}
	
}

//day/night
draw_set_alpha(oDayNightManager.darkness);
var c=oDayNightManager.lightColor;
draw_rectangle_color(oCameraManager._camX,oCameraManager._camY,oCameraManager._camX+global.camw,oCameraManager._camY+global.camh,c,c,c,c,0);
draw_set_alpha(1);

//uiboxes/buttons
if(defense){ //square box
	box_h_curr=lerp(box_h_curr,box_h_square,0.3);
	box_y_curr=lerp(box_y_curr,box_y_square,0.3);
	grey_y_curr=lerp(grey_y_curr,grey_y_square,0.3);
	if(moveBoxUp){
		bg_y_curr=lerp(bg_y_curr,bg_y_end,0.3);
	}
}else if(attack or attackSub or skills or inventory or environment){ //full box
	box_w_curr=lerp(box_w_curr,box_w_full,0.3);
	box_x_curr=lerp(box_x_curr,box_x_full,0.3);
	if(!attack) mid_line_curr=lerp(mid_line_curr,mid_line_full,0.3);
}else if(textShowing){
	box_w_curr=lerp(box_w_curr,box_w_text,0.3);
	box_x_curr=lerp(box_x_curr,box_x_text,0.3);
	box_h_curr=lerp(box_h_curr,box_h_start,0.3);
	box_y_curr=lerp(box_y_curr,box_y_start,0.3);
	grey_y_curr=lerp(grey_y_curr,box_y_start,0.3);
	bg_y_curr=lerp(bg_y_curr,bg_y_start,0.3);
}else{ //med box
	box_w_curr=lerp(box_w_curr,box_w_start,0.3);
	box_x_curr=lerp(box_x_curr,box_x_start,0.3);
	mid_line_curr=lerp(mid_line_curr,mid_line_start,0.3);
}
//}else{ //close box
//	box_w_curr=lerp(box_w_curr,box_w_close,0.3);
//	box_x_curr=lerp(box_x_curr,box_x_close,0.3);
//	mid_line_curr=lerp(mid_line_curr,mid_line_start,0.3);
//	mid_line_c=c_ltgray;
//}

//for(var i=0; i<floor(box_w_curr/16);i++){ //grad
//	draw_sprite(sBoxGradiant,0,box_x_curr+(i*16),y+385);
//}
draw_set_alpha(0.5);
draw_sprite_stretched(sBox, 0, cam_x+6, cam_y+grey_y_curr, cam_w-12, box_h_curr); //grey portion
draw_set_alpha(1);

draw_sprite_stretched(sWhiteBox, 0, box_x_curr, cam_y+box_y_curr, box_w_curr, box_h_curr); //purple portion

draw_set_color(c_white);
if((attackSub or skills or inventory or environment) and !attack){
	if(inventory){
		draw_sprite_stretched(sWhiteBoxLine,0,cam_x+cam_w/2-55,y+box_y_curr+3, 4, mid_line_curr);
	}else{
		draw_sprite_stretched(sWhiteBoxLine,0,cam_x+cam_w/2-1,y+box_y_curr+3, 4, mid_line_curr);
	}
	
	//draw_rectangle(cam_x+cam_w/2, mid_line_start, cam_x+cam_w/2, mid_line_curr, 0); //line
}

//skills
if(skills and box_w_curr>=box_w_full-8 and !attack){
	for(var i=0; i<array_length(currentUser.skills); i++){
		draw_set_color(c_white);
		if(skillIndex==i) draw_set_color(c_yellow);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text_transformed(cam_x+19,cam_y+426+(i*32),currentUser.skills[i].name,1,1,0);
		

	}
	
	draw_set_color(c_white);
	//name
	draw_text_transformed(cam_x+(cam_w/2)+10,cam_y+421,currentUser.skills[skillIndex].name,1,1,0);
	//effect
	switch(currentUser.skills[skillIndex].minigame){
	case MINIGAMES.ICE:
		draw_sprite(sEffectIcon,0,cam_x+(cam_w/2)+string_width(currentUser.skills[skillIndex].name)+12,cam_y+424);
		break;
	}
	//desc
	draw_text_ext_transformed(cam_x+(cam_w/2)+10,cam_y+445,currentUser.skills[skillIndex].description,20,390,0.75,0.75,0);
	//cost
	draw_text_ext_transformed(global.camx+(global.camw/2)+10,global.camy+504,"Energy Cost: " + string(currentUser.skills[skillIndex].mpCost),20,320,0.75,0.75,0);
}

//attacks
if(attackSub and box_w_curr>=box_w_full-8 and !attack){
	for(var i=0; i<array_length(currentUser.attacks); i++){
		draw_set_color(c_white);
		if(attackIndex==i) draw_set_color(c_yellow);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		//draw_text_transformed(cam_x+16,cam_y+421+(i*35),currentUser.attacks[i].name,1.25,1.25,0);
		draw_text_transformed(cam_x+19,cam_y+426+(i*32),currentUser.attacks[i].name,1,1,0);
	}
	
	draw_set_color(c_white); //descriptions
	draw_text_transformed(cam_x+(cam_w/2)+10,cam_y+421,currentUser.attacks[attackIndex].name,1,1,0);
	draw_text_ext_transformed(cam_x+(cam_w/2)+10,cam_y+445,currentUser.attacks[attackIndex].description,20,390,0.75,0.75,0);
	
	draw_text_ext_transformed(global.camx+(global.camw/2)+10,global.camy+504,"Energy Cost: " + string(currentUser.attacks[attackIndex].mpCost),20,320,0.75,0.75,0);

}

//environment
if(environment and box_w_curr>=box_w_full-8 and !attack){
	for(var i=0; i<array_length(global.environmentList); i++){
		draw_set_color(c_white);
		if(environmentIndex==i) draw_set_color(c_yellow);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text_transformed(cam_x+19,cam_y+426+(i*32),global.environmentList[i].name,1,1,0);
	}
	
	draw_set_color(c_white);
	//name
	draw_text_transformed(cam_x+(cam_w/2)+10,cam_y+421,global.environmentList[environmentIndex].name,1,1,0);
	//effect
	switch(global.environmentList[environmentIndex].minigame){
	case MINIGAMES.ICE:
		draw_sprite(sEffectIcon,0,cam_x+(cam_w/2)+string_width(global.environmentList[environmentIndex].name)+12,cam_y+424);
		break;
	}
	//desc
	draw_text_ext_transformed(cam_x+(cam_w/2)+10,cam_y+445,global.environmentList[environmentIndex].description,20,390,0.75,0.75,0);
	//cost
	draw_text_ext_transformed(global.camx+(global.camw/2)+10,global.camy+504,"Energy Cost: " + string(global.environmentList[environmentIndex].mpCost),20,320,0.75,0.75,0);
}
	
//inventory
if(inventory and box_w_curr>=box_w_full-8 and array_length(global.inventoryList)>0){
//item selection
	for(var i=0; i<array_length(global.inventoryList); i++){
		draw_set_color(c_white);
		if(inventoryIndex==i) draw_set_color(c_yellow);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text(cam_x+16,cam_y+421+(i*24),global.inventoryList[i].listItem.name);
	
		draw_set_halign(fa_right);
		draw_text_transformed(cam_x+276,global.camy+426+(i*24),"x"+string(global.inventoryList[i].count),.75,.75,0);
	}
	
	//descriptions/pictures
	draw_set_color(c_white);
	draw_set_halign(fa_left);
	draw_set_font(spr_main_font)
	draw_text_transformed(global.camx+(global.camw/2)-44,global.camy+421,global.inventoryList[inventoryIndex].listItem.name,1,1,0);
	draw_text_ext_transformed(global.camx+(global.camw/2)-44,global.camy+445,global.inventoryList[inventoryIndex].listItem.desc,20,340,0.75,0.75,0);
	
	draw_sprite(sItemSquare,0,global.camx+(global.camw/2)+322,global.camy+427);
	draw_sprite(global.inventoryList[inventoryIndex].listItem.sprite,0,global.camx+(global.camw/2)+322,global.camy+427);
}

//slider
if(slider){
	//text
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	draw_text_transformed(cam_x+144,UIYcenter-52,string(sliderIndex) + "/" + string(array_length(playerMoves)) + " " + partyUnits[sliderIndex-1].name,0.75,0.75,0);
	if(minigameTimer>0){
		draw_set_halign(fa_right);
		draw_text(cam_x+528,UIYcenter-52,string(minigameTimer/60)+"s");
	}
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	draw_text_transformed(UIXcenter,UIYcenter+30,"Space to attack",0.75,0.75,0);
	
	//shake
	if(sliderShake){ var _a = random_range(-2,2);
	}else var _a = 0;
	
	//drawing
	switch(minigame){
		case MINIGAMES.PUNCH:
			draw_sprite_ext(sPunchGame,0,cam_x+(cam_w/2), y+465,1,1,_a,c_white,1);
			if(!sliderFail) draw_sprite(sCombatSlider,0,cam_x+(cam_w/2)-(sprite_get_width(sPunchGame)/2)+4+sliderX, y+465);
			//draw_text_transformed(UIXcenter-60,UIYcenter-30,"x0.25",0.5,0.5,0);
			//draw_text_transformed(UIXcenter,UIYcenter-30,"x0.5",0.5,0.5,0);
			//draw_text_transformed(UIXcenter+60,UIYcenter-30,"x0.75",0.5,0.5,0);
			break;
		case MINIGAMES.KICK:
			draw_sprite_ext(sKickGame,0,cam_x+(cam_w/2), y+465,1,1,_a,c_white,1);
			draw_sprite_ext(sKickGame,1,cam_x+(cam_w/2)+greenX, y+465,1,1,_a,c_white,1);
			if(!sliderFail) draw_sprite(sCombatSlider,0,cam_x+(cam_w/2)-(sprite_get_width(sKickGame)/2)+sliderX, y+465);
			break;
		case MINIGAMES.ICE:
			draw_sprite_ext(sIceGame,0,cam_x+(cam_w/2), y+465,1,1,_a,c_white,1);
			draw_sprite_ext(sIceGame,1,cam_x+(cam_w/2)+greenX, y+465,1,1,_a,c_white,1);
			if(!sliderFail) draw_sprite(sCombatSlider,0,cam_x+(cam_w/2)-(sprite_get_width(sIceGame)/2)+sliderX, y+465);
			break;
		case MINIGAMES.SMOKE:
			draw_sprite_ext(sSmokeGame,0,cam_x+(cam_w/2), y+465,1,1,_a,c_white,1);
			draw_sprite_ext(sSmokeGame,1,cam_x+(cam_w/2)+greenX, y+465,1,1,_a,c_white,1);
			if(!sliderFail) draw_sprite(sCombatSlider,0,cam_x+(cam_w/2)-(sprite_get_width(sSmokeGame)/2)+sliderX, y+465);
			break;
	}

	//moving/triggering
	if(sliderActive and !sliderControl){
		if(sliderDir=1){
			if(sliderX<202){
				sliderX=min(sliderX+sliderSpeed,sprite_get_width(sPunchGame)-8);
			}else sliderDir=-1;
		}else{
			if(sliderX>0){
				sliderX=max(sliderX-sliderSpeed,0);
			}else{ //failure
				sliderShake=1;
				sliderActive=0;
				sliderFail=1;
				alarm[2]=35;
				alarm[5]=20;
				array_push(damageOutputs,0);
				instance_create_depth(cam_x+220+sliderX,cam_y+410,depth-9999999,oBattleFloatingText,{font: spr_main_font, col: #b93864, text: "miss"});
				audio_play_sound(sfx_battle_attack_failed,99,false)
				audio_stop_sound(sfx_battle_slider_loop);
			}
		}
	}
}



if(attack){
	draw_set_halign(fa_center);
	draw_text(UIXcenter,UIYcenter-20,"Choose Target");
}


//enemy hp
var _range=364;
var _mid = cam_x+(cam_w/2);

var aliveEnemies=[]; 
for(var i=0; i<array_length(enemyUnits); i++){
	if(enemyUnits[i].image_alpha>0) array_push(aliveEnemies,enemyUnits[i]);
}

if(!enemyHpInit){
	enemyHpInterval=_range/array_length(aliveEnemies); //space from center of one bar to the next
	enemyHpOffset=6; //space between edges of bars
	enemyHpLength=enemyHpInterval-(enemyHpOffset); //space of healthbar itself
	enemyHpInit=true;
}	
for(var i=0; i<array_length(aliveEnemies);i++){
	
	var _start=_mid-(array_length(aliveEnemies)/2*enemyHpInterval)+(enemyHpOffset/2);
	var _x=_start+(i*enemyHpInterval);
	
	var _hlth=aliveEnemies[i].hp/aliveEnemies[i].hpMax;
	
	var _trickleLength = round((aliveEnemies[i].trickleHp * (enemyHpLength-6))/3);
	var _hLength = round((_hlth * (enemyHpLength-6))/3);
	
	draw_sprite_stretched(sEnemyHealthbar,3,_x,cam_y+5,enemyHpLength,34); //bg
	
	for(var j=0; j<_trickleLength; j++){ //trickle part
		draw_sprite(sEnemyHealthbar,2,_x+3+(j*3),cam_y+8);
	}
	for(var j=0; j<_hLength; j++){ //actual health
		draw_sprite(sEnemyHealthbar,1,_x+3+(j*3),cam_y+8);
	}
	draw_sprite_stretched(sEnemyHealthbar,0,_x,cam_y+5,enemyHpLength,34);
	draw_set_halign(fa_center);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_text_transformed(_x+((enemyHpLength)/2),cam_y+17,aliveEnemies[i].name + "-Lvl:" + string(aliveEnemies[i].lvl),0.75,0.75,0);
	
	//effect
	for(var j=0; j<array_length(aliveEnemies[i].effectsApplied); j++){
		draw_sprite(sEffectIcon,0,_x+(j*20),global.camy+38);
		var _f=aliveEnemies[i].effectsApplied[j].turns/aliveEnemies[i].effectsApplied[j].maxTurns;
		var _fracDrawn=31-(_f*31);
		draw_sprite_part(sEffectIcon,1,0,0,31,_fracDrawn,_x+(j*20),global.camy+38);
		//draw_text_transformed(_x+(j*37)+8,global.camy+52,aliveEnemies[i].effectsApplied[j].turns,0.5,0.5,0);
		
		//draw_sprite_part(battleBackground,0,0,530,675,540,x,y+530);
	}
}

//drawheadings
draw_set_font(spr_main_font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_gray);

//was draw end

//defense minigames
draw_text(box_x_square-20,y+bg_y_curr,_layout);
draw_sprite(sPlatformBg,0,box_x_square,y+bg_y_curr); //bg	
	with(oTarget) if(!attack or currDistance!=attackDistance) draw_self();
	if(instance_exists(oDefenseChar)) with(oDefenseChar) draw_self();

//bottom bg slice
draw_sprite_part(battleBackground,0,0,530,675,540,x,y+530);
draw_set_alpha(oDayNightManager.darkness);
var c=oDayNightManager.lightColor;
draw_rectangle_color(x,y+530,x+675,y+540,c,c,c,c,0);
draw_set_alpha(1);

//darken
if(selectedItem!=-1){
	darkAlpha=min(darkAlpha+0.03,0.5);
}else{
	darkAlpha=max(darkAlpha-0.03,0);
}
draw_set_alpha(darkAlpha);
draw_set_color(c_black);
draw_rectangle(global.camx-10,global.camy-10,global.camx+global.camw+10,global.camy+global.camh+10,0);
draw_set_alpha(1);

//characters
with(oBattleUnitPC){
	draw_self();

	var _hp = ceil((hp/hpMax)*38);
	var _mp = ceil((mp/mpMax)*38);
	trickleHp=lerp(trickleHp,_hp,0.05)-0.01;
	trickleMp=lerp(trickleMp,_mp,0.05)-0.01;

	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	
	//alpha
	if(other.selectedItem==-1 or partyNum==other.invChar){
		draw_set_alpha(1);
		image_alpha=1;
	}else{
		draw_set_alpha(0.5);
		image_alpha=0.5;
	}

	//hlth
	draw_sprite(sHealthbar,3,x-64,y+66);  
	for(var i=0; i<trickleHp; i++){ //trickle part
		draw_sprite(sHealthbar,2,x-64+(i*3),y+66); 
	}
	for(var i=0; i<_hp; i++){ //actual part
		draw_sprite(sHealthbar,1,x-64+(i*3),y+66); 
	}
	draw_sprite(sHealthbar,0,x-64,y+66);  
	draw_text_transformed(x-51,y+66,string(hp) + "/" + string(hpMax),0.5,0.5,0);

	//mp
	draw_sprite(sMagicbar,3,x-64,y+81);
	for(var i=0; i<trickleMp; i++){ //trickle part
		draw_sprite(sMagicbar,2,x-64+(i*3),y+81); 
	}
	for(var i=0; i<_mp; i++){
		draw_sprite(sMagicbar,1,x-64+(i*3),y+81);
	}
	draw_sprite(sMagicbar,0,x-64,y+81);
	draw_text_transformed(x-51,y+81,string(mp) + "/" + string(mpMax),0.5,0.5,0);

	draw_set_alpha(1);
	//portrait
	if(instance_exists(oPortraitExpression)){
		with(oPortraitExpression) image_index=other.image_index;
		with(oPortraitExpression) draw_self();
	}

	//borders
	if(other.selectedItem==-1){
		if(hp<=0){
			draw_sprite(sCombatBorder,2,x,y);
		}else if(oBattle.currentUser.id==id and array_length(oBattle.playerMoves)!=array_length(global.party)){
			draw_sprite(sCombatBorderCurrent,oBattle.borderSprite,x,y);
			oBattle.borderSprite+=0.1;
		}else{
			draw_sprite(sCombatBorder,0,x,y);
		}
	}
	
	draw_set_alpha(1);
}

if(instance_exists(oAttackEffect)){
	with(oAttackEffect) draw_self();
}

