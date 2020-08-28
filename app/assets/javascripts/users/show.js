$(function () {
  $(".title_style").on("click", function () {
    $(this).next().slideToggle();
    $(this).toggleClass('open');
  });
});
