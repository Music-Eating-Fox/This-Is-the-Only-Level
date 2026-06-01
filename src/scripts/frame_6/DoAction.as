////////////////////////////////////////////////////////////////
//															  //
//							FRAME 6							  //
//						 	(Game)  						  //
//															  //
////////////////////////////////////////////////////////////////

function resetLevel() {
    bPress = 0;
    totJumps = 0;
    doorOpen = false;
    doorTimer = 0;
    i = 0;
    while(i < doorAlreadyOpen.length) {
        if(doorAlreadyOpen[i] == level) {
            doorOpen = true;
            break;
        }
        i++;
    }
    if(level == 26 && pressedCreditsButton) {
        doorOpen = true;
    }
    i = 0;
    while(i < tiles.length) {
        tiles[i]._alpha = 100;
        if(tiles[i].nameChange) {
            tiles[i]._x = tiles[i].holdX;
            tiles[i]._y = tiles[i].holdY;
            tiles[i].onEnterFrame = null;
            tiles[i]._name = "tile" + tiles[i].posX + "x" + tiles[i].posY;
            tiles[i].nameChange = false;
        }
        i++;
    }
    if(level == 27) {
        camFrame.removeMovieClip();
        attachMovie("camFrame","camFrame",k++);
        camFrame._xscale = 20;
        camFrame._yscale = 20;
    }
    if(level == 14 && reloadFourteen) {
        doorOpen = true;
    }
    if(level == 19 || level == 29) {
        blinded._visible = true;
    } else {
        blinded._visible = false;
    }
    if(level == 18) {
        rate = 10;
    } else {
        rate = 1;
    }
    if(level == 4) {
        yGrav = 0.05;
        xGrav = 0;
    } else {
        yGrav = 0.6;
        xGrav = 0;
    }
    if(level == 5) {
        xF = 1;
        yF = 1;
        thudThresh = 2;
        bounce = -1;
    } else {
        xF = 0.5;
        yF = 1;
        bounce = -0.3;
        thudTresh = 2;
    }
    if(level == 12) {
        track.gotoAndPlay(2);
        track._visible = true;
        elephant._visible = false;
    } else {
        elephant._visible = true;
        track._visible = false;
    }
    player.xVel = 0;
    player.yVel = 10;
    player._x = home._x;
    player._y = home._y;
    home.gotoAndPlay(2);
    home.swapDepths(k++);
    exit.swapDepths(k++);
}
function handleExit() {
    if(player.hitTest(exit._x,exit._y) && cStatus == 1) {
        winLevel();
    }
}
function handleSlideDoor() {
    if(doorOpen) {
        slideDoor.gotoAndStop(2);
    } else {
        slideDoor.gotoAndStop(1);
    }
    if(level != 25) {
        if(player.hitTest(slideDoor)) {
            player._x = slideDoor._x - 7;
            player.xVel = 0;
        }
    }
    if(level == 27) {
        camFrame._x = player._x;
        camFrame._y = player._y;
        camFrame._xscale = 20;
        camFrame._yscale = 20;
    }
}
function winLevel() {
    if(level == 27) {
        camFrame.removeMovieClip();
        _root._x = 0;
        _root._y = 0;
        _root._xscale = _root._yscale = 100;
    }
    attachMovie("levelComplete","levelComplete",k++);
    cStatus = 2;
}
function nextLevel() {
    level++;
    saveGame();
    if(level == 30) {
        killSwitch();
        gotoAndStop("win");
    } else {
        resetLevel();
        reColour();
        cStatus = 1;
    }
}
function reColour() {
    spikeColour = Math.random() * 16777215;
    tileColour = Math.random() * 16777215;
    sTileColour = Math.random() * 16777215;
    i = 0;
    while(i < tiles.length) {
        setMCColour(tiles[i],tileColour);
        i++;
    }
    i = 0;
    while(i < spikes.length) {
        setMCColour(spikes[i],spikeColour);
        i++;
    }
    if(level == 7) {
        i = 0;
        while(i < tiles.length) {
            if(tiles[i]._x % 75 == 0) {
                setMCColour(tiles[i],sTileColour);
            }
            i++;
        }
    }
    if(level == 20) {
        i = 0;
        while(i < tiles.length) {
            if(tiles[i]._x % 50 == 0) {
                setMCColour(tiles[i],sTileColour);
            }
            i++;
        }
    }
}
function addSpikes(mov) {
    spikes.push(mov);
}
function handleSpikes() {
    i = 0;
    while(i < spikes.length) {
        curSpike = spikes[i];
        if(curSpike.hitTest(player)) {
            if(level == 6) {
                player.yVel -= 10;
            } else {
                addDeadElephant();
            }
            break;
        }
        i++;
    }
}
function handlePButton() {
    if(level == 23) {
        if(Key.isDown(20)) {
            doorOpen = true;
        } else {
            doorOpen = false;
        }
    }
    if(level == 28) {
        if(pButton._currentframe == 2) {
            doorTimer = 50;
            doorOpen = true;
        }
        if(doorTimer > 0) {
            doorTimer--;
        }
        if(doorTimer == 0) {
            doorOpen = false;
        }
    }
    if(level == 24) {
        if(seconds % 10 == 0) {
            doorOpen = true;
        } else {
            doorOpen = false;
        }
    }
    if(player.hitTest(pButton)) {
        pButton.gotoAndStop(2);
        buttonDown = true;
        i = 0;
        while(i < buttonOpens.length) {
            if(buttonOpens[i] == level) {
                doorOpen = true;
                break;
            }
            i++;
        }
        i = 0;
        while(i < buttonCloses.length) {
            if(buttonCloses[i] == level) {
                doorOpen = false;
                break;
            }
            i++;
        }
        if(level == 15 && bPress >= 5) {
            doorOpen = true;
        }
    } else {
        pButton.gotoAndStop(1);
        buttonDown = false;
    }
}
function addDeadElephant() {
    player.stopDrag();
    shel = attachMovie("deadElephant","ele" + k,k++);
    shel._x = elephant._x;
    shel._y = elephant._y;
    shel.xVel = player.xVel;
    shel.yVel = player.yVel;
    shel.xMax = 100;
    shel.yMax = 100;
    shel.counter = 100;
    deadElephants.push(shel);
    lifeCounter = 0;
    resetLevel();
    deaths++;
}
function deadElephantDealings() {
    i = 0;
    while(i < deadElephants.length) {
        curDead = deadElephants[i];
        normalVertical(curDead);
        bounding(curDead);
        curDead.counter--;
        if(curDead.counter < 10) {
            curDead._alpha = curDead.counter * 10;
        }
        if(curDead.counter == 0) {
            deadElephants.splice(i,1);
            curDead.removeMovieClip();
        }
        i++;
    }
}
function barUI() {
    if(cStatus == 1 || cStatus == 2 && !paused) {
        miliSeconds += frameTime;
        if(miliSeconds > 100) {
            miliSeconds -= 100;
            seconds++;
        }
        if(seconds == 60) {
            seconds = 0;
            minutes++;
        }
    }
    timeDispString = formatTime(minutes,seconds,miliSeconds);
    i = 0;
    while(i < timeDispString.length) {
        _root["d" + i] = timeDispString.charAt(i);
        i++;
    }
    stageDisp = "Stage " + (level + 1);
    deathsDisp = "Deaths: " + deaths;
    stageHint = stageHints[level];
}
function formatTime(m, s, ms) {
    if(ms < 10) {
        miliSecondsDisp = "0" + ms;
    } else {
        miliSecondsDisp = String(ms);
    }
    if(s < 10) {
        secondsDisp = "0" + s;
    } else {
        secondsDisp = String(s);
    }
    if(m < 10) {
        minutesDisp = "0" + m;
    } else {
        minutesDisp = String(m);
    }
    return minutesDisp + ":" + secondsDisp + ":" + miliSecondsDisp;
}
function normalVertical(mc) {
    if(!(mc == player && level == 3 && mouseDown)) {
        if(level == 20) {
            if(Math.floor(mc._x / 25) % 2 == 0) {
                yGrav = -0.6;
            } else {
                yGrav = 0.6;
            }
            mc.xVel += xGrav;
            mc.yVel += yGrav;
        } else {
            mc.xVel += xGrav;
            mc.yVel += yGrav;
        }
    }
    if(mc.yLove == 1) {
        if(!holdUp) {
            mc.yVel = mc.yVel + 1;
        }
        if(mc.yVel >= 0) {
            mc.yLove = 2;
            mc.yVel = 0;
        }
    }
    if(mc.yLove == 2 || mc.yLove == 3) {
        if(mc.yVel > 0) {
            mc.yLove = 3;
        }
    }
    if(mc.yLove == 3 && mc.yVel == 0 && !holdUp) {
        mc.yLove = 0;
        holdCounter = 0;
    }
    if(mc.yLove == 0 && mc.yVel > 1.5) {
        mc.yLove = 3;
    }
    if(mc.yLove == 0) {
        playerJump = false;
    }
}
function movePlayer() {
    if(player._y < 10 || player._x > 690 || player._y > 490 || player._x < 10) {
        addDeadElephant();
    }
    if(level == 9) {
        player._x -= 5;
    }
    if(level == 21) {
        if(player._x > 425 && player._x < 475 && player._y > 120) {
            player._x = 425;
        }
        if(player._x > 475 && player._x < 525 && player._y > 120) {
            player._x = 525;
        }
    }
    var _loc3_;
    if(level == 29) {
        blinded._alpha = 100 * (player._x / 250);
        _loc3_ = new Color(blinded);
        _loc3_.setRGB(0);
    }
    if(level == 7) {
        i = 0;
        while(i < tiles.length) {
            if(tiles[i]._x % 75 == 0 && tiles[i]._x <= 600) {
                if(tiles[i].hitTest(player._x,player._y)) {
                    addDeadElephant();
                }
            }
            i++;
        }
    }
    if(level == 17) {
        i = 0;
        while(i < tiles.length) {
            if(tiles[i].hitTest(player._x,player._y)) {
                tiles[i].yV = 0;
                if(this._alpha == 100) {
                    tiles[i].onEnterFrame = function() {
                        this._alpha -= 5;
                        if(this._alpha < 65 && !this.nameChange) {
                            this._name = "FEWF" + random(430);
                            this.nameChange = true;
                        }
                        if(this.nameChange) {
                            this._y += this.yV;
                            this.yV += _root.yGrav;
                            this._alpha = 99;
                        }
                    };
                }
            }
            i++;
        }
    }
    if(Key.isDown(37)) {
        if(level == 1) {
            player.xVel = player.dXVel;
        } else if(!(level == 3 || level == 8 || level == 10 || level == 22)) {
            if(level == 12) {
                if(trackTarg == "l") {
                    trackTarg = "r";
                    track.nextFrame();
                }
            } else {
                player.xVel = - player.dXVel;
            }
        }
    } else if(Key.isDown(39)) {
        if(level == 1) {
            player.xVel = - player.dXVel;
        } else if(!(level == 3 || level == 8 || level == 22)) {
            if(level == 12) {
                if(trackTarg == "r") {
                    trackTarg = "l";
                    track.nextFrame();
                }
            } else {
                player.xVel = player.dXVel;
            }
        }
    } else {
        player.xVel = 0;
    }
    if(level == 22) {
        if(Key.isDown(72)) {
            player.xVel = player.dXVel;
        }
        if(Key.isDown(70)) {
            player.xVel = - player.dXVel;
        }
        if(Key.isDown(84)) {
            doTheJump();
        }
    }
    if(Key.isDown(40) && level == 1) {
        doTheJump();
    } else if(!(level == 3 || level == 6 || level == 8 || level == 11 || level == 12 || level == 22)) {
        if(level == 13) {
            if(Key.isDown(38) && totJumps < 1) {
                doTheJump();
            }
        } else if(level != 22) {
            if(Key.isDown(38)) {
                doTheJump();
            } else {
                holdUp = false;
                jumpCounter = 0;
            }
        }
    }
    if(level == 8) {
        if(_xmouse > oldX) {
            player.xVel = player.dXVel * 2;
        } else if(_xmouse < oldX) {
            player.xVel = - player.dXVel * 2;
        }
        oldX = _xmouse;
        oldY = _ymouse;
    }
}
function skinning() {
    elephant._x = Math.floor(player._x);
    elephant._y = Math.floor(player._y);
    if(Key.isDown(37) || Key.isDown(70) && level == 22) {
        elephant.gotoAndStop(2);
        elephant._xscale = 100;
    } else if(Key.isDown(39) || Key.isDown(72) && level == 22) {
        elephant.gotoAndStop(2);
        elephant._xscale = -100;
    } else {
        elephant.gotoAndStop(1);
        if(Key.isDown(38)) {
        }
    }
}
function doTheJump() {
    jumpCounter++;
    holdUp = true;
    if(player.yLove == 0 && jumpLevel) {
        playerJump = true;
        jumpLevel = false;
        player.yVel = hops;
        player.yLove = 1;
        bounceSound.start(0,1);
        totJumps++;
    }
}
function nameTile(mov) {
    mov._x = Math.round(mov._x);
    mov._y = Math.round(mov._y);
    mov.holdX = mov._x;
    mov.holdY = mov._y;
    mov.posX = Math.floor(mov._x / _root.tileSize);
    mov.posY = Math.floor(mov._y / _root.tileSize);
    mov.touched = false;
    var _loc0_;
    if((_loc0_ = mov.type) === 1) {
        mov._name = "tile" + mov.posX + "x" + mov.posY;
    }
    tiles.push(mov);
}
function bounding(mc) {
    tt = 0;
    while(tt < spikes.length) {
        curSpike = _root["spike" + spikes[tt]];
        if(!curSpike.hitTest(mc)) {
        }
        tt++;
    }
    if(mc.xVel * 0 != 0) {
        mc.xVel = 0;
    }
    if(mc.yVel * 0 != 0) {
        mc.yVel = 0;
    }
    curLevelNum = Math.floor(mc._y / 900) + 1;
    tempCurLevel = _root;
    if(mc.yVel < 0) {
        if(checkCoords(mc,mc._x,mc._y + mc.yVel,0,tempCurLevel)) {
            mc._y += mc.yVel;
        } else {
            mc.xVel *= xF;
            mc.yVel *= bounce;
            mc.rotSpeed *= -1;
            mc._y = mc.tr._y + tileSize + mc._height + (curLevelNum - 1) * 900;
            if(mc.yVel < thudTresh && mc.yVel > - thudTresh && (xGrav != 0 || yGrav != 0)) {
                mc.yVel = 0;
            }
        }
    } else if(mc.yVel > 0) {
        if(checkCoords(mc,mc._x,mc._y + mc.yVel,1,tempCurLevel)) {
            mc._y += mc.yVel;
        } else {
            if(mc._name == "player" && mc.yVel > bounceTolerance) {
                bounceSound.start(0,1);
            } else if(mc.yVel > bounceTolerance) {
                bulletDropSound.start(0,1);
            }
            mc.xVel *= xF;
            mc.yVel *= bounce;
            jumping = false;
            mc._y = mc.br._y + (curLevelNum - 1) * 900;
            if(mc.yVel < thudTresh && mc.yVel > - thudTresh && (xGrav != 0 || yGrav != 0)) {
                mc.yVel = 0;
            }
            if(Math.abs(mc.yVel) > 6) {
                mc.rotSpeed *= random(8) - 4;
            } else {
                mc.rotSpeed *= 0.5;
            }
        }
    }
    if(mc.xVel < 0) {
        if(checkCoords(mc,mc._x + mc.xVel,mc._y,3,tempCurLevel)) {
            mc._x += mc.xVel;
        } else {
            mc.yVel *= yF;
            mc.xVel *= bounce;
            if(mc._name == "player" && mc.xVel < bounceTolerance) {
                bounceSound.start(0,1);
            }
            mc._x = mc.bl._x + mc._width / 2 + tileSize;
            if(mc.xVel < thudTresh && mc.xVel > - thudTresh && (xGrav != 0 || yGrav != 0)) {
                mc.xVel = 0;
            }
        }
    } else if(mc.xVel > 0) {
        if(checkCoords(mc,mc._x + mc.xVel,mc._y,2,tempCurLevel)) {
            mc._x += mc.xVel;
        } else {
            mc.yVel *= yF;
            mc.xVel *= bounce;
            if(mc._name == "player" && mc.xVel > bounceTolerance) {
                bounceSound.start(0,1);
            }
            mc._x = mc.br._x - mc._width / 2;
            if(mc.xVel < thudTresh && mc.xVel > - thudTresh && (xGrav != 0 || yGrav != 0)) {
                mc.xVel = 0;
            }
        }
    }
    if(mc.xVel > mc.xMax) {
        mc.xVel = mc.xMax;
    }
    if(mc.xVel < - mc.xMax) {
        mc.xVel = - mc.xMax;
    }
    if(mc.yVel > mc.yMax) {
        mc.yVel = mc.yMax;
    }
    f;
    if(mc.yVel < - mc.yMax) {
        mc.yVel = - mc.yMax;
    }
}
function checkCoords(mc, x, y, direction, holder) {
    mc.ctlx = x - mc._width / 2 + 1;
    mc.ctly = y - mc._height + 1;
    mc.ctrx = x + mc._width / 2 - 1;
    mc.ctry = y - mc._height + 1;
    mc.cbrx = x + mc._width / 2 - 1;
    mc.cbry = y + mc._height * 0 - 1;
    mc.cblx = x - mc._width / 2 + 1;
    mc.cbly = y + mc._height * 0 - 1;
    mc.clmx = x - mc._width / 2 + 1;
    mc.clmy = y - mc._height / 2 + 1;
    mc.ctmx = x + 1;
    mc.ctmy = y - mc._height + 1;
    mc.crmx = x + mc._width / 2 - 1;
    mc.crmy = y - mc._height / 2 + 1;
    mc.cbmx = x + 1;
    mc.cbmy = y + mc._height * 0 - 1;
    mc.cbmx = x + 1;
    mc.cmx = x + 1;
    mc.cmy = y - mc._height / 2 + 1;
    mc.tl = holder["tile" + Math.floor(mc.ctlx / tileSize) + "x" + Math.floor(mc.ctly / tileSize)];
    mc.tr = holder["tile" + Math.floor(mc.ctrx / tileSize) + "x" + Math.floor(mc.ctry / tileSize)];
    mc.br = holder["tile" + Math.floor(mc.cbrx / tileSize) + "x" + Math.floor(mc.cbry / tileSize)];
    mc.bl = holder["tile" + Math.floor(mc.cblx / tileSize) + "x" + Math.floor(mc.cbly / tileSize)];
    mc.tm = holder["tile" + Math.floor(mc.ctmx / tileSize) + "x" + Math.floor(mc.ctmy / tileSize)];
    mc.lm = holder["tile" + Math.floor(mc.clmx / tileSize) + "x" + Math.floor(mc.clmy / tileSize)];
    mc.bm = holder["tile" + Math.floor(mc.cbmx / tileSize) + "x" + Math.floor(mc.cbmy / tileSize)];
    mc.rm = holder["tile" + Math.floor(mc.crmx / tileSize) + "x" + Math.floor(mc.crmy / tileSize)];
    mc.mb = holder["tile" + Math.floor(mc.cbmx / tileSize) + "x" + Math.floor(mc.cbly / tileSize)];
    if(mc.tl.type == 1) {
        guyTL = true;
        foundWhat = mc.tl;
        pass(mc.tl);
    } else {
        guyTL = false;
    }
    if(mc.tr.type == 1) {
        guyTR = true;
        foundWhat = mc.tr;
        pass(mc.tr);
    } else {
        guyTR = false;
    }
    if(mc.br.type == 1) {
        guyBR = true;
        foundWhat = mc.br;
        pass(mc.br);
    } else if(mc.br.type == 2 && mc.yVel > 0) {
        guyBR = true;
        foundWhat = mc.br;
    } else {
        guyBR = false;
    }
    if(mc.bl.type == 1) {
        guyBL = true;
        foundWhat = mc.bl;
        pass(mc.bl);
    } else if(mc.bl.type == 2 && mc.yVel > 0) {
        guyBL = true;
        foundWhat = mc.bl;
    } else {
        guyBL = false;
    }
    if(mc.tm.type == 1) {
        guyTM = true;
        foundWhat = mc.tm;
        pass(mc.tm);
    } else {
        guyTM = false;
    }
    if(mc.bm.type == 1) {
        guyBM = true;
        foundWhat = mc.bm;
        pass(mc.bm);
    } else {
        guyBM = false;
    }
    if(mc.lm.type == 1) {
        guyLM = true;
        foundWhat = mc.lm;
        pass(mc.lm);
    } else {
        guyLM = false;
    }
    if(mc.rm.type == 1) {
        guyRM = true;
        foundWhat = mc.rm;
        pass(mc.rm);
    } else {
        guyRM = false;
    }
    if(player == mc && guyBM || guyBL || guyBR) {
        mc.yLove = 0;
        holdCounter = 0;
    }
    if(player == mc && (guyBM && guyBL || guyBM && guyBR)) {
        jumpLevel = true;
    }
    if(guyBL || guyBR || guyBM && mc == player) {
    }
    switch(direction) {
        case 0:
            if(guyTL || guyTR) {
                return false;
            }
        case 1:
            if(guyBR || guyBL) {
                return false;
            }
        case 2:
            if(guyTR || guyBR) {
                return false;
            }
        case 3:
            if(guyTL || guyBL) {
                return false;
            }
    }
    return true;
}
function cashSnob(num) {
    if(num == Math.floor(num)) {
        return commaSnob(num) + ".00";
    }
    if(Math.floor((num - Math.floor(num)) * 100) == 0) {
        return commaSnob(Math.floor(num)) + "." + Math.floor((num - Math.floor(num)) * 100) + "0";
    }
    return commaSnob(Math.floor(num)) + "." + Math.floor((num - Math.floor(num)) * 100);
}
function dist(x1, y1, x2, y2) {
    return Math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
}
function commaSnob(num) {
    if(num < 1000) {
        return String(num);
    }
    var _loc3_ = String(num).length;
    var _loc4_ = new Array();
    var _loc1_ = 0;
    while(_loc1_ < _loc3_) {
        _loc4_.push(String(num).charAt(_loc3_ - 1 - _loc1_));
        _loc1_ = _loc1_ + 1;
    }
    var _loc2_ = new String();
    _loc1_ = 0;
    while(_loc1_ < _loc3_) {
        if(_loc1_ % 3 == 0 && _loc1_ != 0) {
            _loc2_ = _loc4_[_loc1_] + "," + _loc2_;
        } else {
            _loc2_ = _loc4_[_loc1_] + _loc2_;
        }
        _loc1_ = _loc1_ + 1;
    }
    return _loc2_;
}
function setMCColour(mc, c) {
    altColor = new Color(mc);
    altColor.setRGB(c);
}
function setColour(mc, rC, gC, bC, aC) {
    var _loc2_ = new flash.geom.ColorTransform(rC / 255,gC / 255,bC / 255,aC / 100,0,0,0,0);
    var _loc1_ = new flash.geom.Transform(mc);
    _loc1_.colorTransform = _loc2_;
}
function resetColour(mc) {
    var _loc2_ = new flash.geom.ColorTransform();
    var _loc3_ = new flash.geom.Transform(mc);
    mc.transform.colorTransform = new flash.geom.ColorTransform();
}
function rotateTo(x1, y1, x2, y2) {
    return (- Math.atan2(x2 - x1,y2 - y1)) * 180 / 3.141592653589793;
}
function drawCircle(mc, x, y, r) {
    mc.moveTo(x + r,y);
    mc.curveTo(r + x,0.4142135623730951 * r + y,0.7071067811865475 * r + x,0.7071067811865475 * r + y);
    mc.curveTo(0.4142135623730951 * r + x,r + y,x,r + y);
    mc.curveTo(-0.4142135623730951 * r + x,r + y,-0.7071067811865475 * r + x,0.7071067811865475 * r + y);
    mc.curveTo(- r + x,0.4142135623730951 * r + y,- r + x,y);
    mc.curveTo(- r + x,-0.4142135623730951 * r + y,-0.7071067811865475 * r + x,-0.7071067811865475 * r + y);
    mc.curveTo(-0.4142135623730951 * r + x,- r + y,x,- r + y);
    mc.curveTo(0.4142135623730951 * r + x,- r + y,0.7071067811865475 * r + x,-0.7071067811865475 * r + y);
    mc.curveTo(r + x,-0.4142135623730951 * r + y,r + x,y);
}
function elasticX(mc, targt, accel, friction) {
    if(mc.qxSpeed == undefined) {
        mc.qxSpeed = 0;
    }
    mc.qxSpeed += (targt - mc._x) * accel;
    mc.qxSpeed *= friction;
    mc._x += mc.qxSpeed;
}
function elasticY(mc, targt, accel, friction) {
    if(mc.qySpeed == undefined) {
        mc.qySpeed = 0;
    }
    mc.qySpeed += (targt - mc._y) * accel;
    mc.qySpeed *= friction;
    mc._y += mc.qySpeed;
}
function elasticScale(mc, targt, accel, friction) {
    if(mc.qxScale == undefined) {
        mc.qxScale = 0;
    }
    mc.qxScale += (targt - mc._xscale) * accel;
    mc.qxScale *= friction;
    mc._xscale = mc._yscale += mc.qxScale;
}
function elasticXScale(mc, targt, accel, friction) {
    if(mc.qxxScale == undefined) {
        mc.qxxScale = 0;
    }
    mc.qxxScale += (targt - mc._xscale) * accel;
    mc.qxxScale *= friction;
    mc._xscale += mc.qxxScale;
}
function elasticRotation(mc, targt, accel, friction) {
    if(mc.qrSpeed == undefined) {
        mc.qrSpeed = 0;
    }
    mc.qrSpeed += (targt - mc._rotation) * accel;
    mc.qrSpeed *= friction;
    mc._rotation += mc.qrSpeed;
}
function muteHandler() {
    mute = !mute;
    if(mute) {
        s.setVolume(0);
    } else {
        s.setVolume(100);
    }
}
function pauseHandler() {
    paused = !paused;
}
stop();
var bounceSound = new Sound(this);
bounceSound.attachSound("jumpSound");
var tileSize = 25;
var cStatus = 1;
var k = 0;
var spikes = new Array();
var tiles = new Array();
var deadElephants = new Array();
player.yVel = 0;
player.xVel = 0;
player.dXVel = 7;
player.xMax = 30;
player.yMax = 20;
player._visible = false;
player.yLove = 0;
var yGrav = 0.6;
var xGrav = 0;
var bPress = 0;
var bounce = -0.3;
var thudTresh = 2;
var xF = 0.5;
var yF = 1;
var trackTarg = "r";
var hops = -10;
var doorOpen = false;
var buttonDown = false;
var hitButton = false;
holdUp = false;
playerJump = false;
jumpLevel = false;
var easePoint = 0;
var airCounter = 0;
var jumpCounter = 0;
var lifeCounter = 0;
var totJumps = 0;
var firstFrame = false;
var doorTimer = 0;
var frameCounter = 0;
var rate = 1;
var minutesDisp = "";
var secondsDisp = "";
var miliSecondsDisp = "";
var timeDispString = "";
var mute = false;
var s = new Sound(this);
var paused = false;
onEnterFrame = function() {
    if(!paused) {
        frameCounter++;
        if(frameCounter % rate == 0) {
            frameCounter = 0;
            if(cStatus == 1) {
                movePlayer();
                normalVertical(player);
                bounding(player);
                skinning();
                handleSpikes();
                handlePButton();
                deadElephantDealings();
                handleSlideDoor();
                handleExit();
                barUI();
            }
            if(cStatus == 2) {
                deadElephantDealings();
                handleExit();
                barUI();
            }
        }
    }
    if(!firstFrame) {
        firstFrame = true;
        reColour();
    }
};
var doorAlreadyOpen = new Array();
doorAlreadyOpen.push(2);
doorAlreadyOpen.push(3);
doorAlreadyOpen.push(11);
doorAlreadyOpen.push(12);
onMouseDown = function() {
    mouseDown = true;
    if(cStatus == 1) {
        if(level == 3) {
            player.startDrag(true);
        }
        if(level == 8) {
            doTheJump();
        }
    }
};
onMouseUp = function() {
    mouseDown = false;
    if(level == 3) {
        player.stopDrag();
    }
};
var buttonOpens = new Array(0,1,3,4,5,6,7,8,9,10,11,12,13,16,18,19,20,21,22,27,28,29);
var buttonCloses = new Array(2,99);
resetLevel();
stop();
