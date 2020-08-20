$(document).on('turbolinks:load', function() {

  $("form#new-offer")
    .on("ajax:success", function(event) {
      $(this).parents('.modal').modal('hide');
      location.reload();
    });

  $(".js-suggested-lot").focus(function() {
    const input = $(".js-suggested-lot-id-input");
    let lotId = $(this).attr('js-lot-id');
    input.val(lotId)
  });


  $('#new-offer-modal').on('shown.bs.modal', function () {
    $(".slider").not('.slick-carousel').slick({
    // $('.slick-carousel').slick({
    slidesToShow: 3,
    slidesToScroll: 1,
    dots: true,
    infinite: false
    });
  })
});
