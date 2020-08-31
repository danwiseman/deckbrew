deckbrew = { 
 showNotification: function(from, align, type, message) {
    //type = ['', 'info', 'danger', 'success', 'warning', 'rose', 'primary'];
    if (type == "notice") {
      type = "success"
      
    }
    //color = Math.floor((Math.random() * 6) + 1);

    $.notify({
      icon: "warning",
      message: message

    }, {
      type: type,
      timer: 3000,
      placement: {
        from: from,
        align: align
      }
    });
  }
}