document.addEventListener('DOMContentLoaded', function() {
  $("form#sign_in_user, form#sign_up_user").bind("ajax:success", function(event, xhr, settings) {
    $(this).parents('.modal').modal('hide');
    location.reload();
  }).bind("ajax:error", function(event) {
    const [errors, data, xhr] = event.detail
    var error_messages;
    error_messages =  $.map(errors, function(v, k) {

      return "<div class='alert alert-danger pull-left'>" + k + " " + v + "</div>";

    }).join("")
     console.log(error_messages);
     console.log($(this).parents('.modal').find('.modal-footer'))
    return $(this).parents('.modal').find('.modal-footer').html(error_messages);
  });
});
