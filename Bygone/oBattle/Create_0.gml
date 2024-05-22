//instance_deactivate_all(true);
randomize();

audio_play_sound(combatSong,500,1,global.master_vol * global.music_volume);

units = [];
turn = 0;
enemyIndex=0;

unitTurnOrder = [];
unitRenderOrder = [];
turnCount = 0;
roundCount = 0;
switch(global.pos_system_0){
	case 0: battleWaitTimeFrames = 144; break;
	case 1: battleWaitTimeFrames = 90; break;
	case 2: battleWaitTimeFrames = 75; break;
	case 3: battleWaitTimeFrames = 56; break;
}
battleText = "";
currentUser = noone;
currentAction = -1;
currentTargets = noone;

playerMoves=[];

playerAttackIndex=0;

text_attacker="bruh";
text_dmg="1";
text_target="bruh";

attack=false;

attackSub=false;
attackIndex=0;

skills=false;
skillIndex=0;
selectedSkill=noone;

environment=false;
environmentIndex=0;

playerControl=true;

cam_x=camera_get_view_x(view_camera[0]); //left edge of screen
cam_y=camera_get_view_y(view_camera[0]); //top edge of screen
cam_w=camera_get_view_width(view_camera[0]); //width of screen
cam_h=+camera_get_view_height(view_camera[0]); //height of screen

//Make party
for (var i = 0; i < array_length(global.party); i++)
{
	//place party
	var corner_buffer=70;
	switch(i){
		case 0: //top left
			var cx=cam_x+corner_buffer;	
			var cy=cam_y+corner_buffer;
			break;
		case 1: //top right
			var cx=cam_x+cam_w-corner_buffer;	
			var cy=cam_y+corner_buffer;
			break
		case 2: //bottom right
			var cx=cam_x+cam_w-corner_buffer;	
			var cy=cam_y+248;
			break;
		case 3: //bottom left
			var cx=cam_x+corner_buffer;	
			var cy=cam_y+248;
			break;
	}
	
	partyUnits[i] = instance_create_depth(cx, cy, depth-10, oBattleUnitPC, global.party[i]);
	with(partyUnits[i]) partyNum=i;
	//var _tx=(cam_x+(cam_w/2))-201+(i*134);
	//var _ty=cam_y+corner_buffer;
	//with(partyUnits[i]){
	//	invX=_tx;
	//	invY=_ty;
	//}
	array_push(units, partyUnits[i]);
}

inventory=false;
selectedItem=-1;
darkAlpha=0;
pMatrix=
[[0,1],
 [3,2]];
invPX=0;
invPY=0;
invChar=0;

//Make enemies
var buffer=100; //distance between enemies
var range=array_length(enemies)*buffer; //range of enemy space
var middle=cam_x+(cam_w/2); //middle x of the screen
var start=middle-range/2+(buffer/2); //placement of first enemy
var enemy_y = cam_y+(cam_h/2); //middle y of the screen
for (var i = 0; i < array_length(enemies); i++)
{
	//place of the enemies
	var enemy_x=start+(buffer*i); //variable for placement of each enemy
		
	enemyUnits[i] = instance_create_depth(enemy_x, enemy_y, depth-10, oBattleUnitEnemy, enemies[i]);
	enemyUnits[i].lvl=lvls[i];
	array_push(units, enemyUnits[i]);
}

//shuffle turn order
//unitTurnOrder = array_shuffle(units);
unitTurnOrder=units;

//Get Render Order
RefreshRenderOrder = function()
{
	unitRenderOrder = [];
	array_copy(unitRenderOrder,0,units,0,array_length(units));
	array_sort(unitRenderOrder,function(_1, _2)
	{
		return _1.y - _2.y;
	});
}

RefreshRenderOrder();

//Make buttons
function MainButtons(){
	UIXcenter=cam_x+(cam_w/2);
	UIYcenter=cam_y+475;
	OXoffset=90;
	OYoffset=23;
	instance_create_depth(UIXcenter-OXoffset,UIYcenter-OYoffset,-99999999,oBattleOption,{option: "Attack", row: 0, col: 0});
	instance_create_depth(UIXcenter+OXoffset,UIYcenter-OYoffset,-99999999,oBattleOption,{option: "Food", row: 0, col: 1});
	instance_create_depth(UIXcenter-OXoffset,UIYcenter+OYoffset,-99999999,oBattleOption,{option: "Skills", row: 1, col: 0});
	instance_create_depth(UIXcenter+OXoffset,UIYcenter+OYoffset,-99999999,oBattleOption,{option: "Environment", row: 1, col: 1});
}

function BeginAction(_user,_action,_targets)
{
	currentUser = _user;
	currentAction = _action;
	currentTargets = _targets;
	if(currentUser.enemy){
		currentAction.func(currentUser, currentTargets, 1);
	}else currentAction.func(currentUser, currentTargets, 0);
	
}

currentUser=unitTurnOrder[turn];
function BattleStartPlayerTurn(){
	MainButtons();
	instance_destroy(obj_textbox);
	playerControl=true;
	attack=false;
	borderSprite=0;
}
BattleStartPlayerTurn();

playerTarget=0;
function BattleNextTurn(){  
	KillPlayers();
	turn++;
	turnCount++;
	attack=false;
	skills=false;
	environment=false;
	attackSub=false;
	enemyIndex=0;
	box_r=0;
	box_c=0;
	textShowing=false;
//Loop turns
	if (turn > array_length(unitTurnOrder) -1){
		turn = 0;
		roundCount++;
		
		for(var i=0; i<array_length(enemyUnits); i++){
			decreaseAllEffects(enemyUnits[i]);
		}
		//for(var i=0; i<array_length(partyUnits); i++){
		//	decreaseAllEffects(partyUnits[i]);
		//}
	}
	currentUser=unitTurnOrder[turn];
	if(unitTurnOrder[turn].enemy){
		
		//defense minigame
		defense=true;
		with(oBattleUnit)effectFrame=0;
		alarm[7]=12;
		audio_play_sound(sfx_battle_bertha_box_open,99,false,global.master_vol * global.sfx_volume)
		var _enemyAction = currentUser.AIscript();
		playerTarget=_enemyAction[1];

}else if(array_length(playerMoves)<array_length(partyUnits)){
		alarm[1]=1; //start player turn
		
		instance_destroy(obj_textbox);
	}
}

function DamageEnemy(){
	//deal damage
	enemyHpBeforeAttack = playerMoves[playerAttackIndex][2][0].hp;
	BeginAction(playerMoves[playerAttackIndex][0], playerMoves[playerAttackIndex][1], playerMoves[playerAttackIndex][2]);
	partyUnits[playerAttackIndex].mp-=playerMoves[playerAttackIndex][1].mpCost;
	//effect
	instance_create_depth(playerMoves[playerAttackIndex][2][0].x,playerMoves[playerAttackIndex][2][0].y,-999999,oAttackEffect,{sprite_index: sAttackedPunch, image_xscale: choose(-1,1)});
}

function KillEnemies(){
	with(oBattleUnitEnemy){
		if(hp<=0){
			for(var i=0; i<array_length(oBattle.enemyUnits); i++){
				if(oBattle.enemyUnits[i].id==id){
					array_delete(oBattle.enemyUnits,i,1);
					break;
				}
			}
		
			for(var i=0; i<array_length(oBattle.unitTurnOrder); i++){
				if(oBattle.unitTurnOrder[i].id==id){
					array_delete(oBattle.unitTurnOrder,i,1);
					break;
				}
			}
		}
	}
}

function KillPlayers(){
	with(oBattleUnitPC){
		if(hp<=0 and !ded){
			other.turn--;
			ded=true;
			if(name=="Shin") oBattle.alarm[6]=1;
			for(var i=0; i<array_length(oBattle.partyUnits); i++){
				if(oBattle.partyUnits[i].id==id){
					array_delete(oBattle.partyUnits,i,1);
					break;
				}
			}
		
			for(var i=0; i<array_length(oBattle.unitTurnOrder); i++){
				if(oBattle.unitTurnOrder[i].id==id){
					array_delete(oBattle.unitTurnOrder,i,1);
					break;
				}
			}
		}
	}
}

//UI stuff
box_w_start=cam_w-268;
box_w_curr=box_w_start;
box_w_full=cam_w-12;
box_w_text=cam_w-200;
box_w_close=0;
box_w_square=cam_w-360;

box_x_start=cam_x+134;
box_x_curr=box_x_start;
box_x_full=cam_x+6;
box_x_text=cam_x+100;
box_x_close=cam_x+cam_w/2;
box_x_square=cam_x+180;

box_h_start=112;
box_h_curr=box_h_start;
box_h_square=160;

box_y_start=418;
box_y_curr=box_y_start;
box_y_square=540;
grey_y_curr=box_y_start;
grey_y_square=370;


bg_y_start=550;
bg_y_curr=bg_y_start;
bg_y_end=360;

moveBoxUp=false;
textShowing=false;

box_r=0;
box_c=0;


mid_line_start=0;
mid_line_curr=mid_line_start;
mid_line_full=106;
mid_line_c=c_white;

enemyHpInit=false;
enemyHpBeforeAttack=0;

borderSprite=0;

//attack minigames
slider=false;
sliderX=0; //distance of slider on meter
sliderActive=0; //whether or nor the slider is moving
sliderDir=1; //direction of slider
sliderIndex=0; //which character the minigame effects
sliderShake=0; 
sliderSpeed=12;
sliderFail=0; 
sliderMiss=0;
sliderControl=0;
minigameTimer=0;
damageOutputs=[]; //array of resulting fractions

greenX=0; //location of random green part

//defense minigames
defense=false;
moveBoxUp=false;

global.defenseLayouts=[
[1,3,4,5,7], //plus - 0
[0,1,4,7,8], //z - 1
[1,2,4,6,7], //s - 2
[0,1,2,4,6,7,8], //I - 3
[0,2,3,4,5,6,8], //H - 4
[0,1,3,4,5,7,8], //no top right/bottom left - 5
[1,2,3,4,5,6,7], //no top left bottom right - 6
[0,1,2,3,4,5,6,7,8] //all - 7
]
_layout=0;

function existsTargetAlready(_i){
	with(oTarget){
		//if(n==_i and currDistance!=attackDistance) return true;
		if(n==_i) return true;
	}
	return false;
}

function findChar(i){
	with(oBattleUnitPC){
		if(i==partyNum) return id;
	}
}

inventoryIndex=0;

arrow=0;
minigame=0;

//transition
transHeight=global.camh/2;
transTarg=0;

effectFrameSwitch=6;
effectFrame=0;

sfx_played_minigame = false

//xp
enemyXp=0;
damageBonuses=[0,0,0,0];

function getCritical(_x){
	var _r=random_range(1,100);
	return _r<=_x;
	//return _r>50;
}