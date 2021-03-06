$(function(){
  $("a.song-dropdown").click(function(){
    $(this).siblings(".song-links").slideToggle();
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

  $('#love-song, #unlove-song').click(loader.start);
  $('div#following a').click(loader.start);


  // Inline song editing

  $("#inline-edit-song").click(function(e){
    $("#song-body, #inline-edit-form, #user-toolbar").toggle();
  })


  var $inlineForm = $("#inline-edit-form form");
  $inlineForm.data("remote", true);
  $inlineForm.on("submit", function(e, status){
    loader.start();
  })

  $inlineForm.on("ajax:complete", function(e, status){
    $("#song-body, #inline-edit-form, #user-toolbar").toggle();
    var response = $("<div/>").html(status.responseText)
    var newUrl = response.find("#new-url").text();
    $("#song-body").replaceWith(response.find("#song-body"));
    $(".sidenotes").replaceWith(response.find(".sidenotes"));
    history.replaceState({}, response.find('#new-title').text(), newUrl);
    loader.stop();
  })
})
