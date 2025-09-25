
window.addEventListener('message', function(event) {
    if (event.data.action == "SHOW_HUDSETTINGS") {
        if (event.data.settings) {
            $(".settings-box").css('opacity', '1')
        }
    }

    if (event.data.action == "HIDE_HUDSETTINGS") {
        $(".settings-box").css('opacity', '0');
    }
});

document.addEventListener('DOMContentLoaded', () => {
    const colorInput = document.getElementById('hud-color');
    const colorBox = colorInput.nextElementSibling;
    const kolorek = localStorage.getItem("kolorhudu") || "#8C9EFF";
    
    colorInput.value = kolorek;
    colorBox.style.backgroundColor = kolorek;
    $('#logocolor').css('fill', kolorek);
    $('#zmienkolorcwelu').css('fill', kolorek);

    localStorage.setItem("kolorhudu", kolorek);
    document.documentElement.style.setProperty('--hud-color', kolorek);
    colorInput.addEventListener('input', () => {
        const newColor = colorInput.value;
        colorBox.style.backgroundColor = newColor;
        localStorage.setItem("kolorhudu", newColor);
        $('#zmienkolorcwelu').css('fill', newColor);
        $('#logocolor').css('fill', newColor);
        document.documentElement.style.setProperty('--hud-color', newColor);
    });
});

document.addEventListener('keydown', function(event) {
    if (event.key === "Escape") {
        $.post('https://non-hud/hideHUDSettings', JSON.stringify({}));
    }
});