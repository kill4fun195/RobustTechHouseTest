// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require bootstrap
//= require readmore.min
//= require jquery.timeago
//= require turbolinks
//= require_tree .

$(document).on("turbolinks:load", function() {
  $(".show-form-update-avatar").on("click", function(){
    $(".form-update-avatar").toggle();
  });

  if($("#sort-created-at").length > 0)
  {
    document.getElementById("sort-created-at").onchange = function() {myFunction()
    };
    function myFunction() {
      var value_sort = document.getElementById("sort-created-at").value;
      setTimeout(function(){ 
        Turbolinks.visit(window.location.pathname + "?sort="+value_sort);
      }, 50);
    };
  }

  //init readmore, readless
  window.initReadMoreText = function(){
    $(".read-more-text").each(function(index, elem) {
      var speed = parseInt($(elem).attr("data-speed")) || 500
      var height = parseInt($(elem).attr("data-height")) || 40
      $(elem).readmore({
        speed: speed,
        moreLink: "<a href='#'>Read more</a>",
        lessLink: "<a href='#'>Read less</a>",
        collapsedHeight: height
      });
    }
  )}
  window.initReadMoreText();

  $("time.timeago").timeago();
  
});
