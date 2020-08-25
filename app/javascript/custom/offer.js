$(document).on('turbolinks:load', function() {

  $("form#new-offer")
    .on("ajax:success", function(event) {
      $(this).parents('.modal').modal('hide');
      location.reload();
    });

  $(".js-suggested-lot").click(function() {
    const input = $(".js-suggested-lot-id-input");
    let lotId = $(this).attr('js-lot-id');
    input.val(lotId)
  });

  $('.slick-carousel').slick({
    slidesToShow: 3,
    dots: true,
    arrows: true,
    infinite: false
  });

  $('#new-offer-modal').on('show.bs.modal', function () {
    $(this).fadeIn();
    $(this).resize();
  });

});
