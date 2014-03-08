// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require turbolinks
//= require jquery.turbolinks
//= require bootstrap
//= require_tree .

$(document).ready(function() {
    // $.fn.fullpage({
    // });

//  CUSTOM HAMBURGER MENU
  $("#hamclose").hide();
    $("#hambut").click(function(){
        $('#content').animate({'margin-left' : '50%'});
        $(".ham-container").animate({'margin-left' : '50%'});
        $("#menu").show().animate({'width':'50%'})
        $("#hambut").hide();
        $("#hamclose").show();
        });

  $("#hamclose").click(function(){
    $('#content').animate({'margin-left' : '0px'});
    $(".ham-container").animate({'margin-left' : '0px'});
    $("#menu").show().animate({'width':'0px'})
    $("#hamclose").hide();
    $("#hambut").show();
    });

// SWIPE ACTIONS
  $(function() {
        //Enable swiping...
        $(".profile-card").swipe( {
          // Generic ALL DIRECTION Swiping
          // swipe:function(event, direction, distance, duration, fingerCount) {
          //   console.log("You swiped " + direction);
          // },

          swipeLeft:function(event, distance, duration, fingerCount) {
            console.log("swipeLeft from callback");

            var employee_id = $(this).attr('id');
            console.log(employee_id);
            //  POST TO FAVORITES LIST
            $.post("/favorites", { employee: employee_id }, null, 'script');
            $("#"+employee_id).animate({'margin-left':'-1000px'})
          },

          swipeRight:function(event, distance, duration, fingerCount) {
            var employee_id = $(this).attr('id');
            console.log("swipeRight from callback");
            $("#"+employee_id).animate({'margin-right':'-1000px'})
            //  What to do when swipe right (reject)
          },
          //Default is 75px, set to 0 for demo so any distance triggers swipe
           threshold:75
        });
      });
});