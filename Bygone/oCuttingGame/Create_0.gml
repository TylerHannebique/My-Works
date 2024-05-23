sliderX=0;
invisibleSliderX=0;
sliderMax=sprite_get_width(sCookingMeter);
//sliderSpeed=(sprite_get_width(sCookingMeter)*2-12)/150;
sliderSpeed=(sprite_get_width(sCookingMeter)*2-12)/300;

moveSlider=false;
moveKnife=false;
moveInvisSlider=false;

//sliderY=global.camh+260;
sliderY=global.camh/2+130;

knifeX=0;
knifeOffset=0;
resetKnife=false;
swipe=false;
swipeSpeed=0

//carrotXstart=1000;
carrotXstart=500;
carrotX=0;
moveInCarrot=false;

canDeleteBeats=false;

carrotCuts=[
{
	startX: 0,
	endX: 180,
	xOffset: 0,
	yOffset: 0,
	yVel: 0,
}];

beatList=[
[30,30,30,30],
[30,15,15,30,30],
[30,15,30,15,30],
[15,15,15,15,30,30],

[60,15,15,30],
[30,15,15,15,15,30],
[15,15,30,30,15,15],
[45,45,15,15],

[15,15,30,8,8,15,15],
[23,8,15,15,15,15,15],
[30,15,15,8,8,8,8,8],
[8,15,8,15,15,15,15,15],

[30,8,8,15,15,8,8,15],
[15,8,15,15,8,15,8,15,15],
[8,15,8,15,8,15,8,15,15],
[15,8,8,45,8,8,8],

[23,23,23,23,8,8],
[8,8,8,8,15,15,8,8,8,8,30],
[15,15,15,15,10,10,10,10],
[23,8,15,23,8,15,15],

[30,30,30,30],
[30,15,15,30,30],
//[45,8,22,15,8,8],
//[15,30,15,8,22,8],
]

counts=[0,0,0,0,0,0];

beatIndex=0;
beatNumber=0;

cookingSong=noone;