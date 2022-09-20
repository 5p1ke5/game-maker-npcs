/// @description Inherits, initializes NPC variables.
event_inherited();

var _state = new NPCStateIdle(noone);

npc_initialize("NA", "The swift brown fox quickly jumped over the lazy dog", 100, _state);