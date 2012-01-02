$(function(){
  var write = function(data) {
    $("div#playlist").text("");
    $("div#playlist").append(data);
  }
  var showLoading = function() {
    $("div.overlay, div#spinner").fadeIn();
  };

  var hideLoading = function() {
    $("div.overlay, div#spinner").fadeOut();
  };

  var before = function() {
    if ($("#playlist_username").val() == "") {
      $("#playlist_username").css("border", "3px solid #D51007");
      return false;
    }
    else
      $("#playlist_username").css("border", "none");
    showLoading();
  };

  var error = function() {
    hideLoading();
    write("There has been an error processing the data. Please try again.");
  };

  var success = function(evt, data, status, xhr) {
    hideLoading();
    write(data);
    addClickSelect();
  };

  var addClickSelect = function() {
    $("p.share input").click(function(){
      this.select();
    })
  }

  $("#new_playlist")
    .live("ajax:beforeSend", before)
    .live("ajax:error",  error)
    .live("ajax:success", success);

  addClickSelect();
});