var mytrack = document.getElementById('mytrack');
var playButton = document.getElementById('playButton');
var muteButton = document.getElementById('muteButton');
var fwdButton = document.getElementById('fwdButton');
var rwdButton = document.getElementById('rwdButton');
var likeButton = document.getElementById('likeButton');
var dislikeButton = document.getElementById('dislikeButton');
var volumeslider = document.getElementById("volumeslider");
var canvas, ctx, source, context, analyser, fbc_array, bars, bar_x, bar_width, bar_height;

var barSize = 640;
var bar = document.getElementById('defaultBar');
var baprogressBar = document.getElementById('progressBar');
var mouseX =  0;

bar.addEventListener('click',clickedBar,false);
playButton.addEventListener('click',playOrPause,false);
muteButton.addEventListener('click',muteOrUnmute,false);
fwdButton.addEventListener('click',forward,false);
rwdButton.addEventListener('click',rewind,false);
likeButton.addEventListener('click',like,false);
dislikeButton.addEventListener('click',dislike,false);
volumeslider.addEventListener("change",setvolume,false);


var wavesurfer = WaveSurfer.create({
    container: '#waveform',
    waveColor: 'violet',
    progressColor: 'purple'
});



function playOrPause(){
	if(!mytrack.paused && !mytrack.ended){
		mytrack.pause();
		playButton.style.backgroundImage = 'url(../images/media_play.png)';
	}
	else{
		mytrack.play();
		playButton.style.backgroundImage = 'url(../images/media_pause.png)';
		wavesurfer.load('../audio/nm.mp3');
	}
}

function muteOrUnmute(){
	if(mytrack.muted == true){
		mytrack.muted = false;
		muteButton.style.backgroundImage = 'url(../images/speaker.png)';
	}
	else{
		mytrack.muted = true;
		muteButton.style.backgroundImage = 'url(../images/mute.png)';
	}
}

function forward(){
	if(!mytrack.ended){
		mouseX = mouseX +( mytrack.duration/barSize + 15);
		var newtime =  mouseX;
		
		mytrack.currentTime = newtime;
		progressBar.style.width = mouseX + "px";
	}
}

function rewind(){
	if(!mytrack.ended){
		mouseX = mouseX +( mytrack.duration/barSize - 15);
		var newtime =  mouseX;
		
		mytrack.currentTime = newtime;
		progressBar.style.width = mouseX + "px";
	}
}

function like(){
	likeButton.style.backgroundImage = 'url(../images/lik.png)';
}

function dislike(){
	dislikeButton.style.backgroundImage = 'url(../images/dis.png)';
}


function updateTrackTime(track){
  var currTimeDiv = document.getElementById('currentTime');
  var durationDiv = document.getElementById('fullDuration');
  
  var size = parseInt(track.currentTime*barSize/track.duration);
  progressBar.style.width = size + "px";

  var currTime = Math.floor(track.currentTime).toString(); 
  var duration = Math.floor(track.duration).toString();

  currTimeDiv.innerHTML = formatSecondsAsTime(currTime);

  if (isNaN(duration)){
    durationDiv.innerHTML = '00:00';
  } 
  else{
    durationDiv.innerHTML = formatSecondsAsTime(duration);
  }
  
  if(track.ended){
	  currTimeDiv.innerHTML = "0.00";
	  playButton.style.backgroundImage = 'url(../images/media_play.png)';
	  progressBar.style.width = "0px";
  }
}

function formatSecondsAsTime(secs, format) {
  var hr  = Math.floor(secs / 3600);
  var min = Math.floor((secs - (hr * 3600))/60);
  var sec = Math.floor(secs - (hr * 3600) -  (min * 60));

  if (min < 10){ 
    min = "0" + min; 
  }
  if (sec < 10){ 
    sec  = "0" + sec;
  }

  return min + ':' + sec;
}

function clickedBar(e){
	if(!mytrack.ended){
		mouseX = e.pageX - bar.offsetLeft;
		var newtime = mouseX * mytrack.duration/barSize;
		
		mytrack.currentTime = newtime;
		progressBar.style.width = mouseX + "px";
	}
}

function setvolume(){
	mytrack.volume = volumeslider.value / 100;
}