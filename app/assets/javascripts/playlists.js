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

  var error = function() {
    hideLoading();
    write("There has been an error processing the data. Please try again.");
  };

  var success = function(evt, data, status, xhr) {
    hideLoading();
    write(data);
  };

 $("#new_playlist")
    .live("ajax:beforeSend", showLoading)
    .live("ajax:error",  error)
    .live("ajax:success", success);
});