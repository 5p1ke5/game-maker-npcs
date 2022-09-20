/// @description Inherit physics + timers. Executes NPC behavior and then enters state machine,

event_inherited();

//Decides how the NPC is going to move, sets state.
npc_behavior();
