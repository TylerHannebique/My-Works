
if(global.camx+global.camw/2-(sprite_get_width(sCookingMeter)/2)+3+oCuttingGame.sliderX>x+35 and oCuttingGame.canDeleteBeats){
	instance_destroy();
	instance_create_depth(global.camx+125+oCuttingGame.sliderX,global.camy+global.camh/2+85,depth-9999999999,oBattleFloatingText,{font: spr_main_font, col: #b93864, text: "miss"});
	oCuttingGame.counts[5]++;
}





