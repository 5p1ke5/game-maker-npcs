/// @function npc_initialize(_name, _Text)
/// @description initializes NPC variables.
/// @param _name the name of the NPC. Will also be put in the text box.
/// @param _text the text that will be put in the npcs speech balloon.
/// @param _level How quickly the NPC reacts. Lower is stronger, with 0 being strongest. 100 is easy.
/// @param _npcState npcState struct. Should be initialzed with the NPCState constructor and the correct npcStates. enum
function npc_initialize(_name, _text, _level, _npcState)
{
	name = _name;
	text = _text;
	level = _level;

	//This will contain a reference to any dialogue balloon the NPC creates.
	//If it equals noone the NPC has no created dialogue balloons.
	myBalloon = noone;
	
	//What the NPC is trying to do. Think of it as what they have instead of controller input.
	state = _npcState;
	
	//List of other npcs being sensed.
	senseList = ds_list_create();
	
	//List of enemies that have been sensed. If not empty is engaging enemies in combat.
	senseListEnemies =  ds_list_create();
	
	//Timers. -1 means they've already 'rung' and are inactive.
	attackTimer = -1;
	
	print(_name);
}

/// @function npc_behavior()
/// @description Changes NPC state based on the character being targetted. Returns the final state.
function npc_behavior()
{
	//Updates lists of sensed npcs.
	npc_sense_actors();
	
	//increment timers
	if (attackTimer > -1)
	{
		attackTimer--;
	}

	//Dealing with enemies usually state.
	//This can itself be overriden if the unit is in certain states.
	if (ds_list_size(senseListEnemies) > 0) 
	&&  (instanceof(state) != "NPCStateMove")
	{
		npc_fight(ds_list_find_value(senseListEnemies, 0));
	}
	else //Otherwise performs state action as ordered.
	{
		state.Perform(id)	
	}
}


/// @function npc_sense_actors()
/// @description Gets a list of all objects within range of the NPC, adds them to senseList and senseListEnemies.
function npc_sense_actors()
{
	//Resets lists
	senseList = ds_list_create();
	senseListEnemies =  ds_list_create();
	
	//Adds sensed NPCs to the list + player.
	var _npcsFound = collision_circle_list(x, y, CLOSE_RANGE, abs_doll, false, true, senseList, true);
	
	//Add sensed enemies to the list of sensed enemies.
	for (var _i = 0; _i < _npcsFound; _i++)
	{
		var _npc = ds_list_find_value(senseList, _i);
		
		//enemyFaction vs playerFaction and neutral faction.
		if (faction != factions.enemy) //If the calling npc is an enemy.
		{
			if (_npc.faction == factions.enemy)
			{
				ds_list_add(senseListEnemies, _npc);
			}
		}
		else //If the calling npc is a player or neutral.
		{
			if (_npc.faction == factions.player) || (_npc.faction == factions.neutral)
			{
				ds_list_add(senseListEnemies, _npc);
			}
		}
	}
	
}

///@function NPCState(_state, _target) constructor
///@description struct that describes the current state of the NPC associated with it. Children define specific states below.
///@param _target reference to a variable holding an object or a point struct, depending on current state.
function NPCState( _target) constructor
{
	target = _target;
	
	//Performs whatever action the state is associated with. Should usually be overwritten.
	static Perform = function(_user)
	{
		print(target);
	}
}

///@function NPCStateFollow(_target): NPCState(_target) constructor
///@description state for when NPC is following an object (usually another doll.)
///@param _target reference ot an object to follow.
function NPCStateFollow(_target): NPCState(_target) constructor
{
	static Perform = function(_user)
	{
		
		var _target = target;
		with (_user)
		{
			var _hDir = 0;
			var _vDir = 0;
			
			if (distance_to_object(_target) > CLOSE_RANGE)
			{
				_hDir = sign(_target.x - x);
				_vDir = sign(_target.y - y);
			}
			
			doll_movement(_hDir, _vDir);
		}
	}
}

///@function NPCStateIdle(_target): NPCState(_target) constructor
///@description state for when NPC is idle. Just makes them sort of mill about.
///@param _target Point2 that refers to the NPC's home area (unimplimented cna just be null).
function NPCStateIdle(_target): NPCState(_target) constructor
{
	//How long the NPC waits between switching between standing still and moving around.
	passiveTimer = -1;
	
	//Directions the state is telling the NPC to move to. If both are 0 just doesn't move.
	stateHDir = 0;
	stateVDir = 0;
	
	static Perform = function(_user)
	{
		//Increments timer, makes doll move in chosen direction.
		if (passiveTimer > -1)
		{
			passiveTimer--;
			
			var _hDir = stateHDir;
			var _vDir = stateVDir;
			with (_user)
			{
				doll_movement(_hDir, _vDir);
			}
		}
		else
		{
			//Reset timer.
			passiveTimer = PASSIVE_TIME;
			
			//Either picks a new direction to move in or stays still till timer goes off next.
			var _move = choose(true, false);
			if (_move)
			{
				//Might need to set to irandom.
				stateHDir = irandom_range(-1, 1);
				stateVDir = irandom_range(-1, 1);
			}
			else
			{
				stateHDir = 0;
				stateVDir = 0;
			}
		}
	}
}

///@function NPCStateMove(_target): NPCState(_target) constructor
///@description state for when NPC is moving towards a given point.
///@param _target Point2 for the target to move towards.
function NPCStateMove(_target): NPCState(_target) constructor
{
	static Perform = function(_user)
	{
		//Moves towards target point until right at it.
		var _target = target;
		with (_user)
		{
			var _hDir = 0;
			var _vDir = 0;
			
			if (distance_to_point(_target.x, _target.y) > CLOSE_RANGE)
			{
				_hDir = sign(_target.x - x);
				_vDir = sign(_target.y - y);
			}
			
			doll_movement(_hDir, _vDir);
		}
	}
}


	//TODO: Test this
	
///@function NPCStateAttack(_target): NPCState(_target) constructor
///@description state for when NPC has been ordered to attack a target. The target can be on object or Point2.
///@param _target Point2 or object. If a Point2 moves towards point, attacks enemies there and along the way. If Object only attempts to attack target.
function NPCStateAttack(_target): NPCState(_target) constructor
{
	static Perform = function(_user)
	{
		var _target = target;
		
		with (_user)
		{
			var _hDir = 0;
			var _vDir = 0;
			
			if (distance_to_point(_target.x, _target.y) > LONG_RANGE)
			{
				_hDir = sign(_target.x - x);
				_vDir = sign(_target.y - y);
				doll_movement(_hDir, _vDir);
			}
			else
			{
				//If _target is not a struct (so an enemy object)
				if (instanceof(_target) == undefined)
				{
					npc_fight(_target)
				}
			}
			
			
			
		}
	}
}


/// @function npc_speak(_text)
/// @description generates a speech balloon for the npc.
/// @param _text The text to be put in the balloon.
function npc_speak(_text)
{

	//Creates speech balloon object.
	var _name = name;
	
	draw_set_font(fnt_speech);
	var _balloonHeight = string_height_ext(_text, string_height(_text), TEXT_BALLOON_MAXW);
	draw_set_font(fnt_default);
	
	var _balloon = instance_create_depth(x, y - 32 - _balloonHeight, depth, obj_speechBalloon);
	with (_balloon)
	{
		speechBalloon_initialize(_text, string_length(_text) * TEXT_BALLOON_SPEED, other, _name);
	}
	
	return _balloon;
}


/// @function npc_fight(_target)
/// @description NPC behavior when they're targetting an enemy. Causes them to pursue and cast spells at the target.
/// @param _target The target the npc is attacking.
function npc_fight(_target)
{
		//If has items in inventory sends the selected item to the state machine to decide behavior from there.
		if (ds_list_size(inventory) > 0)
		{
			var _item = inventory[|inventoryIndex];
			npc_fight_itemUse(_item, _target)
		}
		
		//If unarmed runs away.
		else
		{
			doll_movement( sign(_target.x - x), -sign(_target.y - y));
		}
}

/// @function npc_fight_itemUse(_item, _target)
/// @description Decides how to behave in a fight based on passed item.
/// @param _item Item currently selected at intentoryIndex.
/// @param _target Instance being attacked.
function npc_fight_itemUse(_item, _target)
{
	var _ai = _item.GetAI();
	var _dist = point_distance(x, y, _target.x, _target.y);
	
	//Does different things depending on item type.
	switch (_ai) 
	{
	    case aiType.melee: 
			//Approaches, attacks when in range.
			var _range = (sprite_get_bbox_right(_item.sprite) - sprite_get_bbox_left(_item.sprite)) * 2;
			
			if (_dist > _range) 
			{
				doll_movement(sign(_target.x - x), sign(_target.y - y));
			}
			else if (!instance_exists(myHeld)) 
			{
				if (attackTimer < 0)
				{
					angle = point_direction(x, y, _target.x, _target.y);
					_item.Use(id);
					attackTimer = (_item.arc / _item.spd) + irandom_range( round(sqrt(level)), level);
				}
			}
	        break;
			
	    default: //Tries to run away.
				doll_movement(-sign(_target.x - x), -sign(_target.y - y));
	        break;
	}
}

/// @function speechBalloon_initialize(_text, _time, _owner, _name) 
/// @description Creates a specch balloon object.
/// @param _text The text that will be displayed.
/// @param _time The amount of time for which the balloon will exist.
/// @param _owner The instance that created this object.
/// @param _name The name of the npc that created this balloon.
function speechBalloon_initialize(_text, _maxTime, _owner, _name) 
{

	text = _text;
	maxTime = _maxTime;
	time = maxTime;
	owner = _owner;
	name = _name;
}


//enums
enum npcStates
{
	idle, move, attack, defend, follow, passive
}