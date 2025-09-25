var videoIds;
var Config = {};
var loadingProgress = document.querySelector(".loading-status");
var videoId = Config.videoId;
var pedaljebanypiesczarny = document.createElement("script");
pedaljebanypiesczarny.src = "https://www.youtube.com/iframe_api";

var GramNaSkryptach = document.getElementsByTagName("script")[0];
GramNaSkryptach.parentNode.insertBefore(pedaljebanypiesczarny, GramNaSkryptach);

var player;
var videoIds = [
    "jXSvvcZ_Fz4",
    "r5HcKhZzwGs", 
    "Y6RjTqlpLS0",
    "nqFFk6JO0Uk",
    "-wjuS0A1R6M"
]; 

var skippedVideoIds = [];
var isMusicSkipped = false;

function PozdroNutkaXDDD(videoId) {
    var apiKey = "AIzaSyAeIshuYudEVctNr3BY-A2yB7xQoeNFxp0";
    var apiUrl = `https://www.googleapis.com/youtube/v3/videos?part=snippet&id=${videoId}&key=${apiKey}`;
  
    fetch(apiUrl)
        .then(response => response.json())
        .then(data => {
            if (data.items.length > 0) {
                var videoTitle = data.items[0].snippet.title;
                if (videoTitle.length > 20) {
                    videoTitle = videoTitle.substring(0, 27) + "...";
                }
                document.getElementById("song-name").textContent = videoTitle;
            }
        })
}

function onYouTubeIframeAPIReady() {
    var randomIndex = Math.floor(Math.random() * videoIds.length);
    videoId = videoIds[randomIndex];
    console.log(videoId)

    PozdroNutkaXDDD(videoId);

    player1312 = new YT.Player("PedalskiFilmikBlur", {
        videoId: videoId,
        playerVars: {
            "playlist": videoId,
            "autoplay": 1,
            "controls": 0,
            "disablekb": 1,
            "enablejsapi": 1,
            "loop": 1,
            "vq": "highres"
        },
        events: {
            "onReady": onStartBlur,
            "onError": onError
        }
    });

    player = new YT.Player("PedalskiFilmik", {
        videoId: videoId,
        playerVars: {
            "playlist": videoId,
            "autoplay": 1,
            "controls": 0,
            "disablekb": 1,
            "enablejsapi": 1,
            "loop": 1,
            "vq": "highres"
        },
        events: {
            "onReady": onStart,
            "onError": onError
        }
    });
}

function onStartBlur(event) {
    event.target.setVolume(0);
    
    event.target.setPlaybackQuality("highres");
    event.target.playVideo();
    // onVolume();
}

function onStart(event) {
    event.target.setVolume(8);
    
    event.target.setPlaybackQuality("highres");
    event.target.playVideo();
    // onVolume();
}

function onError(event) {
    onYouTubeIframeAPIReady()
    console.log("An error occurred: " + event.data);
}

function onVolume() {
    value = GownoCoZmieniaszGlosnosc.value;
    player.setVolume(value - 1);
}

var precentloading = document.getElementById("precent");

window.onload = function(){
    $(".loader").css({"opacity": "0"});
}

$(window).on('load', function() {
    $("#preloader").animate({
        'opacity': '0'
    }, 600, function(){
        setTimeout(function(){
            $('#preloader').css({'opacity':`0`})
        }, 300);
    });
});

window.addEventListener('message', function(e) {
    if(e.data.eventName === 'loadProgress') {
        $('.fill').css('width', e.data.loadFraction * 100 + "%");
    }
});