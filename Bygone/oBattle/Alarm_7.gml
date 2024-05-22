/// @description platforms/player

moveBoxUp=true;
instance_create_depth(global.camx+global.camw/2-2,UIYcenter-28,-999999,oDefenseChar,{sprite_index: playerTarget.sprites.jump});
alarm[8]=60;
enemyAttacksRemaining=2;


with(playerTarget){
	instance_create_depth(x,y,-9999999,oPortraitScared,{sprite_index: sprites.scared, base: id});
}

//picklayout
_layout=irandom_range(0,7);
global.defenseLayout=global.defenseLayouts[_layout];
