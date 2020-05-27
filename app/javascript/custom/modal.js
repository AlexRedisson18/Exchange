window.addEventListener("load", () => {

  // fills .modal-errors div in sign-in-user modal
  $("form#sign-in-user")
  .bind("ajax:success", function(event) {
    $(this).parents('.modal').modal('hide');
    location.reload();
  })
  .bind("ajax:error", function(event) {
    const [errors, status, xhr] = event.detail
    const error_messages =  $.map(errors, function(value, key) {
      return `<p class="text-danger">${value}</p>`;
    }).join("");
    return $('#sign-in-modal').find('.modal-errors').html(error_messages);
  });

  // fills .modal-errors divs in sign-up-user modal
  $("form#sign-up-user")
    .bind("ajax:success", function(event) {
      $(this).parents('.modal').modal('hide');
      location.reload();
    })
    .bind("ajax:error", function(event) {
      const errors = event.detail[0]["errors"]
      const errorList = $.map(errors, function(value, key) {
        const errorMessage = `<p class="text-danger">${value.join(',')}</p>`
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

  // fill .modal-errors div in other modal
  $("form#new-password-user, form#edit-password-user, form#new-conformation-user")
  .bind("ajax:success", function(event) {
    $(this).parents('.modal').modal('hide');
  })
  .bind("ajax:error", function(event) {
    const errors = event.detail[0]["errors"]
    const error_messages =  $.map(errors, function(value, key) {
      return `<p class="text-danger">${key} ${value}</p>`;
    }).join("");
    return $('.modal').find('.modal-errors').html(error_messages);
  });

  // clear error and input fields data after closing the modal
  $('.modal').on('hide.bs.modal', function () {
    $(".modal-errors").empty();
    $(".modal-input").val('');
  });

  // open modal error after click "change password link", and add token to appropriate field
  const openEditPasswordModal = () => {
    let searchParams = new URLSearchParams(window.location.search)

    if (searchParams.has('reset_password_token')) {
      $("#edit-password-modal").modal("show");
    };
    const token = searchParams.get('reset_password_token');
    $("#reset-password-token").val(token);
  };

  openEditPasswordModal();
});
