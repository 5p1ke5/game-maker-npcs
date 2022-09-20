/// @description Overrides step event.


//Allows you to perform commands using hotkeys.
if (keyboard_check(ord("1")))
{
	global.cursorState = cursor.normal;
	cursor_sprite = global.cursorState;
}

if (keyboard_check(ord("2")))
{
	global.cursorState = cursor.select;
	cursor_sprite = global.cursorState;
}

if (keyboard_check(ord("3")))
{
	global.cursorState = cursor.follow;
	cursor_sprite = global.cursorState;
}

if (keyboard_check(ord("4")))
{
	global.cursorState = cursor.attack;
	cursor_sprite = global.cursorState;
}

if (keyboard_check(ord("5")))
{
	global.cursorState = cursor.move;
	cursor_sprite = global.cursorState;
}

//Player specific controls. 
//Allows you to use an item.
if (!instance_exists(myHeld)) && (global.cursorState == cursor.normal)
{
	//Resets angle. If it needs to be used its reset every step.
	angle = -1;

	//Use item. Call's the item's Use method.
	if (MOUSE_LEFT_BUTTON_PRESSED)
	{
		angle = point_direction(x, y, mouse_x, mouse_y);
	
		if (ds_list_size(inventory) > 0)
		{
			var _item = inventory[|inventoryIndex];
			_item.Use(id);
		}
	}
	
	//Alt use of item. Call's item's AltUse method.
	else if (MOUSE_RIGHT_BUTTON)
	{
		angle = point_direction(x, y, mouse_x, mouse_y);
		
		if (ds_list_size(inventory) > 0)
		{
			var _item = inventory[|inventoryIndex];
			_item.AltUse(id);
		}
	}
}

//Doll Controls

//Can't move if the instance is holding a melee attack object (might change to an abstract object that locks movement or maybe adding a variable to object that can be held.
if !(instance_exists(myHeld) && myHeld.object_index == obj_meleeSwing)
{
	doll_movement( RIGHT_BUTTON - LEFT_BUTTON, DOWN_BUTTON - UP_BUTTON);
}

//Lets player pick inventory item.
//Select inventory item.
inventoryIndex += (MOUSE_WHEEL_UP - MOUSE_WHEEL_DOWN)

//Changing inventory dispels held item.
if (MOUSE_WHEEL_UP - MOUSE_WHEEL_DOWN != 0)
{
	instance_destroy(myHeld);
	myHeld = noone;
}

//Sets index.
if (inventoryIndex >= ds_list_size(inventory))
{
	inventoryIndex = 0;
}
if (inventoryIndex < 0)
{
	inventoryIndex = ds_list_size(inventory) - 1;
}



event_inherited();