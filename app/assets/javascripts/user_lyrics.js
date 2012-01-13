$(function(){

  $("form").submit(function() {
    if (!validate())
      return false;
  })

  $("#user_lyric_artist, #user_lyric_title").
    keyup( function(event) {
      if (event.keyCode == 13) {
        $("#fetch_lyrics").trigger("click");
      }
    })

  $("#fetch_lyrics").click(function(){
    var data = {
      artist: $("#user_lyric_artist").val(),
      title: $("#user_lyric_title").val()
    };

    $.ajax({
      url: "/lyrics",
      method: "get",
      data: data,
      beforeSend: showLoading,
      success: success,
      error: error
    });
  });

  var write = function(data) {
    $("#user_lyric_lyrics").val("");
    $("#user_lyric_lyrics").val($.trim(data));
  }

  var showLyrics = function() {
    $("div.wrap").css("height", "940px");
    $("#fetch_lyrics").hide();
    $(".hidden").removeClass("hidden");
  }

  var unbindKeyEvents = function() {
    $("#user_lyric_artist, #user_lyric_title").unbind("keyup");
  }

  var writeLyric = function(data) {
    hideLoading();
    unbindKeyEvents();
    showLyrics();
    write(data);
  }

  var error = function(xhr, status, error) {
    hideLoading();
    showLyrics();
    write("There has been an error processing the data. Please try again.");
  };

  var success = function(data, status, jqXhr) {
    writeLyric(data);
  };

  var validate = function() {
    var valid = true;
    selectors = ["#user_lyric_artist", "#user_lyric_title", "#user_lyric_lyrics"];
    $.each(selectors, function(i, selector){
      if ($(selector).val() === "") {
        $(selector).addClass("invalid");
        valid = false;
      }
    });

    return valid;
  }
});