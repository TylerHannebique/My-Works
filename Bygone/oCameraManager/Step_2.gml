/// @description 
// Follow player
if (cameraFollow) {
	
	// Get new position for camera
	var camX;
	var camY;
	if(!instance_exists(oCombatTransition) and !instance_exists(oBattle)){
		_camX = lerp(_camX, target.x - camW / 2, 0.2);
		_camY = lerp(_camY, target.y - camH / 2, 0.2);
	}else{
		_camX = target.x - camW / 2;
		_camY = target.y - camH / 2;
	}
	
	//Apply Shake
	if(screenShake>0){
		_camX += random_range(-shakeIntensity,shakeIntensity);
		_camY += random_range(-shakeIntensity,shakeIntensity);
		camera_set_view_angle(camera,random_range(-shakeIntensity,shakeIntensity)*0.5)
	}else camera_set_view_angle(camera,0);
	screenShake--;
	
	// Clamp position to room
	_camX = clamp(_camX, 0, room_width - camW);
	_camY = clamp(_camY, 0, room_height - camH);
	
	// Set position and size
	camera_set_view_size(camera, camW, camH);
	camera_set_view_pos(camera, _camX, _camY);
}