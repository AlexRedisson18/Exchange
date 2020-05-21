document.addEventListener('DOMContentLoaded', function() {

  // fill .modal-errors div in sign-in-user modal
  $("form#sign-in-user")
  .bind("ajax:success", function(event) {
    $(this).parents('.modal').modal('hide');
    location.reload();
  })
  .bind("ajax:error", function(event) {
    const [errors, status, xhr] = event.detail
    const error_messages =  $.map(errors, function(value, key) {
      return `<div class='alert alert-danger pull-left'>${value}</div>`;
    }).join("")
    return $('#sign-in-modal').find('.modal-errors').html(error_messages);
  });

  // fill .modal-errors div in sign-up-user modal
  $("form#sign-up-user")
    .bind("ajax:success", function(event) {
      $(this).parents('.modal').modal('hide');
      location.reload();
    })
    .bind("ajax:error", function(event) {
      const errors = event.detail[0]["errors"]
      const errorList = $.map(errors, function(value, key) {
        const errorMessage =  `<div class='alert alert-danger pull-left'>${value.join("<br>")}</div>`
        switch(key) {
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

  // clear error and input fields data after closing the modal
  $('.modal').on('hide.bs.modal', function () {
    $(".modal-errors").empty();
    $(".modal-input").val('');
  });
});
