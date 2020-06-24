$(document).on('turbolinks:load', function() {
  $('.my-select').selectpicker();

  $("form#new-lot")
    .on("ajax:success", function(event) {
    location.replace("/lots");
    })
    .on("ajax:error", function(event) {
      const errors = event.detail[0]
      const errorList = $.map(errors, function(value, key) {
        const errorMessage = `<p class="text-danger mb-1">${value.join('<br>')}</p>`
        switch(key) {
          case 'title':
            $('#new-lot').find('.title-error').html(errorMessage);
            break;
          case 'price':
            $('#new-lot').find('.price-error').html(errorMessage);
            break;
          case 'interesting_categories':
            $('#new-lot').find('.interesting-categories-errors').html(errorMessage);
            break;
          default:
            $('#new-lot').find('.modal-errors').html(errorMessage);
            break;
        }
      });
    });
});
