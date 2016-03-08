function SetGlows() {
	for (var _local11 in Players) {
		if (Players[_local11].Namecolor) {
			var _local1 = INTERFACE.nicknames_mc["p" + _local11].name_txt;
			_local1.textColor = Players[_local11].Namecolor;
		}
		if (Players[_local11].Nameglow) {
			var _local1 = INTERFACE.nicknames_mc["p" + _local11];
			var _local3 = new flash.filters.DropShadowFilter(0, 0, Players[_local11].Nameglow, 20, 5, 5, 15, 3);
			_local1.name_txt.filters = [_local3];
		}
		if (Players[_local11].ChatGlow) {
			var _local3 = new flash.filters.DropShadowFilter(0, 0, Players[_local11].ChatGlow, 20, 5, 5, 15, 3);
			INTERFACE.interface_mc.dock_mc.chat_mc.chat_input.filters = [_local3];
		}
		if (Players[_local11].PenguinGlow) {
			Penguin = ENGINE.room_mc.load_mc["p" + _local11];
			var _local3 = new flash.filters.DropShadowFilter(0, 0, Players[_local11].PenguinGlow, 20, 5, 5, 15, 3);
			Penguin.filters = [_local3];
		}
		if (Players[_local11].BubbleColor) {
			var _local5 = INTERFACE.BALLOONS["p" + _local11];
			var _local9 = new Color(_local5.balloon_mc);
			_local9.setRGB(Players[_local11].BubbleColor);
			var _local8 = new Color(_local5.pointer_mc);
			_local8.setRGB(Players[_local11].BubbleColor);
		}
		if (Players[_local11].BubbleGlow) {
			var _local4 = INTERFACE.BALLOONS["p" + _local11];
			var _local3 = new flash.filters.DropShadowFilter(0, 0, Players[_local11].BubbleGlow, 20, 5, 5, 15, 3);
			_local4.balloon_mc.filters = [_local3];
			_local4.pointer_mc.filters = [_local3];
		}
		if (Players[_local11].BubbleTextColor) {
			var _local6 = INTERFACE.BALLOONS["p" + _local11];
			_local6.message_txt.textColor = Players[_local11].BubbleTextColor;
		}
		if (Players[_local11].RingColor) {
			ENGINE.room_mc.load_mc["p" + _local11].art_mc.ring._visible = true;
			var _local7 = new Color(ENGINE.room_mc.load_mc["p" + _local11].art_mc.ring);
			_local7.setRGB(Players[_local11].RingColor);
		}
		if (Players[_local11].Transformation) {
			ENGINE.room_mc.load_mc["p" + _local11].art_mc.loadMovie("http://localhost/play/v2/content/global/penguin/other/" + Players[_local11].Transformation + ".swf");
		}
		if (Players[_local11].Title) {
			var _local1 = INTERFACE.nicknames_mc["p" + _local11];
			var _local10 = new flash.filters.DropShadowFilter(0, 0, Players[_local11].TitleGlow, 20, 5, 5, 15, 3);
			var _local2 = new TextFormat();
			_local2.size = 8;
			_local2.color = Players[_local11].TitleColor;
			_local2.align = "center";
			_local2.font = "Burbank Small Medium";
			_local1.createTextField("title_mc", 4, -50, 25, 100, 13);
			_local1.title_mc.selectable = false;
			_local1.title_mc.text = Players[_local11].Title;
			_local1.title_mc.filters = [_local10];
			_local1.title_mc.setTextFormat(_local2);
		}
	}
}
function UpdatePlayer(PlayerArray) {
	Players[PlayerArray[0]] = {Nameglow:PlayerArray[17], Namecolor:PlayerArray[18], BubbleColor:PlayerArray[19], BubbleTextColor:PlayerArray[20], RingColor:PlayerArray[21], Speed:PlayerArray[22], Title:PlayerArray[23], Mood:PlayerArray[24], ChatGlow:PlayerArray[25], PenguinGlow:PlayerArray[26], BubbleGlow:PlayerArray[27], MoodGlow:PlayerArray[28], MoodColor:PlayerArray[29], SnowballGlow:PlayerArray[30], Walls:PlayerArray[31], Transformation:PlayerArray[32], TitleGlow:PlayerArray[33], TitleColor:PlayerArray[34]};
}
function OpenGlows() {
	_global.handleJoinRoom = function (obj) {
		for (var _local2 in obj) {
			PlayerArray = obj[_local2].split("|");
			UpdatePlayer(PlayerArray);
		}
	};
	AIRTOWER.addListener("jr", _global.handleJoinRoom);
	_global.handleAddPlayer = function (obj) {
		Player = obj.shift();
		PlayerArray = Player.split("|");
		UpdatePlayer(PlayerArray);
		SetGlows();
	};
	AIRTOWER.addListener("ap", _global.handleAddPlayer);
	_global.handleUpdatePlayer = function (obj) {
		v = obj.shift();
		Player = obj.shift();
		PlayerArray = Player.split("|");
		UpdatePlayer(PlayerArray);
		SetGlows();
	};
	AIRTOWER.addListener("up", _global.handleUpdatePlayer);
	_global.showEmoteBalloon = function (obj) {
		obj.shift();
		id = obj[0];
		color = Players[id].BubbleColor;
		glow = Players[id].BubbleGlow;
		if (color) {
			var _local5 = new Color(INTERFACE.balloons_mc["p" + id].balloon_mc);
			var _local2 = new Color(INTERFACE.balloons_mc["p" + id].pointer_mc);
			_local5.setRGB(color);
			_local2.setRGB(color);
		}
		if (glow) {
			var _local1 = new flash.filters.DropShadowFilter(0, 0, glow, 20, 5, 5, 15, 3);
			var _local4 = INTERFACE.balloons_mc["p" + id].balloon_mc;
			var _local3 = INTERFACE.balloons_mc["p" + id].pointer_mc;
			_local4.filters = [_local1];
			_local3.filters = [_local1];
		}
	};
	AIRTOWER.addListener("se", _global.showEmoteBalloon);
}
var INTERFACE = _global.getCurrentInterface();
var ENGINE = _global.getCurrentEngine();
var SHELL = _global.getCurrentShell();
var AIRTOWER = _global.getCurrentAirtower();
var Players = {};
ENGINE.onPlayerLoadStart = function (event) {
	SetGlows();
	event.target._visible = false;
};
INTERFACE.updatePlayerWidgetO = INTERFACE.updatePlayerWidget;
INTERFACE.updatePlayerWidget = function () {
	INTERFACE.updatePlayerWidgetO();
	var mP = (INTERFACE.getActivePlayerId() == SHELL.getMyPlayerId());
	var player_ob = INTERFACE.getPlayerObject(INTERFACE.getActivePlayerId());
	var glow = (new flash.filters.DropShadowFilter(0, 0, Players[player_ob.player_id].MoodGlow, 20, 5, 5, 15, 3));
	var tF = new TextFormat();
	tF.font = "Burbank Small Medium";
	tF.size = 12;
	tF.align = "center";
	tF.color = Players[player_ob.player_id].MoodColor;
	INTERFACE.PLAYER_WIDGET.art_mc.createTextField("pMood_txt", 2, 10, 230, 203, 16);
	INTERFACE.PLAYER_WIDGET.art_mc.pMood_txt.text = Players[player_ob.player_id].Mood;
	INTERFACE.PLAYER_WIDGET.art_mc.pMood_txt.selectable = mP;
	INTERFACE.PLAYER_WIDGET.art_mc.pMood_txt.setTextFormat(tF);
	INTERFACE.PLAYER_WIDGET.art_mc.pMood_txt.filters = [glow];
	if (mP) {
		INTERFACE.PLAYER_WIDGET.art_mc.pMood_txt.type = "input";
		INTERFACE.PLAYER_WIDGET.art_mc.pMood_txt.onKillFocus = function () {
			if ((this.text == " ") || (this.text == "")) {
				this.text = "Luna ~ I have no mood.";
			}
			var newMood = this.text;
			Players[player_ob.player_id].Mood = newMood;
			with (_level0.CLIENT.PENGUIN.AIRTOWER) {
				send(PLAY_EXT, "iCP#umo", [newMood], "str", -1);
			}
		};
	}
};
INTERFACE.showBalloon2 = INTERFACE.showBalloon;
INTERFACE.showBalloon = function (player_id, msg) {
	var _local1 = INTERFACE.showBalloon2(player_id, msg);
	var _local3 = INTERFACE.getPlayerObject(player_id);
	SetGlows();
	return(_local1);
};
ENGINE.randomizeNearPosition = function (player, x, y, range) {
	player.x = x;
	player.y = y;
	return(true);
};
ENGINE.movePlayer = function (player_id, target_x, target_y, is_trigger, frame) {
	var _local3 = ENGINE.getRoomMovieClip();
	if (is_trigger == undefined) {
		is_trigger = true;
	}
	var mc = ENGINE.getPlayerMovieClip(player_id);
	var start_x = Math.round(mc._x);
	var start_y = Math.round(mc._y);
	if (mc.is_reading) {
		ENGINE.removePlayerBook(player_id);
	}
	if (!mc.is_ready) {
		ENGINE.updatePlayerPosition(player_id, target_x, target_y);
	} else {
		var _local2 = ENGINE.findDistance(start_x, start_y, target_x, target_y);
		if (_local3.ease_method == "easeInOutQuad") {
			var easeFunction = ENGINE.mathEaseInOutQuad;
		} else {
			var easeFunction = ENGINE.mathLinearTween;
		}
		var _local4 = ENGINE.findAngle(start_x, start_y, target_x, target_y);
		var d = ENGINE.findDirection(_local4);
		var duration = (_local2 / 4);
		if (Players[player_id].Speed) {
			var duration = (_local2 / Players[player_id].Speed);
		}
		var change_x = (target_x - start_x);
		var change_y = (target_y - start_y);
		mc.is_moving = true;
		ENGINE.updatePlayerFrame(player_id, d + 8);
		var t = 0;
		mc.onEnterFrame = function () {
			t++;
			if (t < duration) {
				x = easeFunction(t, start_x, change_x, duration);
				y = easeFunction(t, start_y, change_y, duration);
				ENGINE.updatePlayerPosition(player_id, x, y);
			} else {
				mc.is_moving = false;
				ENGINE.updatePlayerPosition(player_id, target_x, target_y);
				ENGINE.updatePlayerFrame(player_id, d);
				ENGINE.SHELL.sendPlayerMoveDone(player_id);
				this.onEnterFrame = null;
				delete this.onEnterFrame;
				if (ENGINE.SHELL.isMyPlayer(player_id)) {
					ENGINE.playerMoved.dispatch();
					ENGINE.setPlayerAction("wait");
					if (is_trigger && (ENGINE.isMouseActive())) {
						ENGINE.checkTrigger(mc);
						ENGINE.checkFieldOpTriggered(mc);
					}
					if (frame != undefined) {
						ENGINE.sendPlayerFrame(frame);
					}
				}
			}
		};
	}
};
ENGINE.throwBall = function (player_id, target_x, target_y, start_height, max_height, wait) {
	var _local2 = ENGINE.getPlayerMovieClip(player_id);
	var room_mc = ENGINE.getRoomMovieClip();
	if (_local2.is_reading) {
		ENGINE.removePlayerBook(player_id);
	}
	if (_local2.is_ready && (!_local2.is_moving)) {
		if (throw_item_counter == undefined) {
			throw_item_counter = 0;
		}
		if (throw_item_counter > 10) {
			throw_item_counter = 0;
		}
		var start_x = _local2._x;
		var start_y = _local2._y;
		var c = (throw_item_counter++);
		var _local3 = "i" + c;
		if (room_mc[_local3] != undefined) {
			room_mc[_local3].removeMovieClip();
		}
		room_mc.attachMovie("ball", _local3, 1000200 + c);
		var mc = room_mc[_local3];
		mc.player_id = player_id;
		mc.id = c;
		mc._x = start_x;
		mc._y = start_y;
		ENGINE.updateItemDepth(mc, c);
		var _local4 = ENGINE.findDistance(start_x, start_y, target_x, target_y);
		var _local5 = ENGINE.findAngle(start_x, start_y, target_x, target_y);
		var _local6 = Math.round(ENGINE.findDirection(_local5) / 2);
		ENGINE.updatePlayerFrame(player_id, 26 + _local6);
		var duration = (_local4 / 15);
		var change_x = (target_x - start_x);
		var change_y = (target_y - start_y);
		var peak = (duration / 2);
		var change_height1 = (max_height - start_height);
		var change_height2 = (-max_height);
		mc.art._y = start_height;
		mc._visible = false;
		var t = 0;
		var w = 0;
		mc.onEnterFrame = function () {
			if (w > wait) {
				mc._visible = true;
				if (Players[player_id].SnowballGlow) {
					var _local2 = new flash.filters.DropShadowFilter(0, 0, Players[player_id].SnowballGlow, 20, 5, 5, 15, 3);
					mc.filters = [_local2];
				}
				t++;
				if (t < duration) {
					mc._x = ENGINE.mathLinearTween(t, start_x, change_x, duration);
					mc._y = ENGINE.mathLinearTween(t, start_y, change_y, duration);
					ENGINE.updateItemDepth(mc, c);
					if (t < peak) {
						mc.art._y = ENGINE.mathEaseOutQuad(t, start_height, change_height1, peak);
					} else {
						mc.art._y = ENGINE.mathEaseInQuad(t - peak, max_height, change_height2, peak);
					}
				} else {
					mc._x = target_x;
					mc._y = target_y;
					mc.art._y = 0;
					mc.gotoAndStop(2);
					room_mc.handleThrow(mc);
					_level0.CLIENT.PENGUIN.SHELL.updateListeners(_level0.CLIENT.PENGUIN.SHELL.BALL_LAND, {id:mc.id, player_id:mc.player_id, x:mc._x, y:mc._y});
					if (room_mc.snowballBlock != undefined) {
						if (room_mc.snowballBlock.hittest(mc._x, mc._y, true)) {
							mc._visible = false;
						}
					}
					this.onEnterFrame = null;
				}
			} else {
				w++;
			}
		};
	}
};
ENGINE.findPlayerPath = function (player_id, x, y) {
	var _local13 = ENGINE.getPlayerMovieClip(player_id);
	var _local7 = ENGINE.getRoomBlockMovieClip();
	var _local14 = ENGINE.getValidXPosition(x);
	var _local15 = ENGINE.getValidYPosition(y);
	var _local12 = Math.round(_local13._x);
	var _local11 = Math.round(_local13._y);
	var _local16 = ENGINE.findDistance(_local12, _local11, _local14, _local15);
	var _local6 = Math.round(_local16);
	var _local8 = (_local14 - _local12) / _local6;
	var _local9 = (_local15 - _local11) / _local6;
	var _local3 = _local12;
	var _local4 = _local11;
	var _local5 = new Object();
	_local5.x = _local12;
	_local5.y = _local11;
	var _local17 = _local7.hitTest(_local12, _local11, true);
	while (_local6 > 0) {
		_local3 = _local3 + _local8;
		_local4 = _local4 + _local9;
		var _local1 = Math.round(_local3);
		var _local2 = Math.round(_local4);
		if (Players[player_id].Walls != 1) {
			if (_local7.hitTest(_local1, _local2, true)) {
				break;
			}
		}
		_local5.x = _local1;
		_local5.y = _local2;
		_local6--;
	}
	return(_local5);
};
SHELL.getPlayerHexFromId = function (id) {
	if ((id < 50) || (!isNaN(_loc2.colour_id))) {
		var _local1 = SHELL.getPlayerColoursObject();
		if (_local1[id] != undefined) {
			return(_local1[id]);
		}
		return(_local1[0]);
	}
	return(id);
};
SHELL.getMyPlayerHex = function () {
	var _local1 = SHELL.getMyPlayerObject();
	var _local2 = SHELL.getPlayerColoursObject();
	if ((_local1.colour_id < 50) || (isNaN(_local1.colour_id))) {
		return(_local1.colour_id);
	}
	if (_local2[_local1.colour_id] != undefined) {
		return(_local2[_local1.colour_id]);
	}
	return(_local2[0]);
};
SHELL.handleSendUpdatePlayerColour = function (obj) {
	var _local5 = obj.shift();
	var _local2 = Number(obj[0]);
	var _local3 = Number(obj[1]);
	if (SHELL.isMyPlayer(_local2)) {
		SHELL.setMyPlayerHexById(_local3);
	}
	var _local1 = SHELL.getPlayerObjectFromRoomById(_local2);
	if (_local1 != undefined) {
		_local1.colour_id = _local3;
		_local1.frame_hack = SHELL.buildFrameHacksString(_local1);
		SHELL.updateListeners(SHELL.UPDATE_PLAYER, _local1);
		if (SHELL.isMyPlayer(_local2)) {
			SHELL.com.clubpenguin.login.LocalData.saveRoomPlayerObject(_local1);
		}
	} else {
		SHELL.$e("[shell] handleSendUpdatePlayerColour() -> Could not find player in room! player_id:" + _local2);
	}
};
SHELL.setMyPlayerHexById = function (id) {
	var _local1 = SHELL.getMyPlayerObject();
	var _local3 = _local1.colour_id;
	_local1.colour_id = id;
	if (SHELL.player_colours[_local1.colour_id] != undefined) {
		return(SHELL.player_colours[_local1.colour_id]);
	}
	return(id);
};
OpenGlows();
