$(function(){
  $("a.song-dropdown").click(function(){
    $(this).next(".song-links").slideToggle();
  });

 $("#song_artist, #song_title").keyup( function(event) {
   if (event.keyCode == 13) {
     $("#fetch-lyrics").click();
   }
 });

 $("#song_youtube_url").keyup( function(event) {
   if (event.keyCode == 13) {
     $("#publish").click();
   }
 });

  $(".fetch-lyrics").click(function(e){
    e.preventDefault();

    var lyric = new Lyric();
    lyric.fetch($("#song_artist").val(), $("#song_title").val());
  });

  $(".input-share").click(function(){ this.select(); })
})


