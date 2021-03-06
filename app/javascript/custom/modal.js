$(document).on('turbolinks:load', function() {

  // fills .modal-errors div in sign-in-user modal
  $("form#sign-in-user")
    .on("ajax:success", function(event) {
      $(this).parents('.modal').modal('hide');
      location.reload();
    })
    .on("ajax:error", function(event) {
      $(".modal-errors").empty();
      const [errors, status, xhr] = event.detail
      const error_messages =  $.map(errors, function(value, key) {
        return `<p class="text-danger mb-1">${value}</p>`;
      }).join("");
      return $('#sign-in-modal').find('.modal-errors').html(error_messages);
    });

  // fills .modal-errors divs in sign-up-user modal
  $("form#sign-up-user")
    .on("ajax:success", function(event) {
      $(this).parents('.modal').modal('hide');
      $("#password-confirmation-modal").modal("show");
    })
    .on("ajax:error", function(event) {
      $(".modal-errors").empty();
      const errors = event.detail[0]["errors"]
      const errorList = $.map(errors, function(value, key) {
        const errorMessage = `<p class="text-danger mb-1">${value.join(',')}</p>`
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

  // fills .modal-errors divs in other modal
  $("form#new-password-user, form#edit-password-user, form#new-conformation-user")
    .on("ajax:success", function(event) {
      $(this).parents('.modal').modal('hide');
    })
    .on("ajax:error", function(event) {
      $(".modal-errors").empty();
      const errors = event.detail[0]["errors"]
      const error_messages =  $.map(errors, function(value, key) {
        return `<p class="text-danger mb-1">${key}: ${value}</p>`;
      }).join("");
      return $('.modal').find('.modal-errors').html(error_messages);
    });

  //opens modal after ajax:succes
  $("form#new-password-user")
    .on("ajax:success", function(event) {
      $(this).parents('.modal').modal('hide');
      $("#password-instructions-modal").modal("show");
      setTimeout(function () {
      $("#password-instructions-modal").modal("hide");
      }, 5000)
    })

  // clears error and input fields data after closing the modal
  $('.modal').on('hide.bs.modal', function () {
    $(".modal-errors").empty();
    $(".modal-input").val('');
  });

  // shows modal error after click "change password link", and add token to appropriate field

  let searchParams = new URLSearchParams(window.location.search)

  if (searchParams.has('reset_password_token')) {
    $("#edit-password-modal").modal("show");
    const token = searchParams.get('reset_password_token');
    $("#edit-password-modal").find("#reset-password-token").val(token);
    let uri = window.location.toString();
    if (uri.indexOf("?") > 0) {
      var clean_uri = uri.substring(0, uri.indexOf("?"));
      window.history.replaceState({}, document.title, clean_uri);
    };
  };

  $("form#edit-password-user")
  .on("ajax:success", function(event) {
    location.reload()
  })
});
