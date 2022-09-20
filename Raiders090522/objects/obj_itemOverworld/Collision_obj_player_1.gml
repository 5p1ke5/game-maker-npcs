/// @description Destroys self, adds item to inventory, creates message telling player that happened.
instance_destroy();

inventory_add(other.inventory, item);

show_debug_message(string(ds_list_write(other.inventory)));
//message_create(x, y, depth, item.GetName() + " Acquired!");