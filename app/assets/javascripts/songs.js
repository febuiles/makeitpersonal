$(function(){
  $("a.song").click(function(){
    $(this).next(".song-links").slideToggle();
  });
})