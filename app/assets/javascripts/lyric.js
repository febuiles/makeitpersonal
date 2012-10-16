var Lyric = function(outputField) {
  var apiUrl = "/lyrics";
  var apiMethod = "get";
  var loader = new Loader();
  var outputField = outputField || $("#song_lyrics");
  var artist = "";
  var title = "";

  this.fetch = function(_artist, _title) {
    artist = _artist;
    title = _title;
    setHintLinks();

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
      $("#fetch-lyrics").hide();
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
    if (outputField.val() === "") {
      outputField.val("Please paste your lyrics here!")
      return false;
    }
    activateStep("step3");
    $("#song_youtube_url").show();
    $("#publish").show();
    $("#set-video").replaceWith($("#publish"));
  }

  var publish = function() {
    $("form#new_song").submit();
  }

  var setHintLinks = function() {
    var google = $("#google-hint");
    var youtube = $("#youtube-hint");
    var googleUrl = String.prototype.concat("http://www.google.com/search?q=", artist, " ", title, " lyrics");
    var youtubeUrl = String.prototype.concat("http://www.youtube.com/results?search_query=", artist, " ", title);

    google.attr("href", googleUrl);
    youtube.attr("href", youtubeUrl);
  }

  $("#set-video, .set-video").click(setVideo);
  $(".publish").click(publish);
}