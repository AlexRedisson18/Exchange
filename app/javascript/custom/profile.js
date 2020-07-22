$(document).on('turbolinks:load', function() {
  $('form#profile-form').areYouSure( {'silent':true} );

  $('form#profile-form').on('dirty.areYouSure', function() {
    $(this).find('input[type="submit"]').removeAttr('disabled');
  });
  $('form#profile-form').on('clean.areYouSure', function() {
    $(this).find('input[type="submit"]').attr('disabled', 'disabled');
  });
});
