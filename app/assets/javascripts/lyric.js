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
    $("#set-video").show();
    if (data === "Sorry, We don't have lyrics for this song yet.") {
      activateStep("step2-nolyrics");
    } else {
      activateStep("step2");
    }

    write(data);
  };

  var write = function(data) {
    outputField.val("");
    outputField.val($.trim(data));
  }

  var showLyrics = function() {
    outputField.slideDown();
  }

  var activateStep = function(id) {
    $(".step-active").slideUp();
    $(".step-active").removeClass("step-active");
    $("#" + id).slideDown();
    $("#" + id).addClass("step-active")
  }

  var setVideo = function() {
    activateStep("step3");
    $("#song_youtube_url").show();
    $("#publish").show();
    $("#set-video").replaceWith($("#publish"));
  }

  var publish = function() {

  }

  $("#set-video, .set-video").click(setVideo);
  $(".publish").click(publish);
}