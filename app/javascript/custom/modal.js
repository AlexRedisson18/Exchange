document.addEventListener('DOMContentLoaded', function() {
  $("form#sign-in-user")
  .bind("ajax:success", function(event) {
    $(this).parents('.modal').modal('hide');
    location.reload();
  })
  .bind("ajax:error", function(event) {
    const [errors, data, xhr] = event.detail
    const error_messages =  $.map(errors, function(v, k) {
      return `<div class='alert alert-danger pull-left'>${v}</div>`;
    }).join("")
    return $('#sign-in-modal').find('.modal-errors').html(error_messages);
  });

  $("form#sign-up-user")
    .bind("ajax:success", function(event) {
      $(this).parents('.modal').modal('hide');
      location.reload();
    })
    .bind("ajax:error", function(event) {
      const errors = event.detail[0]["errors"]
      const errorList = $.map(errors, function(v, k) {
        const errorMessage =  `<div class='alert alert-danger pull-left'>${v.join("<br>")}</div>`
        switch(k) {
          case 'email':
            $('#sign-up-modal').find('.email-error').html(errorMessage);
            break;
          case 'password':
            $('#sign-up-modal').find('.password-error').html(errorMessage);
            break;
          case 'name':
            $('#sign-up-modal').find('.name-error').html(errorMessage);
            break;
          case 'phone_number':
            $('#sign-up-modal').find('.phone-number-error').html(errorMessage);
            break;
          case 'password_confirmation':
            $('#sign-up-modal').find('.password-confirmation-error').html(errorMessage);
            break;
          default:
           $('#sign-up-modal').find('.modal-errors').html(errorMessage);
            break;
        }
      });
    });

  $('#close-modal-cross').on("click", function(){
   $(".modal-errors").empty();
  });

  $('.modal').on("click", function(){
   $(".modal-errors").empty();
  });
});
