function goArmor() {
    getURL("http://armorgames.com/", "_blank");
}
function dist(x1, y1, x2, y2) {
    return Math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
}
stop();
var myMenu = new ContextMenu();
myMenu.hideBuiltInItems();
_root.menu = myMenu;
k = 0;
onEnterFrame = function() {
    var _loc2_ = Math.floor(framesLoaded / 4) - 1;
    afw._x -= 0.3 * ((afw._x - _root["b" + _loc2_]._x) / 2);
    afw._y -= 0.3 * ((afw._y - _root["b" + _loc2_]._y) / 2);
    cat.removeMovieClip();
    createEmptyMovieClip("cat", k++);
    cat.lineStyle(1, 15132390, 100);
	loaded = _root.getBytesLoaded();
    total = _root.getBytesTotal();
    framesLoaded = Math.ceil(loaded / total * 100);
	if (framesLoaded >= 100 && playMe.act == false) {
        playMe.act = true;
        playMe.play();
    }
    perDisp = framesLoaded + "%";
    i = 0;
	while(i < 25) {
        if (framesLoaded >= i * 4) {
            _root["b" + i]._alpha -= 0.08 * ((_root["b" + i]._alpha -                  100) / 2);
            _root["b" + i]._x     -= 0.3  * ((_root["b" + i]._x     - _root["b" + i].mainX) / 2);
            _root["b" + i]._y     -= 0.3  * ((_root["b" + i]._y     - _root["b" + i].mainY) / 2);
            if(i != 0) {}
        }
        base = 1.5;
		if (_root["b" + i].hitTest(_xmouse, _ymouse)) {
            if (_xmouse - _root["b" + i]._x > 0) {
                t = 0;
                while(t < 25) {
                    _root["b" + (i - t)]._x -= base / (t + 1);
                    _root["b" + (i + t)]._x -= base / (t + 1);
                    t++;
                }
            } else if(_xmouse - _root["b" + i]._x <= 0) {
                t = 0;
                while(t < 25) {
                    _root["b" + (i - t)]._x += base / (t + 1);
                    _root["b" + (i + t)]._x += base / (t + 1);
                    t++;
                }
            }
            if(_ymouse - _root["b" + i]._y > 0) {
                t = 0;
                while(t < 25) {
                    _root["b" + (i - t)]._y -= base / (t + 1);
                    _root["b" + (i + t)]._y -= base / (t + 1);
                    t++;
                }
            } else if(_ymouse - _root["b" + i]._y <= 0) {
                t = 0;
                while(t < 25) {
                    _root["b" + (i - t)]._y += base / (t + 1);
                    _root["b" + (i + t)]._y += base / (t + 1);
                    t++;
                }
            }
        }
        i++;
    }
};
i = 0;
while(i < 25) {
    _root["b" + i].mainX = _root["b" + i]._x;
    _root["b" + i].mainY = _root["b" + i]._y;
    _root["b" + i]._x = random(Stage.width);
    _root["b" + i]._y = random(Stage.height);
    _root["b" + i]._alpha = 0;
    _root["b" + i].act = true;
    i++;
}
