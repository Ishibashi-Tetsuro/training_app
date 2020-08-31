$(function () {
  var biggestHeight = "0";
  $(".actions *").each(function () {
    if ($(this).height() > biggestHeight) {
      biggestHeight = $(this).height()
    }
  });
  $(".actions").height(biggestHeight);
})
