draw_set_alpha(darkness);
var c=lightColor;
if(array_contains(global.outside,room) and !instance_exists(oBattle)){
	draw_rectangle_color(oCameraManager._camX,oCameraManager._camY,oCameraManager._camX+global.camw,oCameraManager._camY+global.camh,c,c,c,c,0);
}
draw_set_alpha(1);