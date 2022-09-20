/// @description Makes NPC speak.
if (!instance_exists(myBalloon) && !instance_exists(target))
{
	myBalloon = npc_speak(text);
}