////////////////////////////////////////////////////////////////
//															  //
//							FRAME 1							  //
//						   (Preload)						  //
//															  //
////////////////////////////////////////////////////////////////

/**
 * @description Retrieves the ArmorGames website link.
*/
function goArmor() {
    getURL("http://armorgames.com/", "_blank");
}

/**
 * ### -- Unused --
 * Gets the distance between two points.
 * 
 * @param {number} x1 "X" coordinate of 1st point.
 * @param {number} y1 "Y" coordinate of 1st point.
 * @param {number} x2 "X" coordinate of 2nd point.
 * @param {number} y2 "Y" coordinate of 2nd point.
 * 
 * @returns {number} The distance between (x1, y1) and (x2, y2)
 */
function dist(x1, y1, x2, y2) {
    return Math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
}

stop();

// Setup Context Menu (right click interaction) and clears the default items (e.g., copy, cut, paste, &c.)
var myMenu = new ContextMenu();
myMenu.hideBuiltInItems();
_root.menu = myMenu;

k = 0;

/**
 * Runs every frame
 * @returns {void}
 */
onEnterFrame = function() {
	// Get offset of location based on the number of loaded frames, 0-indexed.
    var _loc2_ = Math.floor(framesLoaded / 4) - 1;

	// 
    afw._x -= 0.3 * ((afw._x - _root["b" + _loc2_]._x) / 2);
    afw._y -= 0.3 * ((afw._y - _root["b" + _loc2_]._y) / 2);

    cat.removeMovieClip  ();
    createEmptyMovieClip ("cat", k++);
    cat.lineStyle        (1, 15132390, 100);
    
	// Get percentage of loaded bytes
	loaded       = _root.getBytesLoaded();
    total        = _root.getBytesTotal();
    framesLoaded = Math.ceil(loaded / total * 100);
    
	// Do something once `framesLoaded` reaches 100.
	if (framesLoaded >= 100 && playMe.act == false) {
        playMe.act = true;
        playMe.play();
    }

	// Display
    perDisp = framesLoaded + "%";

    for (i = 0; i < 25; i++) {
        if (framesLoaded >= i * 4) {
			// 
            _root["b" + i]._alpha -= 0.08 * ((_root["b" + i]._alpha -                  100) / 2);
            _root["b" + i]._x     -= 0.3  * ((_root["b" + i]._x     - _root["b" + i].mainX) / 2);
            _root["b" + i]._y     -= 0.3  * ((_root["b" + i]._y     - _root["b" + i].mainY) / 2);

			// Useless
            if(i != 0) {}
        }

        base = 1.5;
        
		// If the mouse if over one of these "b" frames
		if (_root["b" + i].hitTest(_xmouse, _ymouse)) {
            if (_xmouse - _root["b" + i]._x > 0) {
                for (t = 0; t < 25; t++) {
                    _root["b" + (i - t)]._x -= base / (t + 1);
                    _root["b" + (i + t)]._x -= base / (t + 1);
                    t++;
                }
            } else if(_xmouse - _root["b" + i]._x <= 0) {
                for (t = 0; t < 25; t++) {
                    _root["b" + (i - t)]._x += base / (t + 1);
                    _root["b" + (i + t)]._x += base / (t + 1);
                    t++;
                }
            }

            if (_ymouse - _root["b" + i]._y > 0) {
                for (t = 0; t < 25; t++) {
                    _root["b" + (i - t)]._y -= base / (t + 1);
                    _root["b" + (i + t)]._y -= base / (t + 1);
                    t++;
                }
            } else if(_ymouse - _root["b" + i]._y <= 0) {
                for (t = 0; t < 25; t++) {
                    _root["b" + (i - t)]._y += base / (t + 1);
                    _root["b" + (i + t)]._y += base / (t + 1);
                    t++;
                }
            }
        }
    }
};

for (i = 0; i < 25; i++) {
    _root["b" + i].mainX  = _root["b" + i]._x;
    _root["b" + i].mainY  = _root["b" + i]._y;
    _root["b" + i]._x     = random(Stage.width );
    _root["b" + i]._y     = random(Stage.height);
    _root["b" + i]._alpha = 0;
    _root["b" + i].act    = true;
    i++;
}
