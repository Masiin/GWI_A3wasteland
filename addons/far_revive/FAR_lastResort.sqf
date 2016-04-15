// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: FAR_lastResort.sqf
//	@file Author: AgentRev

private ["_hasSatchel", "_mineType", "_pos", "_mine"];

_hasSatchel = "SatchelCharge_Remote_Mag" in magazines player;

if !(player getVariable ["performingDuty", false]) then
{
	if (_hasSatchel) then
	{
		if (["Perform your duty?", "", "Yes", "No"] call BIS_fnc_guiMessage) then
		{
			player setVariable ["performingDuty", true];
			playSound3D [call currMissionDir + "client\sounds\lastresort.wss", vehicle player, false, getPosASL player, 0.7, 1, 1000];

			if (_hasSatchel) then
			{
				_mineType = "SatchelCharge_F";
				player removeMagazine "SatchelCharge_Remote_Mag";
			}
			
			sleep 1.75;

			_pos = getPosATL player;
			_pos set [2, (_pos select 2) + 0.5];

			_mine = createMine [_mineType, _pos, [], 0];
			_mine setDamage 1;
			if (damage player < 1) then { player setDamage 1 }; // if check required to prevent "Killed" EH from getting triggered twice
			player setVariable ["performingDuty", nil];
		};
	}
	else
	{
		titleText ["Get an explosive charge next time, my child.", "PLAIN", 0.5];
	};
};
