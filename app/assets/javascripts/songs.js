$(function(){

  $("a.song").click(function(){
    $(this).next(".song-links").slideToggle();
  });

  $(".fetch-lyrics").click(function(e){
    e.preventDefault();

    var lyric = new Lyric();
    lyric.fetch($("#song_artist").val(), $("#song_title").val());
  });
})


