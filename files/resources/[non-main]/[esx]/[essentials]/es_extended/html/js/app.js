(() => {

	ESX = {
		'Cache': {},
		'HUDElements': [],
		'color': '#e60101',
		'Keys': {
			['INPUT_CONTEXT']: 'E',
			['INPUT_ENTER']: 'F',
			['INPUT_VEH_EXIT']: 'F',
			['INPUT_DETONATE']: 'G',
			['INPUT_COVER']: 'Q',
			['INPUT_TALK']: 'E',
			['INPUT_CHARACTER_WHEEL']: 'ALT',
			
			['INPUT_FRONTEND_ENDSCREEN_ACCEPT']: 'ENTER',
			['INPUT_FRONTEND_RRIGHT']: 'BACKSPACE',
			['INPUT_ATTACK']: 'LPM',
			['INPUT_VEH_ACCELERATE']: 'W',
			['INPUT_VEH_DUCK']: 'X',
			['INPUT_PICKUP']: 'E',
			['INPUT_VEH_HEADLIGHT']: 'H',
			['INPUT_THROW_GRENADE']: 'G',

			['INPUT_MOVE_LEFT_ONLY']: 'A',
			['INPUT_MOVE_RIGHT_ONLY']: 'D',
			['INPUT_MOVE_UP_ONLY']: 'W',
			['INPUT_MOVE_DOWN_ONLY']: 'S',
			['INPUT_MP_TEXT_CHAT_TEAM']: 'Y',
			
			['INPUT_VEH_PREV_RADIO_TRACK']: '-',	
			['INPUT_SPRINT']: 'LEFT SHIFT',	
			['INPUT_CELLPHONE_RIGHT']: '⮫',	
			['INPUT_REPLAY_ADVANCE']: '⮫',	
			['INPUT_CELLPHONE_LEFT']: '⮪',
			['INPUT_REPLAY_BACK']: '⮪',
			
			['INPUT_CELLPHONE_UP']: '⮬',	
			['INPUT_CELLPHONE_DOWN']: '⮯',	
			
			['INPUT_FRONTEND_ACCEPT']: 'ENTER',	
			['INPUT_REPLAY_SCREENSHOT']: 'U',
			['INPUT_MELEE_ATTACK1']: 'R',
			['INPUT_ATTACK']: 'LPM',
			['INPUT_INTERACTION_MENU']: 'M',
			['INPUT_CELLPHONE_CANCEL']: 'BACKSPACE',
			['INPUT_CELLPHONE_SELECT']: 'LPM',
			['INPUT_FURNITURE_CANCEL_']: 'PPM',
			['INPUT_JUMP']: 'SPACJA',
			['INPUT_CELLPHONE_OPTION']: 'DELETE',
		}
	}

	ESX.HUDElements = [];

	ESX.setHUDDisplay = function (opacity) {
		$('#hud').css('opacity', opacity);
	};

	ESX.insertHUDElement = function (name, index, priority, html, data) {
		ESX.HUDElements.push({
			name: name,
			index: index,
			priority: priority,
			html: html,
			data: data
		});

		ESX.HUDElements.sort((a, b) => {
			return a.index - b.index || b.priority - a.priority;
		});
	};

	ESX.updateHUDElement = function (name, data) {
		for (let i = 0; i < ESX.HUDElements.length; i++) {
			if (ESX.HUDElements[i].name == name) {
				ESX.HUDElements[i].data = data;
			}
		}

		ESX.refreshHUD();
	};

	ESX.deleteHUDElement = function (name) {
		for (let i = 0; i < ESX.HUDElements.length; i++) {
			if (ESX.HUDElements[i].name == name) {
				ESX.HUDElements.splice(i, 1);
			}
		}

		ESX.refreshHUD();
	};

	ESX.resetHUDElements = function () {
		ESX.HUDElements = [];
		ESX.refreshHUD();
	};

	ESX.ConvertKeys = function(message) {
		const regexKeys =  /~/g;			
		message = message.replace(regexKeys, "")
		
		for (const [key, value] of Object.entries(ESX.Keys)) {			
			if (message.match(key)) {				
				message = message.replace(key, '<kbd>' + value + '</kbd>');
			}
		};
	
		return message
	};
	
	ESX.ConvertText = function(message) {
        const regexColor = /~([^h])~([^~]+)/g;	
        const regexBold = /~([h])~([^~]+)/g;	
        const regexStop = /~s~/g;	
        const regexLine = /\n/g;		
        const newLine = /~n~/g;	
    
        message = message.replace(regexColor, "<span class='$1'>$2</span>").replace(regexBold, "<span class='$1'>$2</span>").replace(regexStop, "").replace(regexLine, "<br>").replace(newLine, "<br>");
		message = ESX.ConvertKeys(message)
		
        return message;		
	};

	ESX.ShowText = function(data) {
		if (data != undefined && data.id != undefined) {
			let cache = ESX.Cache[data.id]
			if (cache) {				
				$(`#${data.id}`).css('left', `${data.pos.x}%`)
				$(`#${data.id}`).css('top', `${data.pos.y}%`)
				$(`#${data.id}`).css('transform', `scale(${data.scale}) translate(-${data.pos.x}%, -${data.pos.y}%)`)
				
				if (data.active != undefined) {
					if (data.active) {
						if (!$(`#${data.id}`).hasClass('active')) {
							$(`#${data.id}`).addClass('active')
						}
					} else {
						if ($(`#${data.id}`).hasClass('active')) {
							$(`#${data.id}`).removeClass('active')
						}
					}
				}
				
				if (data.text != undefined && data.textUpdate) {
					$(`#${data.id}`).find('p').html(ESX.ConvertText(data.text))
				}
			} else {
				ESX.Cache[data.id] = true
				
				$('#floatingtext').prepend(`
					<div class="container ${data.active ? 'active' : ''}" style="transform: ${data.scale} translate(-${data.pos.x}%, -${data.pos.y}%); left: ${data.pos.x}%; top: ${data.pos.y}%;" id="${data.id}">
						<div class="dot"></div>
						
						<p class="text">${ESX.ConvertText(data.text)}</p>
					</div>		
				`)
			}
		}
	}
	
	ESX.CloseText = function(id) {
		if (id != undefined) {
			let cache = ESX.Cache[id]
			if (cache) {
				ESX.Cache[id] = undefined
				
				$(`#${id}`).remove()
			}
		}
	}

	ESX.refreshHUD = function () {
		$('#hud').html('');

		for (let i = 0; i < ESX.HUDElements.length; i++) {
			let html = Mustache.render(ESX.HUDElements[i].html, ESX.HUDElements[i].data);
			$('#hud').append(html);
		}
	};

	ESX.inventoryNotification = function (add, label, count) {
		let notif = '';

		if (add) {
			notif += '+';
		} else {
			notif += '-';
		}

		if (count) {
			notif += count + ' ' + label;
		} else {
			notif += ' ' + label;
		}

		let elem = $('<div>' + notif + '</div>');
		$('#inventory_notifications').append(elem);

		$(elem).delay(3000).fadeOut(1000, function () {
			elem.remove();
		});
	};

	window.onData = (data) => {
		switch (data.action) {
			case 'setHUDDisplay': {
				ESX.setHUDDisplay(data.opacity);
				break;
			}

			case 'insertHUDElement': {
				ESX.insertHUDElement(data.name, data.index, data.priority, data.html, data.data);
				break;
			}

			case 'updateHUDElement': {
				ESX.updateHUDElement(data.name, data.data);
				break;
			}

			case 'deleteHUDElement': {
				ESX.deleteHUDElement(data.name);
				break;
			}

			case 'resetHUDElements': {
				ESX.resetHUDElements();
				break;
			}

			case 'showText': {
				if (data.data != undefined) {
					ESX.ShowText(data.data)
				}
				
				break
			}	
			
			case 'closeText': {
				if (data.id != undefined) {
					ESX.CloseText(data.id)
				}
				
				break
			}

			case 'saveBinds': {
				localStorage.setItem("esxBinds", JSON.stringify(data.binds));
				break;
			}

			case 'inventoryNotification': {
				ESX.inventoryNotification(data.add, data.item, data.count);
			}
		}
	};

	window.onload = function (e) {
		window.addEventListener('message', (event) => {
			onData(event.data);
		});

		const binds = localStorage.getItem("esxBinds");
		if (binds) {
			$.post("https://es_extended/setBinds", JSON.stringify({ binds: JSON.parse(binds) }))
		}
	};

})();
