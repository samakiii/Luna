var INTERFACE = _global.getCurrentInterface();
var ENGINE = _global.getCurrentEngine();
var SHELL = _global.getCurrentShell();
var AIRTOWER = _global.getCurrentAirtower();
var Players = {};
import flash.filters.GlowFilter;

ENGINE.onPlayerLoadStart = function(event){
    SetGlows();
    event.target._visible = false;
}

INTERFACE.updatePlayerWidgetO = INTERFACE.updatePlayerWidget;
INTERFACE.updatePlayerWidget = function() {
   INTERFACE.updatePlayerWidgetO();
   var mP = INTERFACE.getActivePlayerId() == SHELL.getMyPlayerId();
   var player_ob = INTERFACE.getPlayerObject(INTERFACE.getActivePlayerId());
   var tF = new TextFormat();
   tF.font = "Burbank Small Medium";
   tF.size = 12;
   tF.align = "center";
   tF.color = 0xFFFFFF;

   INTERFACE.PLAYER_WIDGET.art_mc.createTextField("pMood_txt",2, 10, 230, 203, 16);
   INTERFACE.PLAYER_WIDGET.art_mc.pMood_txt.text = Players[player_ob.player_id].Mood;
   INTERFACE.PLAYER_WIDGET.art_mc.pMood_txt.selectable = mP;
   INTERFACE.PLAYER_WIDGET.art_mc.pMood_txt.setTextFormat(tF);
   INTERFACE.PLAYER_WIDGET.art_mc.pMood_txt.textColor = 16756224;
   if(mP) {
      INTERFACE.PLAYER_WIDGET.art_mc.pMood_txt.type = "input";
      INTERFACE.PLAYER_WIDGET.art_mc.pMood_txt.onKillFocus = function() {
         if(this.text == " " || this.text == "") {
            this.text = "Luna ~ I have no mood.";
         }
         var newMood = this.text;
         Players[player_ob.player_id].Mood = newMood;
         with(_level0.CLIENT.PENGUIN.AIRTOWER) {
            send(PLAY_EXT,"iCP#umo",[newMood],"str",-1)

         };
      };
   }
};

function SetGlows(){
    for(var PlayerIndex in Players) {
        if(Players[PlayerIndex].Namecolor) {
            var PlayerName = INTERFACE.nicknames_mc["p" + PlayerIndex].name_txt;
            PlayerName.textColor = Players[PlayerIndex].Namecolor;
        }
        if(Players[PlayerIndex].Nameglow) {
            var PlayerName = INTERFACE.nicknames_mc["p" + PlayerIndex];
            var Glow = new flash.filters.DropShadowFilter(0, 0, Players[PlayerIndex].Nameglow, 20, 5, 5, 15, 3);
            PlayerName.name_txt.filters = [Glow];
        }
        if (Players[PlayerIndex].ChatGlow){
            var Glow = new flash.filters.DropShadowFilter(0, 0, Players[PlayerIndex].ChatGlow, 20, 5, 5, 15, 3);
            INTERFACE.interface_mc.dock_mc.chat_mc.chat_input.filters = [Glow];
        }
        if(Players[PlayerIndex].BubbleColor) {
            var i = INTERFACE.BALLOONS["p" + PlayerIndex];
            var _loc1 = new Color(i.balloon_mc);
            _loc1.setRGB(Players[PlayerIndex].BubbleColor);
            var _loc2 = new Color(i.pointer_mc);
            _loc2.setRGB(Players[PlayerIndex].BubbleColor);
        }
        if(Players[PlayerIndex].BubbleTextColor) {
            var mc = INTERFACE.BALLOONS["p" + PlayerIndex];
            mc.message_txt.textColor = Players[PlayerIndex].BubbleTextColor;
        }
        if (Players[PlayerIndex].RingColor) {
            ENGINE.room_mc.load_mc["p" + PlayerIndex].art_mc.ring._visible = true;
            var _loc3 = new Color(ENGINE.room_mc.load_mc["p" + PlayerIndex].art_mc.ring);
            _loc3.setRGB(Players[PlayerIndex].RingColor);
        }
		var PlayerName = INTERFACE.nicknames_mc["p" + PlayerIndex];
		switch(Players[PlayerIndex].Rank){
			case '146':
				var title_txt = new TextFormat();
				title_txt.size = 8;
				title_txt.color = 0x000000;
				title_txt.align = 'center';
				title_txt.font = 'Burbank Small Medium';
				PlayerName.createTextField( 'title_mc', 4, -50, 25, 100, 13 );
				PlayerName.title_mc.selectable = false;
				PlayerName.title_mc.text = "Member";
				PlayerName.title_mc.setTextFormat(title_txt);
			break;
			case '292':
				var title_txt = new TextFormat();
				title_txt.size = 8;
				title_txt.color = 0x000000;
				title_txt.align = 'center';
				title_txt.font = 'Burbank Small Medium';
				PlayerName.createTextField( 'title_mc', 4, -50, 25, 100, 13 );
				PlayerName.title_mc.selectable = false;
				PlayerName.title_mc.text = "VIP";
				PlayerName.title_mc.setTextFormat(title_txt);
			break;
			case '438':
				var title_txt = new TextFormat();
				title_txt.size = 8;
				title_txt.color = 0x000000;
				title_txt.align = 'center';
				title_txt.font = 'Burbank Small Medium';
				PlayerName.createTextField( 'title_mc', 4, -50, 25, 100, 13 );
				PlayerName.title_mc.selectable = false;
				PlayerName.title_mc.text = "Mediator";
				PlayerName.title_mc.setTextFormat(title_txt);
			break;
			case '584':
				var title_txt = new TextFormat();
				title_txt.size = 8;
				title_txt.color = 0xFF0000;
				title_txt.bold = true;
				title_txt.align = 'center';
				title_txt.font = 'Burbank Small Medium';
				PlayerName.createTextField( 'title_mc', 4, -50, 25, 100, 13 );
				PlayerName.title_mc.selectable = false;
				PlayerName.title_mc.text = "Moderator";
				PlayerName.title_mc.setTextFormat(title_txt);
			break;
			case '730':
				var title_txt = new TextFormat();
				title_txt.size = 8;
				title_txt.color = 0x000000;
				title_txt.align = 'center';
				title_txt.font = 'Burbank Small Medium';
				PlayerName.createTextField( 'title_mc', 4, -50, 25, 100, 13 );
				PlayerName.title_mc.selectable = false;
				PlayerName.title_mc.text = "Administrator";
				PlayerName.title_mc.setTextFormat(title_txt);
			break;
			case '876':
				var title_txt = new TextFormat();
				title_txt.size = 8;
				title_txt.color = 0xFF0000;
				title_txt.bold = true;
				title_txt.align = 'center';
				title_txt.font = 'Burbank Small Medium';
				PlayerName.createTextField( 'title_mc', 4, -50, 25, 100, 13 );
				PlayerName.title_mc.selectable = false;
				PlayerName.title_mc.text = "Owner";
				PlayerName.title_mc.setTextFormat(title_txt);
			break;
		}
	}
}

function UpdatePlayer(PlayerArray){
    Players[PlayerArray[0]] = {
        Nameglow: PlayerArray[17], 
        Namecolor: PlayerArray[18],
        BubbleColor: PlayerArray[19],
        BubbleTextColor: PlayerArray[20],
        RingColor: PlayerArray[21],
        Speed: PlayerArray[22],
        Rank: PlayerArray[23],
        Mood: PlayerArray[24],
        ChatGlow: PlayerArray[25]
    };
}

INTERFACE.showBalloon2 = INTERFACE.showBalloon;
INTERFACE.showBalloon = function(player_id, msg) {
    var _loc4_ = INTERFACE.showBalloon2(player_id,msg);
    var _loc1_ = INTERFACE.getPlayerObject(player_id);
    SetGlows();
    return _loc4_;
}

ENGINE.randomizeNearPosition = function(player, x, y, range) {
            player.x = x;
            player.y = y;
            return true;
}

ENGINE.movePlayer = function(player_id, target_x, target_y, is_trigger, frame){
    var _local4 = ENGINE.getRoomMovieClip();
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
        var _local3 = ENGINE.findDistance(start_x, start_y, target_x, target_y);
        if (_local4.ease_method == "easeInOutQuad") {
            var easeFunction = ENGINE.mathEaseInOutQuad;
        } else {
            var easeFunction = ENGINE.mathLinearTween;
        }
        var _local2 = ENGINE.findAngle(start_x, start_y, target_x, target_y);
        var d = ENGINE.findDirection(_local2);
        var duration = (_local3 / 4);
        if(Players[player_id].Speed != 'off') {
            var duration = (_local3 / Players[player_id].Speed);
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

function OpenGlows() {  
    _global.handleJoinRoom = function(obj) {
        for(var Index in obj){
            PlayerArray = obj[Index].split("|");
            UpdatePlayer(PlayerArray);     
        }   
    }
    AIRTOWER.addListener("jr", _global.handleJoinRoom);  
     
    _global.handleAddPlayer = function(obj) {     
        Player = obj.shift();     
        PlayerArray = Player.split("|");     
        UpdatePlayer(PlayerArray);     
        SetGlows();   
    }   
    AIRTOWER.addListener("ap", _global.handleAddPlayer);   
    
    _global.handleUpdatePlayer = function(obj) {     
        v = obj.shift();     
        Player = obj.shift();     
        PlayerArray = Player.split("|");     
        UpdatePlayer(PlayerArray);     
        SetGlows();   
    }   
    AIRTOWER.addListener("up", _global.handleUpdatePlayer); 
    
    _global.showEmoteBalloon = function(obj) {
        obj.shift();
        id = obj[0];
        color = Players[id].BubbleColor;
        if(color) {
            var _loc3_ = new Color(INTERFACE.balloons_mc["p" + id].balloon_mc);
            var _loc4_ = new Color(INTERFACE.balloons_mc["p" + id].pointer_mc);
            _loc3_.setRGB(color);
            _loc4_.setRGB(color);
        }
    }
    AIRTOWER.addListener("se", _global.showEmoteBalloon);
}
OpenGlows();
