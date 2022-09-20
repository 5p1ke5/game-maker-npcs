/// @function doll_initialize(_maxHP, _hp, _maxPP, _pp, _faction, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor) 
/// @description initializes variables for a doll object.
/// @param _maxHP maximum hp for this doll.
/// @param _hp current hp
/// @param _maxPP maximum pp for this doll.
/// @param _pp current pp
/// @param _faction Faction the unit is a member of.
/// @param _faceIndex image_index from spr_faces to draw.
/// @param _hairIndex image_index from spr_hairs to draw.
/// @param _shirtIndex image_index from spr_shirts to draw.
/// @param _pantsIndex image_index from spr_pants to draw.
/// @param _skinColor color value for sprites image_blend.
/// @param _hairColor color value to blend hair with.
/// @param _shirtColor color value to blend shirt with.
/// @param _pantsColor color value to blend pants with.
function doll_initialize(_maxHP, _hp, _maxPP, _pp, _faction, _faceIndex, _hairIndex, _shirtIndex, _pantsIndex, _skinColor, _hairColor, _shirtColor, _pantsColor) 
{
	//Initializes instance variables.
	living_initialize(_maxHP, _hp);
	
	//For now at 100 but will likely remove later.
	maxPP = _maxPP;
	pp = _pp;
	
	//Faction unit is a member of. should be of form faction.whatever
	faction = _faction;
	
	//todo: These should read from macros
	standSprites = [spr_doll, spr_dollUp];
	walkSprites = [spr_dollWalk, spr_dollWalkUp];
	
	//todo: These should read from params
	faceIndex = _faceIndex;
	hairIndex = _hairIndex;
	shirtIndex = _shirtIndex;
	pantsIndex = _pantsIndex;
	
	image_blend = _skinColor;
	hairColor = _hairColor;
	shirtColor = _shirtColor;
	pantsColor = _pantsColor;
	

	//initialize physics.
	phys_initialize(DOLL_FRICT, 0, 0, true);

	//Sprites. These ones are changed on the fly based on whether running or jumping.
	inventory = inventory_initialize();

	//The item  currently being selected from inventory
	inventoryIndex = 0;
	
	//The angle the spell is being cast at. If no item is being used it is -1.
	angle = -1;

	//How fast the player can accelerate. Is added to hsp, to a limit of maxSpeed.
	accel = DOLL_ACCEL;

	//The highest the player can accelerate themselves to.
	maxSpeed = DOLL_MAX_SPEED;

	//Which direction the doll is attempting to move.
	hDir = 0;
	vDir = 0;
	
	//Which direction the doll is facing.
	hFacing = sign(image_xscale);
	vFacing = 1;

	image_speed = 0.25;

	///Timers
	//TODO: Make these into structs.
	//Number of seconds to regenerate 1 SP. Lower is faster.
	ppRegen = .2 ;
	ppRegenTimer = 0;
	
	//Pointers to objects that the doll will track.
	myHeld = noone;
	
	//Instance being targetted. For players this is set when they're clicked on. For NPCs it's whoever they want to attack.
	target = noone;
}

/// @function instance_create_at_doll(_doll _object, _spd = 0)
/// @description Creates an instance of _object at the x, y coordinates of a specified _dollinstance. Sets owner and angle variables on the created instance. Returns created instance.
/// @param _dollDoll object. 
/// @param _object Object to create an instance of.
/// @param spd Speed for object to move towards 'angle' at.   If 'undefined' does not define physics for the object.
function instance_create_at_doll( _doll, _object, _spd)
{
		//Maybe put in some manner of non-static instance_create_at_doll(_doll _object, _spd = 0) function?
		// would return created instance so in the Use() function for children could be further modified.
		var _x = _doll.x;
		var _y = _doll.y;
		var _depth = _doll.depth + 1;
		var _angle = _doll.angle;
		
		var _instance = instance_create_depth(_x, _y, _depth, _object);
		
		with (_instance)
		{
			owner = _doll
			angle = _angle;
			
			//TODO: Include some way to cancel out of defining these perhaps??
			//maybe make it into instance_create_at_doll(_doll _object, _spd/_hsp, _vsp) and have it pick by checking # of args? dunno
			if (_spd != undefined)
			{
				hsp = dsin(_angle + 90) * _spd;
				vsp = dcos(_angle + 90) * _spd;
			}
		}
		
		return _instance;
}

/// @function doll_movement(_hDir, _vDir)
/// @description Makes doll move in response to hDir and vDir, setting hsp and vsp. Usually should be put in step event.
/// @param _hDir Horizontal direction. -1 (Left), 0 (None) or 1 (Right).
/// @param _vDir Vertical direction. -1(Up), 0 (None), or 1(Down)
function doll_movement(_hDir, _vDir)
{
	hDir = _hDir;
	if (hDir != 0) 
	{
		hFacing = sign(hDir);
		hsp = phys_force_add(hsp, hDir * accel, maxSpeed);
	}

	vDir = _vDir;
	if (vDir != 0) 
	{
		vFacing = sign(vDir);
		vsp = phys_force_add(vsp, vDir * accel, maxSpeed);
	}
}

/// @function Jump(_x1, _y1, _z1, _x2, _y2, _z2) constructor
/// @description data structure for a jump struct.
/// @param _x1 starting x coordinate.
/// @param _y1 starting y coordinate.
/// @param _z1 starting z coordinate.
/// @param _x2 destination x coordinate.
/// @param _y2 destination y coordinate.
/// @param _z2 destination z coordinate.
function Jump(_x1, _y1, _z1, _x2, _y2, _z2) constructor
{
	x1 = _x1;
	y1 = _y1;
	z1 = _z1;
	x2 = _x2;
	y2 = _y2;
	z2 = _z2;
	angle = point_direction(x1, y1, x2, y2);
	
	hsp = dsin(angle + 90) * 2;
	vsp = dcos(angle + 90) * 2;
}

/// @function doll_animate()
/// @description Alters the sprite for the doll in response to facing variables.
function doll_animate()
{
	image_xscale = hFacing;

	if (hDir != 0) || (vDir != 0) || (instance_exists(myHeld) && (myHeld.object_index == MELEE) && ((hsp != 0) || (vsp != 0)))
	{
		sprite_index = walkSprites[(vFacing != 1)];
	}
	else
	{
		sprite_index = standSprites[(vFacing != 1)];
	}
}

/// @function doll_draw()
/// @description Dolls a draw using variables initialized in doll_initialize
function doll_draw()
{
	
	if (ds_list_find_index(global.partyMembers, id) != -1)
	{
		draw_sprite_ext(spr_dollDropShadow, 0, x, y, image_xscale, image_yscale, image_angle, c_asian1, image_alpha);
	}
	
	draw_self();
	
	
		
	//If facing down
	if (vFacing != -1)
	{
		draw_sprite_ext(spr_dollFaces, faceIndex, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);	
		draw_sprite_ext(spr_dollShirts, shirtIndex, x, y, image_xscale, image_yscale, image_angle, shirtColor, image_alpha);
		draw_sprite_ext(spr_dollHairs, hairIndex, x, y, image_xscale, image_yscale, image_angle, hairColor, image_alpha);	

		//If walking
		if (hDir != 0) || (vDir != 0) || (instance_exists(myHeld) && (myHeld.object_index == MELEE) && ((hsp != 0) || (vsp != 0)))
		{
			draw_sprite_ext(spr_playerPantsWalk0, image_index, x, y, image_xscale, image_yscale, image_angle, pantsColor, image_alpha);	
		}
		else
		{
			draw_sprite_ext(spr_playerPants0, image_index, x, y, image_xscale, image_yscale, image_angle, pantsColor, image_alpha);	
		}
	}
	//If facing up
	else 
	{
		draw_sprite_ext(spr_dollShirtsBack, shirtIndex, x, y, image_xscale, image_yscale, image_angle, shirtColor, image_alpha);
		draw_sprite_ext(spr_dollHairsUp, hairIndex, x, y, image_xscale, image_yscale, image_angle, hairColor, image_alpha);	

		//If walking
		if (hDir != 0) || (vDir != 0) || (instance_exists(myHeld) && (myHeld.object_index == MELEE) && ((hsp != 0) || (vsp != 0)))
		{
			draw_sprite_ext(spr_playerPantsWalkUp0, image_index, x, y, image_xscale, image_yscale, image_angle, pantsColor, image_alpha);	
		}
		else
		{
			draw_sprite_ext(spr_playerPantsUp0, image_index, x, y, image_xscale, image_yscale, image_angle, pantsColor, image_alpha);	
		}
	}
}