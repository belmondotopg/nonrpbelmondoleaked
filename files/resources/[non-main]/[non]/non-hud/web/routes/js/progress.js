window.addEventListener('message', function(event) {
    if (event.data.action === "ProgressBar") {
        ShowProgressBar(event.data.message, event.data.time)
    }

    if (event.data.action === "HideProgressBar") {
        HideProgressBar()
    }
});

function ShowProgressBar(message, time) {
    $('.text-progress').text(message)
    $('.progress-box').animate({
        opacity: '1'
    }, 200)
    $('.fill').animate({
        width: '100%'
    }, {

        duration: time,

        step: function (now, fx) {
            let percent = (now / $(fx.elem).parent().width()) * 239;
            $('.ProgressPercent').text(Math.round(percent) + '%');
        },

        complete: function () {
            setTimeout(() => {
                $('.progress-box').css('opacity', "0.0")
                $('.progress-box').animate({
                    opacity: '0',
                }, {
                    complete: function () {
                        $('.fill').css('width', '0%');
                        $('.ProgressPercent').text('');
                        $.post('https://non-hud/ProgBarComplete', JSON.stringify({}))
                    }
                });
            }, 200);
        }
    })
}

function HideProgressBar() {
    $('.fill').stop(true, false).css('width', '0%');
    $('.progress-box').stop(true, false).animate({
        opacity: '0'
    }, {
        complete: function () {
            $('.ProgressPercent').text('');
        }
    });
}