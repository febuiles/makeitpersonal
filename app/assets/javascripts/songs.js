var loader = new Loader();

$(function(){

  $("a.song").click(function(){
    $(this).next(".song-links").slideToggle();
  });

  $("#fetch-lyrics").click(function(e){
    e.preventDefault();

    var data = {
      artist: $("#song_artist").val(),
      title: $("#song_title").val()
    };

    $.ajax({
      url: "/lyrics",
      method: "get",
      data: data,
      beforeSend: loader.start,
      success: success,
      error: error
    });
  });

  var write = function(data) {
    $("#song_lyrics").val("");
    $("#song_lyrics").val($.trim(data));
  }

  var error = function(xhr, status, error) {
    loader.stop();
    write("There has been an error processing the data. Please try again.");
  };

  var success = function(data, status, jqXhr) {
    loader.stop();
    write(data);
  };
})


