$(document).on('turbolinks:load', function() {

  $("form#new-message")
    .on("ajax:success", function(event) {
      location.reload();
    })
    .on("ajax:error", function(event) {
      $(".modal-errors").empty();
      const error = event.detail[0]
      const errorMessage = `<p class="text-danger mb-1">${error.body[0]}</p>`
      $('#new-message').find('.message-error').html(errorMessage);
    });
});
