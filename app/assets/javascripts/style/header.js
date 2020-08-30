$(function () {
  const hum = $('.hamburger, .close, .fade-layer')
  const nav = $('.sp-nav')
  const fade = $('.fade-layer')
  hum.on('click', function () {
    nav.toggleClass('toggle');
    fade.toggleClass('visible-layer');
  });
});
