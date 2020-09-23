$(document).on('turbolinks:load', function() {
  if ( $('#notifications').is('.js-with-unread') ) {
    setTimeout(function () {
      readNotifications();
    }, 1000)
  };

  function readNotifications () {
    $.ajax({
      url: '/notifications',
      type: 'PUT',
      success: function(data) {
        location.reload()
      }
    });
  }
})
