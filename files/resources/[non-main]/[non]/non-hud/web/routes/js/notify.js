window.addEventListener('message', function(event) {
    const { notification } = event.data;

    if (event.data.action == "notification") {
        sendNotification(notification);
    }

    if (event.data.action == "sendAdminNotification") {
        sendAdminNotification(notification);
    }
});


const notification_types = {
    'success': { icon: 'fa-solid fa-check', color: '0, 0, 0', timerColor: '105, 194, 3' },
    'error': { icon: 'fa-solid fa-triangle-exclamation', color: '0, 0, 0', timerColor: '225, 50, 50' },
    'info': { icon: 'fa-solid fa-user', color: '0, 0, 0', timerColor: localStorage.getItem("kolorhudu") },
    'kill': { icon: 'fa-solid fa-skull', color: '0, 0, 0', timerColor: '225, 50, 50' },
    'police': { icon: 'fa-solid fa-user-police', color: '0, 0, 0', timerColor: '76, 152, 255' },
    'duel': { icon: 'fa-solid fa-crosshairs', color: '0, 0, 0', timerColor: '225, 50, 50' },
};

const notification_colors = { w: '#FFFFFF', s: '#FFFFFF', u: '#000000', r: '#FF3232', g: '#69C203', b: '#4C99FF', y: '#FFF14C', o: '#FFA84C', p: '"+ localStorage.getItem("kolorhudu") +"' };

const colorFormatString = (str) => str.replace(/~([^h])~([^~]+)/g, (match, color, text) => `<span style="color: ${notification_colors[color]}">${text}</span>`);

const notificationCount = {};

function sendNotification(data) {
    const { title, color = '0, 0, 0', icon = 'fa-solid fa-bell', text = 'N/A', duration = 5000, timerColor = '255,255,255', type } = data;
    const iconType = type && notification_types[type] ? notification_types[type] : { icon, color, timerColor };

    const titleHTML = title ? `${title}` : 'Powiadomienie';
    const textHTML = colorFormatString(text);

    const notificationKey = `${titleHTML}:${textHTML}`;

    if (notificationCount[notificationKey]) {
        // Zwiększ licznik powtórzeń
        notificationCount[notificationKey].count++;
        const repeatCountElem = notificationCount[notificationKey].element.find('.repeat-count');
        // Pokaż licznik powtórzeń, jeśli to co najmniej drugi raz
        if (notificationCount[notificationKey].count > 1) {
            duration + 1000
            repeatCountElem.text(`${notificationCount[notificationKey].count}`).show();
        }
        return;
    } else {
        // Stwórz nowe powiadomienie
        notificationCount[notificationKey] = { count: 1 };
    }

    const temp = $(`
        <div class="notify-right" style="background-color: rgba(${iconType.color});" >
            <i style="color: rgba(${iconType.timerColor});" class="${iconType.icon}"></i>
            <div class="content">
                <div class="title">
                    <span>${titleHTML}</span>
                    <span class="repeat-count" style="position: absolute; top: .5vh; right: .5vh; color: #AAAAAA; font-size: 0.8em; padding: 0.2em 0.4em; display: none;"></span>
                </div>
                <div class="desc">
                    <span>${textHTML}</span>
                </div>
            </div>
        </div>
    `);

    $('.notify-box-right').append(temp);
    temp.css({ 'right': `-50vh` }).css({ 'opacity': `0` });

    notificationCount[notificationKey].element = temp;

    const startTime = Date.now();

    const intervalId = setInterval(() => {
        const elapsedTime = Date.now() - startTime;
        const remainingTime = duration - elapsedTime;
        if (remainingTime <= 0) {
            clearInterval(intervalId);
            temp.css({ 'right': `-50vh` }).css({ 'opacity': `0` });
            temp.fadeOut('fast', () => { 
                temp.remove();
                delete notificationCount[notificationKey];
            });
        } else {
            temp.css({ 'right': `0vh` }).css({ 'opacity': `1` });
        }
    }, 100);
}


function sendAdminNotification(data) {
    const { title, color = '0, 0, 0', icon = 'fa-solid fa-bell', text = 'N/A', duration = 5000, timerColor = '255,255,255', type, image } = data;
    const iconType = type && notification_types[type] ? notification_types[type] : { icon, color, timerColor };

    const titleHTML = title ? `${title}` : 'Powiadomienie';
    const textHTML = colorFormatString(text);

    const temp = $(`
        <div class="notify" style="background-color: rgba(${iconType.color});">
            <img src="${image}">
            <div class="content">
                <div class="title">
                    <span>${titleHTML}</span>
                </div>
                <div class="desc">
                    <span>${textHTML}</span>
                </div>
            </div>
        </div>
    `);

    $('.notify-box').append(temp);
    // temp.fadeIn();
    temp.css({ 'top': `-10vh` }).css({ 'opacity': `0` });
    const timerBar = temp.find('.timer-bar');
    const startTime = Date.now();

    const intervalId = setInterval(() => {
        const elapsedTime = Date.now() - startTime;
        const remainingTime = duration - elapsedTime;
        if (remainingTime <= 0) {
            clearInterval(intervalId);
            temp.css({ 'top': `-10vh` }).css({ 'opacity': `0` });
            temp.fadeOut('fast', () => { temp.remove(); });
        } else {
            temp.css({ 'top': `0vh` }).css({ 'opacity': `1` });
            const widthPercentage = (remainingTime / duration) * 100;
            timerBar.css('width', widthPercentage + '%');
            
        }
    }, 100);
}