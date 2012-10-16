var Lyric = function(outputField) {
  var apiUrl = "/lyrics";
  var apiMethod = "get";
  var loader = new Loader();
  var outputField = outputField || $("#song_lyrics");
  var artist = "";
  var title = "";

  this.fetch = function(artist, title) {
    artist = artist;
    title = title;

    $.ajax({
      url: apiUrl,
      method: apiMethod,
      data: { artist: artist, title: title },
      beforeSend: loader.start,
      success: ajaxSuccess,
      error: ajaxError,
    });
  };

  var ajaxError = function(xhr, status, error) {
    loader.stop();
    showLyrics();
    if (artist === "" || title === "") {
      write("You need to enter the artist's name and the song title.")
    } else {
      write("There has been an error processing the data. Please try again.");
    }
  };

  var ajaxSuccess = function(data, status, jqXhr) {
    loader.stop();
    showLyrics();
    write(data);
  };

  var write = function(data) {
    outputField.val("");
    outputField.val($.trim(data));
  }

  var showLyrics = function() {
    outputField.slideDown();
  }
}