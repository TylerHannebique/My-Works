 /// @description loop through player actions
slider=0;
textShowing=true;

//textbox work
text_attacker=playerMoves[playerAttackIndex][0].name;
text_target=playerMoves[playerAttackIndex][2][0].name;
text_item=playerMoves[playerAttackIndex][1].name;
with(obj_textbox){
	num++;
	if(num>=4) instance_destroy();
}

if(playerMoves[playerAttackIndex][3]==-1){
	playerMoves[playerAttackIndex][1].effect(playerMoves[playerAttackIndex][2][0]);
	create_textbox("combatItem");
}else if(enemyHpBeforeAttack<=0 or sliderFail or sliderMiss){
	create_textbox("combatFail");
}else create_textbox("combat");
	
playerAttackIndex++;
var aliveEnemies=[]; 
for(var i=0; i<array_length(enemyUnits); i++){
	if(enemyUnits[i].hp>0) array_push(aliveEnemies,enemyUnits[i]);
}
if(array_length(aliveEnemies)>0){
	alarm[4]=battleWaitTimeFrames;
}else alarm[6]=100; //end battle if no enemies left



