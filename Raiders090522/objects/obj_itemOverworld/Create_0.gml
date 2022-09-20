/// @description Initialize item struct. 

//This object will contain a reference to a struct with an arbitrary number of variables for arbitrary things, 
//This can be overwritten in children with other Item* constructors, eg item = new ItemConsumable("Apple", spr_Apple, 10);
item = new Item("NA", noone, spr_weaponAxeIcon, 1, "This should be overwritten.", 4444, aiType.na);