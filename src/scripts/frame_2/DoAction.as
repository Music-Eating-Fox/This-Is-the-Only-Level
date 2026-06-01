function saveGame() {
    savefile.data.deaths = deaths;
    savefile.data.seconds = seconds;
    savefile.data.miliSeconds = miliSeconds;
    savefile.data.minutes = minutes;
    savefile.data.level = level;
    savefile.data.saved = true;
    savefile.flush();
    trace("Game Saved!");
    trace("deaths: " + savefile.data.deaths);
    trace("level: " + savefile.data.level);
}
function loadGame() {
    deaths = savefile.data.deaths;
    seconds = savefile.data.seconds;
    miliSeconds = savefile.data.miliSeconds;
    minutes = savefile.data.minutes;
    level = savefile.data.level;
    if(level == 14) {
        trace("RELOADED 14!");
        reloadFourteen = true;
    } else {
        reloadFourteen = false;
    }
    trace("Game Loaded!");
    trace("deaths: " + deaths);
    trace("level: " + level);
}
function newData() {
    trace("NEW DATA!");
    deaths = 0;
    seconds = 0;
    miliSeconds = 0;
    minutes = 0;
    level = 0;
    saveGame();
}
function killSwitch() {
    onEnterFrame = null;
    for(var _loc2_ in _root) {
        if(typeof _root[_loc2_] == "movieclip") {
            _root[_loc2_].removeMovieClip();
        }
    }
}
function gotoMenu() {
    killSwitch();
    gotoAndStop("menu");
}
var level = 0;
var deaths = 0;
var seconds = 0;
var miliSeconds = 0;
var minutes = 0;
var reloadFourteen = false;
var frameTime = 2.5;
var pressedCreditsButton = false;
var stageHints = new Array();
stageHints.push("Arrow keys required");
stageHints.push("Not always straight forward");
stageHints.push("Think before doing");
stageHints.push("Alternate control scheme");
stageHints.push("Freefloating");
stageHints.push("A bit bouncy here");
stageHints.push("Dull appearances");
stageHints.push("Candy stripes of doom");
stageHints.push("Arrow control");
stageHints.push("Heavy headwind, here");
stageHints.push("No returns, no refunds");
stageHints.push("Stay low");
stageHints.push("Left Right March");
stageHints.push("One Leap of Faith");
stageHints.push("Time to refresh");
stageHints.push("Keep hitting it");
stageHints.push("Worried about nothing");
stageHints.push("Collapse");
stageHints.push("Stuttering");
stageHints.push("Do you remember?");
stageHints.push("Inbetween gravitii");
stageHints.push("Mime\'s folly");
stageHints.push("Center keyboarder");
stageHints.push("UPPERCASE");
stageHints.push("When it feels like it");
stageHints.push("Or is it");
stageHints.push("Credit page");
stageHints.push("Oh ho, so close");
stageHints.push("Closing shop");
stageHints.push("No sweat.");
var savefile = SharedObject.getLocal("finalLevel");
if(savefile.data.saved != true || savefile.data.saved == undefined) {
    trace("Can\'t find new data.");
    newData();
} else {
    loadGame();
}
stop();
