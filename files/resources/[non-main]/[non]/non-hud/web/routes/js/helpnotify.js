const notification_keys = {
    ['~INPUT_CONTEXT~']: 'E',
    ['~INPUT_VEH_EXIT~']: 'F',
    ['~INPUT_VEH_ACCELERATE~']: 'W',
    ['~INPUT_VEH_DUCK~']: 'X',
    ['~INPUT_PICKUP~']: 'E',
    ['~INPUT_RELOAD~']: 'R',
    ['~INPUT_VEH_HEADLIGHT~']: 'H',
    ['~INPUT_THROW_GRENADE~']: 'G',
    ['~INPUT_MOVE_LEFT_ONLY~']: 'A',
    ['~INPUT_MOVE_RIGHT_ONLY~']: 'D',
    ['~INPUT_MOVE_UP_ONLY~']: 'W',
    ['~INPUT_MOVE_DOWN_ONLY~']: 'S',
    ['~INPUT_DETONATE~']: 'G',
    ['~INPUT_VEH_MOVE_LEFT_ONLY~']: 'A',
    ['~INPUT_VEH_MOVE_RIGHT_ONLY~']: "D",
    ['~INPUT_VEH_PREV_RADIO_TRACK~']: '-',
    ['~INPUT_SPRINT~']: 'LEFT SHIFT',
    ['~INPUT_CELLPHONE_RIGHT~']: '⮫',
    ['~INPUT_REPLAY_ADVANCE~']: '⮫',
    ['~INPUT_CELLPHONE_LEFT~']: '⮪',
    ['~INPUT_REPLAY_BACK~']: '⮪',
    ['~INPUT_CELLPHONE_UP~']: '⮬',
    ['~INPUT_CELLPHONE_DOWN~']: '⮯',
    ['~INPUT_FRONTEND_ACCEPT~']: 'ENTER',
    ['~INPUT_INTERACTION_MENU~']: 'M',
    ['~INPUT_VEH_PREV_RADIO~']: ',',
    ['~INPUT_VEH_NEXT_RADIO~']: '.'
};

window.addEventListener('message', function(event) {
    if (event.data.action === "HelpNotification") {
        let message = event.data.message;

        for (const [key, value] of Object.entries(notification_keys)) {
            if (message.match(key)) {
                message = message.replace(key, `<strong>${value}</strong>`);
            }
        }

        $('.helpnotify-box').css({'opacity': '1'});
        $('.helpnotify-box').css({'top': '1vh'});
        $('#text-helpnotify').html(message);
    }

    if (event.data.action === "HideHelpNotification") {
        $('.helpnotify-box').css({'top': '-5vh'});
        $('.helpnotify-box').css({'opacity': '0'});
    }
});
