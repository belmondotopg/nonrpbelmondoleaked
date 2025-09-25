let time = 0
function secondsToTime(e){
    const m = Math.floor(e % 3600 / 60).toString().padStart(2,'0'),
    s = Math.floor(e % 60).toString().padStart(2,'0');
    
    return m + ':' + s;
}
window.addEventListener("message", (ev) => {
    let name = ev.data.name
    
    if (name == "time") {
        let newTime = secondsToTime(ev.data.time)
        document.querySelector(".jebacegzo").innerHTML = newTime
        $('body').css({'background-color':`rgba(5, 5, 5, 0.3)`})
        $('.container').css({'opacity':`1`})
        time = ev.data.time
    } else if (name == "hide") {
        $('body').css({'background-color':`rgba(5, 5, 5, 0)`})
        $('.container').css({'opacity':`0`})
        time = 0
    }
})
setInterval(() => {
    if (time != 0) {
        document.querySelector(".jebacegzo").innerHTML = secondsToTime(time)
        time--
    }else if (time ==0){
        document.querySelector(".jebacegzo").innerHTML = "00:00"
    }
}, 1000);