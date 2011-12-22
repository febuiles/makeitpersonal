$(function(){
  var success = function(evt, data, status, xhr) {
    $("div#playlist").append(data);
  };

  var loading = function() {

  };

  $("#new_playlist")
    .live('ajax:loading', loading)
    .live('ajax:success', success);
});