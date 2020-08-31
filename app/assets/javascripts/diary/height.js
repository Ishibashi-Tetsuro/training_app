$(function () {
  var biggestHeight = "0";
  $(".diary_info *").each(function () {
    if ($(this).height() > biggestHeight) {
      biggestHeight = $(this).height()
    }
  });
  $(".diary_info").height(biggestHeight);
})
