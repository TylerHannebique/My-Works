//transition
draw_set_color(c_black);
draw_rectangle(global.camx,global.camy,global.camx+global.camw,global.camy+transHeight,0);
draw_rectangle(global.camx,global.camy+global.camh,global.camx+global.camw,global.camy+global.camh-transHeight,0);
if(transTarg==0){
	transHeight=lerp(transHeight,transTarg,0.15);
}else transHeight+=40;

