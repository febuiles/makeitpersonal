//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

loader = new Loader();

$(function() {
  $("#toggle-login-form").click(function(){
    $("form.login").slideToggle();
  });

  // fix the tooltip on :method => :delete links
  $('a[rel="nofollow"]').tooltip();
});
