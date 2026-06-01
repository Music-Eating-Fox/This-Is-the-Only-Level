////////////////////////////////////////////////////////////////
//															  //
//							FRAME 2							  //
//					   (Initialization)						  //
//															  //
////////////////////////////////////////////////////////////////

/**
 * Saves the game data.
 */
function saveGame() {
    savefile.data.deaths      = deaths;
    savefile.data.seconds     = seconds;
    savefile.data.miliSeconds = miliSeconds;
    savefile.data.minutes     = minutes;
    savefile.data.level       = level;
    savefile.data.saved       = true;

    savefile.flush();
    
	trace("Game Saved!");
    trace("deaths: " + savefile.data.deaths);
    trace("level: "  + savefile.data.level );
}

/**
 * Loads saved game data.
 */
function loadGame() {
    deaths      = savefile.data.deaths;
    seconds     = savefile.data.seconds;
    miliSeconds = savefile.data.miliSeconds;
    minutes     = savefile.data.minutes;
    level       = savefile.data.level;

    if (level == 14) {
        trace("RELOADED 14!");
        reloadFourteen = true;
    } else {
        reloadFourteen = false;
    }

    trace("Game Loaded!");
    trace("deaths: " + deaths);
    trace("level: "  + level);
}

/**
 * Creates a new save file.
 */
function newData() {
    trace("NEW DATA!");
    deaths      = 0;
    seconds     = 0;
    miliSeconds = 0;
    minutes     = 0;
    level       = 0;
    saveGame();
}

/**
 * Sets `onEnterFrame` to `null`; removes all movie clips.
 */
function killSwitch() {
    onEnterFrame = null;
    for (var _loc2_ in _root) {
        if (typeof _root[_loc2_] == "movieclip") {
            _root[_loc2_].removeMovieClip();
        }
    }
}

/**
 * Stops the current level and loads the menu screen
 */
function gotoMenu() {
    killSwitch();
    gotoAndStop("menu");
}

var level                = 0;
var deaths               = 0;
var seconds              = 0;
var miliSeconds          = 0;
var minutes              = 0;
var reloadFourteen       = false;
var frameTime            = 2.5;
var pressedCreditsButton = false;
var stageHints           = [
	"Arrow keys required",
	"Not always straight forward",
	"Think before doing",
	"Alternate control scheme",
	"Freefloating",
	"A bit bouncy here",
	"Dull appearances",
	"Candy stripes of doom",
	"Arrow control",
	"Heavy headwind, here",
	"No returns, no refunds",
	"Stay low",
	"Left Right March",
	"One Leap of Faith",
	"Time to refresh",
	"Keep hitting it",
	"Worried about nothing",
	"Collapse",
	"Stuttering",
	"Do you remember?",
	"Inbetween gravitii",
	"Mime\'s folly",
	"Center keyboarder",
	"UPPERCASE",
	"When it feels like it",
	"Or is it",
	"Credit page",
	"Oh ho, so close",
	"Closing shop",
	"No sweat.",
];

var savefile = SharedObject.getLocal("finalLevel");

// If save file doesn't exist and needs to be saved, create new save file.
if (savefile.data.saved != true || savefile.data.saved == undefined) {
    trace("Can\'t find new data.");
    newData();
} else {
    loadGame();
}

stop();
