$(function(){
  var loading = function() {
    $("div.overlay, div#spinner").fadeIn();
  };

  var success = function(evt, data, status, xhr) {
    $("div.overlay, div#spinner").fadeOut();
    $("div#playlist").append(data);
  };

 $("#new_playlist")
    .live("ajax:beforeSend",  loading)
    .live("ajax:success", success);
});