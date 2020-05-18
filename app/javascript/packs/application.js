// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
//= require jquery3
//= require popper
//= require bootstrap
//= require jquery_ujs
//= require_tree .
import "bootstrap"


import JQuery from 'jquery';
window.$ = window.JQuery = JQuery;

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


document.addEventListener('DOMContentLoaded', function() {
  $("form#sign_in_user")
    .bind("ajax:success", function(event) {
      $(this).parents('.modal').modal('hide');
      location.reload();
    })
    .bind("ajax:error", function(event) {
      const [errors, data, xhr] = event.detail
      const error_messages =  $.map(errors, function(v, k) {
        return `<div class='alert alert-danger pull-left'>${v}</div>`;
      }).join("")
      return $('.modal').find('.modal-errors').html(error_messages);
    });
});

document.addEventListener('DOMContentLoaded', function() {
  $("form#sign_up_user")
    .bind("ajax:success", function(event) {
      $(this).parents('.modal').modal('hide');
      location.reload();
    })
    .bind("ajax:error", function(event) {
      const errors = event.detail[0]["errors"]
      const errorList = $.map(errors, function(v, k) {
        const errorMessage =  `<div class='alert alert-danger pull-left'>${v.join(",")}</div>`
        switch(k) {
          case 'email':
            $('#sign_up_modal').find('.email-error').html(errorMessage);
            break;
          case 'password':
            $('#sign_up_modal').find('.password-error').html(errorMessage);
            break;
          case 'name':
            $('#sign_up_modal').find('.name-error').html(errorMessage);
            break;
          case 'phone_number':
            $('#sign_up_modal').find('.phone-number-error').html(errorMessage);
            break;
          case 'password_confirmation':
            $('#sign_up_modal').find('.password-confirmation-error').html(errorMessage);
            break;
          default:
          $('#sign_up_modal').find('.modal-errors').html(errorMessage);
            break;
        }
      });
    });

    $('#close-modal-cross','#sign_in_modal').on("click", function(){
     $(".modal-errors").empty();
    });

    $('.modal').on("click", function(){
     $(".modal-errors").empty();
    });

});
