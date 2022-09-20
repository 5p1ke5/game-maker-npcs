///Inventory functions. inventory_* functions and Item* constructors.
///Structs for item types

/// @function Item(_itemName,  _inventory, _icon, _amount, _description, _value, _ai) constructor
/// @description Constructor for an item struct.
/// @param _itemName <String> item's name.
/// @param _inventory Inventory list the item is inside of.
/// @param _icon <sprite> Sprite representation of item.
/// @param _amount  quantity of item in stack.
/// @param _description <String> string description of item.
/// @param _value Value of item when buying or selling.
/// @param _ai What AI type to use. Should be enum
function Item(_itemName,  _inventory, _icon, _amount, _description, _value, _ai) constructor
{
		itemName = _itemName;
		icon = _icon;
		inventory = _inventory;
		amount = _amount;
		description = _description;
		value = _value;
		ai = _ai;
		
		/// @description Uses the item. Called when owner tries to use an item in the inventory.
		static Use = function(_user)
		{
			print("Item used!" + string(self) + "by " + string(_user));
		}
		
		/// @description Alternate use for the item. Usually called by right clicking.
		static AltUse = function(_user)
		{
			print("Item alt used!" + string(self) + "by " + string(_user));
		}
		
		static GetAmount = function()
		{
			return amount;
		}
		static GetName = function()
		{
			return itemName;
		}
		static GetInventory = function()
		{
			return inventory;
		}
		static GetAI = function()
		{
			return ai;
		}
		
		static GetIcon = function()
		{
			return icon;
		}
		
		static GetId = function()
		{
			return GetName() + string(icon);
		}
		
		static SetAmount = function(_amount)
		{
			amount = _amount;
		}
		
		static SetName = function(_name)
		{
			name = _name;
		}
		
		static SetInventory = function(_inventory)
		{
			inventory = _inventory;
		}
}

/// @function ItemConsumable(_itemName, _icon, _inventory, _icon, _amount, _description, _value, _ai) constructor 
/// @description Constructor for an item struct that consumes itself on use.
/// @param _itemName <String> item's name.
/// @param _inventory Inventory list the item is inside of.
/// @param _icon <sprite> Sprite representation of item.
/// @param _amount  quantity of item in stack.
/// @param _description <String> string description of item.
/// @param _value Value of item when buying or selling.
/// @param _ai enum for _ai state to use.
function ItemConsumable(_itemName,  _inventory, _icon, _amount, _description, _value, _ai)  : Item(_itemName,  _inventory, _icon, _amount, _description, _value, _ai) constructor
{
		static Use = function(_user)
		{
			Consume(_user);
		}
		
		//Consumes the item, removing it from the inventory.
		static Consume = function(_user)
		{
			print("Consumable Item used!"  + string(self));
			
			if (inventory != noone)
			{
				inventory_remove(inventory, self, _user);
			}
		}
}

/// @description function ItemMelee(_itemName,  _inventory, _icon, _amount, _description, _value, _ai, _sprite, _altSprite, _damage, _knockback, _spd, _arc, _lunge) constructor
/// @description Constructor for an item struct that creates a n object. May fire in the mouse direction (see _spd)
/// @param _itemName <String> item's name.
/// @param _inventory Inventory list the item is inside of.
/// @param _icon <sprite> Sprite representation of item.
/// @param _amount  quantity of item in stack.
/// @param _description <String> string description of item.
/// @param _value Value of item when buying or selling.
/// @param _ai enum for _ai state to use.
/// @param _sprite Sprite the melee weapon takes the appearance of.
/// @param _altSprite Sprite for alt use (usually guard)
/// @param _dmg how much damage the weapon does.
/// @param _knockback how far targets are knocked back.
/// @param _spd How fast the weapon is swung.
/// @param _arc How many degress the weapon is swung.
/// @param _lunge How far swinging the weapon sends the user.
function ItemMelee(_itemName,  _inventory, _icon, _amount, _description, _value, _ai, _sprite, _altSprite, _damage, _knockback, _spd, _arc, _lunge)  : Item(_itemName,  _inventory, _icon, _amount, _description, _value, _ai) constructor
{
	sprite = _sprite;
	altSprite = _altSprite;
	damage = _damage;
	knockback = _knockback;
	spd = _spd;
	arc = _arc;
	lunge = _lunge;
	
	static Use = function(_user)
	{
		var _melee =  instance_create_at_doll(_user, MELEE, undefined);
		
		var _name = itemName;
		var _sprite = sprite;
		var _damage = damage;
		var _knockback = knockback;
		var _arc = arc;
		var _spd = spd;
		var _angle = _user.angle ;
		var _lunge = lunge;
		
		
		with (_melee)
		{
			inventory_meleeInstance_initialize(_name, _user, _sprite, _damage, _knockback, _arc, _spd, _angle);
		}
		
		with (_user)
		{
			myHeld = _melee;
			hsp = dsin(_angle + 90) * _lunge;
			vsp = dcos(_angle + 90) * _lunge;
			
			hDir = sign(hsp);
			if (hDir != 0) 
			{
				hFacing = hDir;
			}

			vDir = sign(vsp);
			if (vDir != 0) 
			{
				vFacing = vDir;
			}
		}
	}
	
	
	//Makes a guard object every step while right button is being held down.
	static AltUse = function(_user)
	{
		var _parry = instance_create_at_doll(_user, GUARD, undefined);
		var _sprite = altSprite;
		var _angle = _user.angle;
		var _knockback = knockback;
		
		with (_parry)
		{
			owner = _user;
			sprite_index = _sprite;
			image_angle = _angle;
			knockback = _knockback;
			
			depth -= 1;
		}
		
		with (_user)
		{
			myHeld = _parry;
		}
	}
}

enum aiType
{
	na, melee, ranged, consumable, special
}




/// @function ItemInstancer(_itemName,  _inventory, _icon, _amount, _description, _value, _ai, _object, _spd = 0)  
/// @description Constructor for an item struct that creates a n object. May fire in the mouse direction (see _spd)
/// @param _itemName <String> item's name.
/// @param _inventory Inventory list the item is inside of.
/// @param _icon <sprite> Sprite representation of item.
/// @param _amount  quantity of item in stack.
/// @param _description <String> string description of item.
/// @param _value Value of item when buying or selling.
/// @param _ai aiType
/// @param _object Object to create an instance of.
/// @param [_spd] Optionally specifies a speed for the object to be set to.
function ItemInstancer(_itemName,  _inventory, _icon, _amount, _description, _value, _ai, _object, _spd = 0)  : Item(_itemName,  _inventory, _icon, _amount, _description, _value, _ai)  constructor
{
	object = _object;
	spd = _spd;
	
	static Use = function(_user)
	{
		instance_create_at_doll(_user, object, spd);
	}
}

/// @function ItemConsumableInstancer(_itemName,  _inventory, _icon, _amount, _description, _value, _ai, _object, _spd = 0)
/// @description Constructor for an item struct that creates a n object it and then consumes itself. May fire in the mouse direction (see _spd)
/// @param _itemName <String> item's name.
/// @param _inventory Inventory list the item is inside of.
/// @param _icon <sprite> Sprite representation of item.
/// @param _amount  quantity of item in stack.
/// @param _description <String> string description of item.
/// @param _value Value of item when buying or selling.
/// @param _ai aiType
/// @param _object Object to create an instance of.
/// @param [_spd] Optionally specifies a speed for the object to be set to.
/// @param [_color] Color for object to be set to. If not set defaults to c_white.
function ItemConsumableInstancer(_itemName,  _inventory, _icon, _amount, _description, _value, _ai, _object, _spd = 0)  :  ItemConsumable(_itemName,  _inventory, _icon, _amount, _description, _value) constructor
{
	object = _object;
	spd = _spd;
	
	static Use = function(_user)
	{
		instance_create_at_doll(_user, object, spd);
		Consume(_user);
	}
}

/// @function ItemConsumableInstancerColored(_itemName, _icon, _inventory, _object, _spd = 0, _color = c_red)
/// @description Constructor for an item struct that creates a colored object and then consumes itself. May fire in the mouse direction (see _spd)
/// @param _itemName <String> item's name.
/// @param _inventory Inventory list the item is inside of.
/// @param _icon <sprite> Sprite representation of item.
/// @param _amount  quantity of item in stack.
/// @param _description <String> string description of item.
/// @param _value Value of item when buying or selling.
/// @param _ai aiType
/// @param _object Object to create an instance of.
/// @param [_spd] Optionally specifies a speed for the object to be set to.
/// @param [_color] Sets color of created balloon.
function ItemConsumableInstancerColored(_itemName,  _inventory, _icon, _amount, _description, _value, _ai, _object, _spd = 0, _color = c_white)  : ItemConsumableInstancer(_itemName,  _inventory, _icon, _amount, _description, _value, _object, _spd = 0) constructor
{
	color = _color;
	
	static Use = function(_user)
	{
		var _object = instance_create_at_doll(_user, object, spd);
		var _blendColor = color;
		
		with (_object)
		{
			image_blend = _blendColor;
		}
		
		Consume(_user);
	}
		
		static GetId = function()
		{
			return GetName() + string(color);
		}
}


///@function inventory_initialize()
///@description Initializes the inventory. Returns he ds_list for the inventory. This should usually be set to a variable (eg inventory = inventory_initialize();
function inventory_initialize()
{
	return ds_list_create();
}

/// @function inventory_find(_inventory, _Item)
/// @description returns the first index of the given item in the given inventory. If none is found, returns -1.
/// @param _inventory inventory list data structure.
/// @param _Item Item struct to search for.
function inventory_find(_inventory, _Item)
{
	//Tries to find an item with the same id in the inventory.
	for (var _i = 0; _i < ds_list_size(_inventory); _i++)
	{
		var _ItemB = ds_list_find_value(_inventory, _i)
		
		if ( _Item.GetId() == _ItemB.GetId())
		{
			return _i;
		}
	}

	return -1;
}

///@function inventory_add(_inventory, _Item)
///@description Adds an item to the inventory. Returns index 
///@param _inventory inventory list to add to.
///@param _Item Item struct to add.
function inventory_add(_inventory, _Item)
{
	//Tries to check if the player already has a copy of the item in their inventory.
	var _index = inventory_find(_inventory, _Item);
	
	//If an item with the same name was not found, just updates inventory and adds it to the list.
	if (_index == -1)
	{
		with (_Item)
		{
			inventory = _inventory;
		}
		
		ds_list_add(_inventory, _Item);	
	}
	//Otherwise, gets the found Item and adds 1 to amount.
	else
	{
		var _foundItem = ds_list_find_value(_inventory, _index);
		
		with (_foundItem)
		{
			amount = amount + _Item.GetAmount();
		}
	}
}

///@function inventory_remove(_inventory, _Item)
///@description Removes a stack of an item from the inventory. If amount is 0 from this deletes it from the inventory. 
///@param _inventory inventory list to remove from.
///@param _Item Item struct to remove from.
///@param _user (optional) The instance id of the instance the inventory is associated with. Used to alter inventoryIndex if applicable.
function inventory_remove(_inventory, _Item, _user = noone)
{
	_Item.SetAmount(_Item.GetAmount() - 1);
	
	print("New amount: " + string(_Item.GetAmount()));
	
	if (_Item.GetAmount() <= 0)
	{
			var _index = ds_list_find_index(_inventory, _Item);
			ds_list_delete(_inventory, _index);
			print("item removed");
	}
	
	//If a reference to a user instance was passed, attempts to set the inventoryIndex for them.
	//Maybe make inventories a struct??
	if (instance_exists(_user))
	{
		with (_user)
		{
			//Makes sure it has an inventoryIndex variable and if so caps it at ds_list_size - 1, but not below 0.
 			if (variable_instance_exists(_user, "inventoryIndex"))
			{
				print("index resiezed" + string(ds_list_size(_inventory) ));
				inventoryIndex = min(ds_list_size(_inventory) - 1, inventoryIndex);
				inventoryIndex = max(inventoryIndex, 0);
			}
			
		}
	}
}

/// @function inventory_meleeInstance_initialize(_name, _owner, _sprite, _damage, _knockback, _arc, _spd, _angle)
/// @description Initializes variables for a melee object instance.
/// @param _name Name of item this instance was spawned from.
/// @param _owner Instance taht creaeted the obj_melee instance.
/// @param _sprite Sprite for the object. Also serves as its collision mask.
/// @param _arc Arc for the object to rotate along.
/// @param _spd Speed at which to rotate along he arc.
/// @param _angle angle for the instance to start  at.
function inventory_meleeInstance_initialize(_name, _owner, _sprite, _damage, _knockback, _arc, _spd, _angle)
{
	name = _name;
	owner = _owner;
	hurtbox_initialize(_damage, _knockback, owner);
	
	sprite_index = _sprite;
	mask_index = _sprite;
	
	damage = _damage;
	
	arc = _arc;
	spd = _spd;
	
	angle = _angle - (arc/2);
	startingOrientation = _angle;
	
	image_angle = _angle;
	
	dir = 1;
	
	//checks if attack is being parried as it's created.
	parryCheck();
}

/// @function parryCheck()
/// @description checks if a hurtbox is being parried.
function parryCheck()
{
	return 0;	
}