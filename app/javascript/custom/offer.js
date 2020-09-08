$(document).on('turbolinks:load', function() {

  $("form#new-offer")
    .on("ajax:success", function(event) {
      $(this).parents('.modal').modal('hide');
      location.reload();
    })
    .on("ajax:error", function(event) {
      $(".modal-errors").empty();
      const errors = event.detail[0]
      const errorList = $.map(errors, function(value, key) {
        const errorMessage = `<p class="text-danger mb-1">${value.join(',')}</p>`
        switch(key) {
          case 'messages.body':
            $('#new-offer-modal').find('.message-error').html(errorMessage);
            break;
          case 'suggested_lot':
            $('#new-offer-modal').find('.suggested-lot-error').html(errorMessage);
            break;
          default:
            $('#new-offer-modal').find('.modal-errors').html(errorMessage);
            break;
        }
      });
    });

  $(".js-suggested-lot").click(function() {
    const input = $(".js-suggested-lot-id-input");
    let lotId = $(this).attr('js-lot-id');
    input.val(lotId)
  });

  $('.slick-carousel').slick({
    slidesToShow: 3,
    slidesToScroll: 1,
    dots: true,
    arrows: true,
    infinite: false
  });

  $('#new-offer-modal').on('show.bs.modal', function () {
    $(this).fadeIn();
    $(this).resize();
  });

  $('.slick-lot-container').click(function() {
    $('.slick-lot-container').removeClass('active-lot');
    $(this).addClass('active-lot')
  })
});
