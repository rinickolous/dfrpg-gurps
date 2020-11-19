function onInit()
	addTrait_old = ActorManager2.addTrait;
	updatePointsTotal_old = ActorManager2.updatePointsTotal;
	
	ActorManager2.addTrait = addTrait;
	ActorManager2.updatePointsTotal = updatePointsTotal;
end

function addTrait(nodeChar, nodeTrait)
	if not nodeChar or not nodeTrait then  
		return false;
	end
 
	local bAdvantage = LibraryDataGURPS4e.isAdvantage(nodeTrait);
	local bDisadvantage = LibraryDataGURPS4e.isDisadvantage(nodeTrait);
	local bQuirk = LibraryDataGURPS4e.isQuirk(nodeTrait);

	if not (bAdvantage or bDisadvantage or bPerk or bQuirk) then
		return false;
	end

	local sActorType, nodeActor = ActorManager.getTypeAndNode(nodeChar);
	if sActorType ~= "pc" then
		local nodeNPCTraits = DB.getChild(nodeChar, "traits");
		if not nodeNPCTraits then
			nodeNPCTraits = DB.createChild(nodeChar, "traits");
		end
		
		local traits = DB.getValue(nodeNPCTraits,"description","");  
		if not (traits == nil or traits == "") then
			traits = traits .. ", ";
		end
		traits = traits .. DB.getValue(nodeTrait,"name","");

		DB.setValue(nodeNPCTraits, "description", "string", traits);  

		return true;
	end

	if bAdvantage then
		local nodeAdvantageList = DB.getChild(nodeChar, "traits.adslist");
		if not nodeAdvantageList then
			nodeAdvantageList = DB.createChild(nodeChar, "traits.adslist");
		end

		local nodeAdvantage = DB.createChild(nodeAdvantageList);
		DB.setValue(nodeAdvantage, "name", "string", DB.getValue(nodeTrait,"name",""));  
		DB.setValue(nodeAdvantage, "points", "number", DB.getValue(nodeTrait,"points",0));
		DB.setValue(nodeAdvantage, "text", "formattedtext", DB.getValue(nodeTrait,"text",""));

		return true;
	end

	if bDisadvantage then
		local nodeDisadvantageList = DB.getChild(nodeChar, "traits.disadslist");
		if not nodeDisadvantageList then
			nodeDisadvantageList = DB.createChild(nodeChar, "traits.disadslist");
		end

		local nodeDisadvantage = DB.createChild(nodeDisadvantageList);
		DB.setValue(nodeDisadvantage, "name", "string", DB.getValue(nodeTrait,"name",""));  
		DB.setValue(nodeDisadvantage, "points", "number", DB.getValue(nodeTrait,"points",0));
		DB.setValue(nodeDisadvantage, "text", "formattedtext", DB.getValue(nodeTrait,"text",""));

		return true;
	end
	
	if bQuirk then
		local nodeQuirkList = DB.getChild(nodeChar, "traits.quirkslist");
		if not nodeQuirkList then
			nodeQuirkList = DB.createChild(nodeChar, "traits.quirkslist");
		end

		local nodeQuirk = DB.createChild(nodeQuirkList);
		DB.setValue(nodeQuirk, "name", "string", DB.getValue(nodeTrait,"name",""));  
		DB.setValue(nodeQuirk, "points", "number", DB.getValue(nodeTrait,"points",0));
		DB.setValue(nodeQuirk, "text", "formattedtext", DB.getValue(nodeTrait,"text",""));

		return true;
	end

	return false;
end

function updatePointsTotal(nodeChar)
	local sActorType, nodeActor = ActorManager2.getTypeAndRootNode(nodeChar);
	if sActorType ~= "pc" then
		return;
	end

	if sActorType == "pc" then
	  local total = 0;
	  local temp = 0;
	  local tempquirks = 0;
	  local tempdisadvantages = 0;

	  local attributes = {};
	  table.insert(attributes, DB.getValue(nodeActor,"attributes.strength_points",0));
	  table.insert(attributes, DB.getValue(nodeActor,"attributes.dexterity_points",0));
	  table.insert(attributes, DB.getValue(nodeActor,"attributes.intelligence_points",0));
	  table.insert(attributes, DB.getValue(nodeActor,"attributes.health_points",0));
	  table.insert(attributes, DB.getValue(nodeActor,"attributes.hitpoints_points",0));
	  table.insert(attributes, DB.getValue(nodeActor,"attributes.will_points",0));
	  table.insert(attributes, DB.getValue(nodeActor,"attributes.perception_points",0));
	  table.insert(attributes, DB.getValue(nodeActor,"attributes.fatiguepoints_points",0));
	  table.insert(attributes, DB.getValue(nodeActor,"attributes.basicspeed_points",0));
	  table.insert(attributes, DB.getValue(nodeActor,"attributes.basicmove_points",0));
	  table.insert(attributes, DB.getValue(nodeActor,"traits.tl_points",0));
  
	  for _,value in pairs(attributes) do 
		temp = temp + value;
		if value < 0 then
		  tempdisadvantages = tempdisadvantages + value;
		end
	  end

	  DB.setValue(nodeActor,"pointtotals.attributes","number",temp);

	  total = total + temp;
	  temp = 0;

	  for _,node in pairs(DB.getChildren(nodeActor,"traits.culturalfamiliaritylist")) do
		temp = temp + DB.getValue(node,"points",0);
	  end

	  for _,node in pairs(DB.getChildren(nodeActor,"traits.languagelist")) do
		temp = temp + DB.getValue(node,"points",0);
	  end

	  for _,node in pairs(DB.getChildren(nodeActor,"traits.adslist")) do
		temp = temp + DB.getValue(node,"points",0);
	  end
	  DB.setValue(nodeActor,"pointtotals.ads","number",temp);

	  total = total + temp;
	  temp = 0;

	  for _,node in pairs(DB.getChildren(nodeActor,"traits.disadslist")) do
		temp = temp + DB.getValue(node,"points",0);
	  end
	  DB.setValue(nodeActor,"pointtotals.disads","number",temp);

	  total = total + temp;
	  temp = 0;
	  
	  for _,node in pairs(DB.getChildren(nodeActor,"traits.quirkslist")) do
		temp = temp + DB.getValue(node,"points",0);
	  end
	  DB.setValue(nodeActor,"pointtotals.quirks","number",temp);

	  total = total + temp;
	  temp = 0;
  
	  for _,node in pairs(DB.getChildren(nodeActor,"abilities.skilllist")) do
		temp = temp + DB.getValue(node,"points",0);
	  end
	  DB.setValue(nodeActor,"pointtotals.skills","number",temp);

	  total = total + temp;
	  temp = 0;

	  for _,node in pairs(DB.getChildren(nodeActor,"abilities.spelllist")) do
		temp = temp + DB.getValue(node,"points",0);
	  end
	  DB.setValue(nodeActor,"pointtotals.spells","number",temp);

	  total = total + temp;
	  temp = 0;
 
	  for _,node in pairs(DB.getChildren(nodeActor,"abilities.otherlist")) do
		temp = temp + DB.getValue(node,"points",0);
	  end
	  DB.setValue(nodeActor,"pointtotals.others","number",temp);

	  total = total + temp;

	  DB.setValue(nodeActor,"pointtotals.totalpoints","number",total);
	end
end