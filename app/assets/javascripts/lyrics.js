$(function(){
  var write = function(data) {
    $("#lyric_text").val("");
    $("#lyric_text").val($.trim(data));
  }
  var showLoading = function() {
    $("div.overlay, div#spinner").fadeIn();
  };

  var hideLoading = function() {
    $("div.overlay, div#spinner").fadeOut();
  };

  var before = function () {
    showLoading();
  }

  var resizeFields = function() {
    $("div.wrap").css("height", "940px");
    $("input[value='Fetch lyrics']").hide();
  }

  var disableAjax = function() {
    $("form#new_lyric").removeAttr("data-remote");
    $("form#new_lyric").removeData("remote");
    $("form#new_lyric").attr("method", "post");
  }

  var showLyric = function(data) {
    hideLoading();
    resizeFields();
    disableAjax();
    $(".hidden").removeClass("hidden");
    write(data);
  }

  var error = function(xhr, status, error) {
    hideLoading();

    if (status.status == 200) {
      showLyric(status.responseText);
    } else {
      write("There has been an error processing the data. Please try again.");
    }
  };

  var success = function(evt, data, status, xhr) {
    showLyric(data);
  };

  $("#new_lyric")
    .live("ajax:beforeSend", before)
    .live("ajax:error",  error)
    .live("ajax:success", success);
});