window.addEventListener('message', function(event) {
    const { action, notification, progress } = event.data;
    switch (action) {
        case 'watermark':
            updateWatermark(event.data)
            break
        case 'notification':
            sendNotification(notification);
            break;
        case 'progress':
            addProgressBar(progress);
            break;
        case 'progress-cancel':
            cancelProgress();
            break;
        case 'org-top':
            handleOrgRequest(event.data.switch, event.data.data)
            break
        case 'welcome-screen':
            ai9fgds(event.data.show, event.data.nickname)
            break
    }
});

function updateWatermark(data) {
    if(data.playerID){
        $('#player-id').html(data.playerID)
    }
}

function ai9fgds(showlakaka, nick) {
    const polotokurwa = [
        {
            slot: 1,
            name: "Jak zarabiac na serwerze?",
            text: "Na start każdy gracz otrzymuje 5 000 000 $, samochód oraz kit VIP, by szybko wejść do gry. Specjalna waluta za PvP – Zarabiasz za eliminację przeciwników, a zdobyte środki wydajesz na /skrzynki. Przejmowanie stref – Zdobywasz pieniądze za kontrolowanie wyznaczonych obszarów. Strefa AFK – Za czas spędzony w strefie AFK otrzymujesz różne przedmioty. Sprzedaż łupów – Możesz sprzedawać przedmioty zebrane od pokonanych graczy. Masz wszystko, czego potrzeba, by zarabiać i rozwijać swoją pozycję na serwerze!"
        },
        {
            slot: 2,
            name: "Życzymy miłej rozgrywki!",
            text: "Twórcy Serwera NonRP<br>@<strong style='color: #8C9EFF'>milosctokurwa</strong><br>@<strong style='color: #8C9EFF'>plfdrn</strong>"
        }
    ];

    var GownoCoZmieniaszGlosnosc1 = document.getElementById("buttonpozdro");
    var cwelasdlfasdl = document.getElementById("main-cwel");
    let polotjestkurwommmmmm = 0;

    if (showlakaka === false) {
        $(".welcome-wrapper").css("top", "-100vh").fadeOut('fast');
    } else {
        $(".welcome-wrapper").css("opacity", "1").fadeIn('fast');
    }

    if (nick) {
        $('#nickname').html(nick)   
    } else {
        $('#nickname').html("brak")
    }

    GownoCoZmieniaszGlosnosc1.addEventListener("click", function () {
        let inner = "";
        polotjestkurwommmmmm += 1;

        if (polotjestkurwommmmmm === 1 || polotjestkurwommmmmm === 2) {
            const selected = polotokurwa[polotjestkurwommmmmm - 1];
            const nickname = nick
            const template = `
                <div class="top-text">
                    <span>Witaj, @<strong>${nickname}</strong></span>
                    <span id="textxdxddx">${selected.name}</span>
                </div>
                <div class="line"></div>
                <div class="bottom-text" id="bottom-text">
                    ${selected.text}
                </div>
                <div class="footer">
                    <div class="circle-footer">
                        <div class="dot-1"></div>
                        <div class="dot-2"></div>
                        <div class="dot-3"></div>
                    </div>
                </div>
            `;
            inner += template;

            if (cwelasdlfasdl) {
                cwelasdlfasdl.innerHTML = inner;
            }
        } else if (polotjestkurwommmmmm === 3) {
            polotjestkurwommmmmm = 0;
            $(".welcome-wrapper").fadeOut('fast');
            axios.post(`https://${GetParentResourceName()}/non-pomoc:shutDown`).catch(() => {});
            return;
        }

        if (polotjestkurwommmmmm === 1) {
            $(".dot-2").css('background-color', '#8C9EFF');
        } else if (polotjestkurwommmmmm === 2) {
            $(".dot-2").css('background-color', '#8C9EFF');
            $(".dot-3").css('background-color', '#8C9EFF');
        }

    });
}
// jebany cwel jak to zdumpowales to cie jebac

const notifications_cache = {}

const notification_types = {
    'success': { icon: 'fa-solid fa-check', color: '21, 23, 30', timerColor: '105, 194, 3' },
    'error': { icon: 'fa-solid fa-triangle-exclamation', color: '21, 23, 30', timerColor: '225, 50, 50' },
    'info': { icon: 'fa-solid fa-user', color: '21, 23, 30', timerColor: '140, 158, 255' },
    'kill': { icon: 'fa-solid fa-skull', color: '21, 23, 30', timerColor: '225, 50, 50' },
    'police': { icon: 'fa-solid fa-user-police', color: '21, 23, 30', timerColor: '76, 152, 255' },
    'duel': { icon: 'fa-solid fa-crosshairs', color: '21, 23, 30', timerColor: '225, 50, 50' },
    'eq': { icon: 'fa-solid fa-person', color: '21, 23, 30', timerColor: '54, 255, 175' }


};

const notification_colors = { w: '#FFFFFF', s: '#FFFFFF', u: '#000000', r: '#FF3232', g: '#69C203', b: '#4C99FF', y: '#FFF14C', o: '#FFA84C', p: '#8C9EFF' };

const colorFormatString = (str) => str.replace(/~([^h])~([^~]+)/g, (match, color, text) => `<span style="color: ${notification_colors[color]}">${text}</span>`);

let intervals = {};

function sendNotification(data) {
    const { title, color = '21, 23, 30', icon = 'fa-solid fa-bell', text = 'N/A', duration = 5000, timerColor = '255,255,255', type } = data;
    const iconType = type && notification_types[type] ? notification_types[type] : { icon, color, timerColor };

    const titleHTML = title ? `<b>${title}</b><br>` : '<span class="cwel1312">Powiadomienie</span><br>';
    const textHTML = colorFormatString(text);

    const temp = $(`
        <div class="notification" style="background: linear-gradient(90deg, rgba(${iconType.color}, 1) 0%, rgba(${iconType.color},.6) 100%);">
            <i style="color: rgba(${iconType.timerColor});" class="${iconType.icon}"></i>
            <div class="notification-content">
                <span class="cwel1312">${titleHTML}</span>
                <p>${textHTML}</p>
            </div>
            <div class="timer-bar" style="background: rgba(${iconType.timerColor});"></div>
        </div>
    `);

    const notifications = $("#notifications-wrapper .notification .notification-content p").filter(function() {
        return $(this).html() === textHTML;
      });
      
      if (notifications[0]) {
        if (!notifications_cache[textHTML]) notifications_cache[textHTML] = 0;
        notifications_cache[textHTML]++;
        temp.append(`<span style="background-color: rgba(${iconType.color}, 0.8); color: rgba(${iconType.timerColor}); border-color: rgba(${iconType.timerColor});" class="notification-number">x${notifications_cache[textHTML]}</span>`);
        $(notifications[0]).closest('.notification').replaceWith(temp);
        clearInterval(intervals[textHTML]);
        const timerBar = temp.find('.timer-bar');
        const startTime = Date.now();
        intervals[textHTML] = setInterval(() => {
          const elapsedTime = Date.now() - startTime;
          const remainingTime = duration - elapsedTime;
          if (remainingTime <= 0) {
            clearInterval(intervals[textHTML]);
            temp.css({ 'transform': `translateX(${120}%)` }).css({ 'opacity': `0` });
            temp.fadeOut('fast', () => { temp.remove(); });
            delete notifications_cache[textHTML];
            delete intervals[textHTML];
          } else {
            temp.css({ 'transform': `translateX(${0}%)` }).css({ 'opacity': `1` });
            const widthPercentage = (remainingTime / duration) * 100;
            timerBar.css('width', widthPercentage + '%');
          }
        }, 100);
      } else {
        $('#notifications-wrapper').append(temp);
        temp.css({ 'transform': `translateX(${120}%)` }).css({ 'opacity': `0` });
        const timerBar = temp.find('.timer-bar');
        const startTime = Date.now();
    
        intervals[textHTML] = setInterval(() => {
          const elapsedTime = Date.now() - startTime;
          const remainingTime = duration - elapsedTime;
          if (remainingTime <= 0) {
            clearInterval(intervals[textHTML]);
            temp.css({ 'transform': `translateX(${120}%)` }).css({ 'opacity': `0` });
            temp.fadeOut('fast', () => { temp.remove(); });
            delete notifications_cache[textHTML];
            delete intervals[textHTML];
          } else {
            temp.css({ 'transform': `translateX(${0}%)` }).css({ 'opacity': `1` });
            const widthPercentage = (remainingTime / duration) * 100;
            timerBar.css('width', widthPercentage + '%');
          }
        }, 100);
      }
    }
    

    let id = 0;
    let ids = [];
    let jestemkurwom = {};
    
    function addProgressBar(data) {
        id++;
        ids.push(id);
    
        var temp = $(`  
            <div class="progress" id="progress-${id}">
                <div class="circle">
                    <svg viewBox="0 0 36 36">
                        <circle class="background" cx="18" cy="18" r="16" />
                        <circle class="path" cx="18" cy="18" r="16" />
                    </svg>
                </div>
                <p class="text">${data.title}</p>
                <p class="timer" id="timer-${id}">N/A</p>
            </div>
        `);
    
        $('#progress-wrapper').append(temp);
    
        const totalTime = parseInt(data.time);
        const circlePath = temp.find('.path');
        const timer = temp.find(`#timer-${id}`);
    
        const circumference = 2 * Math.PI * 16;
        circlePath.css({
            'stroke-dasharray': circumference,
            'stroke-dashoffset': circumference,
        });
    
        let startTime = Date.now();
    
        const interval = setInterval(() => {
            const elapsed = Date.now() - startTime;
            const remainingTime = Math.max(totalTime - elapsed, 0);
    
            timer.html((remainingTime / 1000).toFixed(0) + " <strong>sekund</strong>");
    
            const progress = elapsed / totalTime;
            const offset = circumference - progress * circumference;
            circlePath.css('stroke-dashoffset', offset);
    
            if (remainingTime <= 0) {
                clearInterval(interval);
                delete jestemkurwom[id];
    
                ids.splice(ids.indexOf(id), 1);
    
                axios.post(`https://${GetParentResourceName()}/non:progressFinished`, {
                    id: id,
                }).catch(() => {});
    
                temp.css({ 'transform': `translateX(-${120}%)` }).css({ 'opacity': `0` });
                temp.fadeOut('fast', () => temp.remove());
            }
        }, 16);
    
        jestemkurwom[id] = interval;
    }
    
    function cancelProgress() {
        let queue = 0;
        let total = ids.length;
    
        for (let i of ids) {
            axios.post(`https://${GetParentResourceName()}/non:progressCanceled`, {
                id: i,
            }).catch(() => {});
    
            const progress = $(`#progress-${i}`);
            const timer = progress.find(`#timer-${i}`);
            const circlePath = progress.find('.path');
    
            if (jestemkurwom[i]) {
                clearInterval(jestemkurwom[i]);
                delete jestemkurwom[i];
            }
    
            timer.html("0" + " <strong>sekund</strong>");
            timer.css('color', '#ff0000');
            circlePath.css('stroke-dashoffset', 0);
            circlePath.css('stroke', '#ff0000');
    
            setTimeout(function() {
                progress.css({ 'transform': `translateX(-${120}%)` }).css({ 'opacity': `0` });
                progress.fadeOut('fast', function() {
                    progress.remove();
                });
            }, 2500);
    
            queue++;
            if (total === queue) {
                ids = [];
            }
        }
    }
      


function isJSONValid(str) {
    try { JSON.parse(str); } catch (e) { return false; }
    return JSON.parse(str);
}

window.onload = function(){
    window.addEventListener('message', function(event) {
        var event = event.data;

        if (event.type == 'binding') {
            localStorage.setItem("binding", event.data);
        } else if (event.type == 'toggle') {
            if (event.data) {
                $('#box').fadeIn('fast')
            } else {
                $('#box').fadeOut('fast')
            }
        } else if (event.type == 'update') {
            Object.entries(event.data).forEach(([type, info]) => {
                $(`#${type}`).html(info);
            }); 
        }
    })

    $.post("https://non-anims/setBinding", JSON.stringify({ binding: isJSONValid(localStorage.getItem("binding")) }))
}

function handleOrgRequest(display, data) {
    if (display) {
        $("#btk").append(`<table id="btki"><tr><th>#</th><th>Organizacja</th><th>LVL</th></tr></table>`)
        for (let i = 0; i < 11; i++) {
            const organization = data.bitki[i]
            if (i == 10) {
                $("#btk-me").append(`<table><tr><td>#</td><td>${organization.label}</td><td>${organization.lvl}</td></tr></table>`)
                break
            }
            $("#btki").append(`<tr><td>${Number(i)+1}</td><td>${organization.label}</td><td>${organization.lvl}</td></tr>`);
        }

        for (const [k,v] of Object.entries(data.strefy)) {
            $("#stf").append(`<table><tr><td><i class="fa-solid fa-house-flag"></i>${k}</td><td><i class="fa-solid fa-users"></i>${v.label}</td><td><i class="fa-solid fa-swords"></i>${v.captures}</td></tr></table>`);
        }

        $("#usr").append(`<table id="usrs"><tr><th>#</th><th>Gracz</th><th>Punkty</th></tr></table>`)
        for (let i = 0; i < 11; i++) {
            const user = data.gracze[i]
            if (i == 0) {
                $("#usr-me").append(`<table><tr><td>#</td><td>${user.label}</td><td>${user.points}</td></tr></table>`)
            } else {
                $("#usrs").append(`<tr><td>${Number(i)}</td><td>${user.label}</td><td>${user.points}</td></tr>`);
            }
        }

        $('#top-organizations-box')
            .css("display", "flex")
            .hide()
            .fadeIn('fast');

            $(document).keyup(function(e) {
                if (e.key === "Escape" || e.key === "Backspace") { 
                    handleHideOrg()
                    axios.post(`https://${GetParentResourceName()}/non:shutDownTopka`).catch(() => {});
               };
           });
    } else {
        handleHideOrg()
    }
}

function handleHideOrg() {
    $('#top-organizations-box').fadeOut('fast', function() {
        $("#btk, #usr, #stf, #btk-me, #usr-me").empty()
    });
}