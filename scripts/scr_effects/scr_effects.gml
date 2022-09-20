/// @function Effect(_name, _duration) constructor 
/// @descrtion Constructor for basic Effect. Doesn't do anything but other effects inherit from it.
/// @param _name {string} Name for the effect.
/// @param _effectList {list} effectList this Effect is part of.
/// @param _duration {int} How long the effect lasts. Decremented in Tick. Setting it to 'noone' will make it last indefinitely.
function Effect(_name, _effectList, _duration) constructor 
{
	name = _name;
	
	duration = _duration;
	timer = duration;
	
	/// @description decrements duration, if there is any.
	/// @param _user Instance calling this effect.
	static Tick = function(_user)
	{
		if (duration != noone)
		{
			timer--;
			
			if (timer < 0)
			{
				Ring();
			}
		}
	}
	
	/// @description called when the effect's timer reaches 0. Normally removes self from list.
	/// @param _user Instance calling this effect.
	static Ring = function(_user)
	{
		// effectList_remove(list, self)
	}
	
	/// @description Code for Effect to call during step event.
	/// @param _user Instance calling this effect.
	static StepEvent = function(_user)
	{
		
	}
	
	/// @description Code for Effect to call during end step event.
	/// @param _user Instance calling this effect.
	static EndStepEvent = function(_user)
	{
		
	}
	
	/// @description Code for Effect to call during begin step event.
	/// @param _user Instance calling this effect.
	static BeginStepEvent = function(_user)
	{
		
	}
	
	/// @description Code for Effect to call during draw event.
	/// @param _user Instance calling this effect.
	static DrawEvent = function(_user)
	{
		
	}
	
	/// @description Code for Effect to call during end draw event.
	/// @param _user Instance calling this effect.
	static EndDrawEvent = function(_user)
	{
		
	}
	
	/// @description Code for Effect to call during begin draw event.
	/// @param _user Instance calling this effect.
	static BeginDrawEvent = function(_user)
	{
		
	}
}


/// @function effectList_initialize()
/// @description Initializes a ds_list for Effect data structures.
function effectList_initialize()
{
	return ds_list_create();
}

/// @function effectList_step_event(_effectList, _user)
/// @description callst StepEvent(_user) for every Effect in the list.
function effectList_step_event(_effectList, _user)
{
	for (var _i = 0; _i < ds_list_size(_effectList); _i++)
	{
		
	}
}