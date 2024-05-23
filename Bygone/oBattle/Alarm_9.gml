/// @description end platform game

defense=false;
moveBoxUp=false;
textShowing=true;
instance_destroy(oDefenseChar);

text_attacker=currentUser.name;
text_target=playerTarget.name;
with(obj_textbox){
	num++;
	if(num>=4) instance_destroy();
}
create_textbox("combat");

alarm[0]=battleWaitTimeFrames; //next round

if(instance_exists(oPortraitScared)){
	with(oPortraitScared) instance_destroy();
}


slider=false;
