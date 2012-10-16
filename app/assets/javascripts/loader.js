var Loader = function() {
  this.start = function() {
    $("div.overlay, div#spinner").fadeIn();
  }
  this.stop = function(){
    $("div.overlay, div#spinner").fadeOut();
  }
}
