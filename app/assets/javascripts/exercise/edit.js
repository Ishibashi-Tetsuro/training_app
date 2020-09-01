$(function () {
  $(".exercise-edit-menu").on("click", function () {
    $(this).next().slideToggle();
    $(this).toggleClass('open');
  });
});
