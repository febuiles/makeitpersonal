var Loader = function() {
  this.start = function() {
    console.log("foo");
    $("div.overlay, div#spinner").fadeIn();
  }
  this.stop = function(){
    $("div.overlay, div#spinner").fadeOut();
  }
}
