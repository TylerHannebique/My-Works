instance_destroy(oBattleUnit);
instance_destroy(obj_textbox);
instance_destroy(creator);

//add item rewards to inventory

for(var i=0; i<array_length(oGlobalManager.newItemList); i++){
	var _index=itemInArray(oGlobalManager.newItemList[i],global.inventoryList);
	if(_index!=-1){ 
		global.inventoryList[_index].count+=oGlobalManager.newItemList[i].count;
	}else{
		array_push(global.inventoryList,{listItem: oGlobalManager.newItemList[i].listItem, count: 1});
	}
}

