window.addEventListener('message', function(event) {
    if (event.data.action == "UPDATE_WATERMARK") {
        if (event.data.id) {
            $('#id-player').html(event.data.id);
        }

        if (event.data.group) {
            //console.log("cwel", event.data.kd)
            $('#group-player').html(event.data.group);
        }
    }
});
