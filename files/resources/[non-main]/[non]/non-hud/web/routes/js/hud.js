function darkenColor(rgb, percent) {
    const colorValues = rgb.match(/\d+/g).map(Number);
    const darkenedValues = colorValues.map(value => Math.max(0, Math.floor(value * (1 - percent / 100))));
    return `rgb(${darkenedValues.join(", ")})`;
}

window.addEventListener('message', function(event) {

    // $('.hp').css({'background':darkenColor(, 20)});

    if (event.data.action == "UPDATE_HUD") {
        if (event.data.voice) {
            var voicePercentage = event.data.voice;
            localStorage.setItem("voice", voicePercentage);
            var voiceGradient = "linear-gradient(to top, #8C9EFF " + voicePercentage + "%, #fff " + voicePercentage + "%)";
            $(".microphone i").css({
                "background": voiceGradient,
                "-webkit-background-clip": "text",
                "-webkit-text-fill-color": "transparent",
                "transition": "background 0.5s ease"
            });
        }
        if (event.data.state) {
            var voicePercentage = localStorage.getItem("voice");
            var voiceGradient = "linear-gradient(to top, #202020 " + voicePercentage + "%, #fff " + voicePercentage + "%)";
            // $('.microphone i').css({'filter':`drop-shadow(0px 0px 20px rgba(255, 255, 255, 1))`})
            $(".microphone i").css({
                "background": voiceGradient,
                "-webkit-background-clip": "text",
                "-webkit-text-fill-color": "transparent",
                "transition": "background 0.5s ease"
            });
        } else {
            var voicePercentage = localStorage.getItem("voice");
            var voiceGradient = "linear-gradient(to top, #8C9EFF " + voicePercentage + "%, #fff " + voicePercentage + "%)";
            // $('.microphone i').css({'filter':`drop-shadow(0px 0px 20px `+localStorage.getItem("kolorhudu")+``})
            $(".microphone i").css({
                "background": voiceGradient,
                "-webkit-background-clip": "text",
                "-webkit-text-fill-color": "transparent",
                "transition": "background 0.5s ease"
            });
        }
        
        if (event.data.show) {
            if (event.data.carhud) {
                $('.car-box').css({'opacity':`1`})
                $('.car-box').css({'transform':`translateX(${0}%)`})

                speedText = String(Math.floor(event.data.speed)).padStart(3, '0');

                if (event.data.healthcar) {
                    var healthcarPercentage = event.data.healthcar;
                    var carGradient = "linear-gradient(to top, #8C9EFF " + healthcarPercentage + "%, #fff " + healthcarPercentage + "%)";
                    $("#healthcar").css({
                        "background": carGradient,
                        "-webkit-background-clip": "text",
                        "-webkit-text-fill-color": "transparent",
                        "transition": "background 0.5s ease"
                    });
                }

                if (event.data.rpmbar) {
                    var rpmbarPercentage = event.data.rpmbar;
                    $(".progress-speed-fill").css({'width':`${rpmbarPercentage}%`})
                }

                $('#speed-number').html(speedText);
            } else {
                $('.car-box').css({'transform':`translateX(${30}%)`})
                $('.car-box').css({'opacity':`0`})
            }
        } else {
            $('.car-box').css({'transform':`translateX(${30}%)`})
            $('.car-box').css({'opacity':`0`})
        }

        if (event.data.show) {
            $('.hud-box').css({'transform':`translateY(${0}%) translateX(-50%)`})
            $('.hud-box').css({'opacity':`1`})

            // speedometer-part            
            $('.speedometer-digital').css({'opacity':`1`})
            $('.circle').css({'opacity':`1`})
            $('.icons').css({'bottom':`2vh`})
            $('.streetlabel').css({'bottom':`1vh`})
            $('.hud-collapse').css({'bottom':`-5vh`})
            // $('.notify-box').css({'transform':`translateX(${0}%)`})
            // $('.notify-box').css({'opacity':`1`})
            $('.watermark-box').css({'transform':`translateY(${0}%)`})
            $('.watermark-box').css({'opacity':`1`})
        } else {
            $('.watermark-box').css({'transform':`translateY(-${30}%)`})
            $('.watermark-box').css({'opacity':`0`})
            // $('.notify-box').css({'transform':`translateX(${30}%)`})
            // $('.notify-box').css({'opacity':`0`})

            $('.speedometer-digital').css({'opacity':`0`})
            $('.circle').css({'opacity':`0`})
            $('.icons').css({'bottom':`-10vh`})
            $('.streetlabel').css({'bottom':`-10vh`})
            $('.hud-collapse').css({'bottom':`0vh`})
            $('.hud-box').css({'transform':`translateY(${120}%) translateX(-50%)`})
            $('.hud-box').css({'opacity':`0`})
            // $('.car-box').css({'opacity':`0`})
        }

        if (event.data.health) {
            var healthPercentage = event.data.health - 100;
            var hpGradient = "linear-gradient(to top, #8C9EFF " + healthPercentage + "%, #fff " + healthPercentage + "%)";
            $(".hp i").css({
                "background": hpGradient,
                "-webkit-background-clip": "text",
                "-webkit-text-fill-color": "transparent",
                "transition": "background 0.5s all"
            });
        }

        if (event.data.armor == 0) {
            $('.armor').css({'transform':`translateY(${50}%)`})
            $('.armor').css({'opacity':`0`})
            setTimeout(() => {
                $(".armor").hide();
            }, 500);
        } else {
        if (event.data.armor) { 
            $('.armor').css({'transform':`translateY(${0}%)`})
            $('.armor').css({'opacity':`1`})
            setTimeout(() => {
                $(".armor").show();
            }, 500);
            var armorPercentage = event.data.armor;
            var armorGradient = "linear-gradient(to top, #8C9EFF " + armorPercentage + "%, #fff " + armorPercentage + "%)";
            $(".armor i").css({
                "background": armorGradient,
                "-webkit-background-clip": "text",
                "-webkit-text-fill-color": "transparent",
                "transition": "background 0.5s all"
            });
        }
        }
    }
});