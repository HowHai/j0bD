// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

// AJAX call to get our single thing
window.loadEmployeesPage = function() {
  $(function() {
      $.ajax({
      type: 'GET',
      url: window.location.href + '.json',
      dataType: 'json'
  }).done(function(data) {

      // grabs the template we're going to use
      var source = $("#employees-template").html();

      // compiles it with Handlebars (pops content from things into thing-template)
      var template = Handlebars.compile(source);

      // displays compiled template with things in a div called content
      $('#employees-display').html(template(data));

      // D3 test
      // Get top 4 skills
      var firstStats = Math.floor(parseFloat($("#first_stats").text()) / 5000);
      var secondStats = Math.floor(parseFloat($("#second_stats").text()) / 5000);
      var thirdStats = Math.floor(parseFloat($("#third_stats").text()) / 5000);
      var fourthStats = Math.floor(parseFloat($("#fourth_stats").text()) / 5000);

      $("#first_stats").html(firstStats);
      $("#second_stats").html(secondStats);
      $("#third_stats").html(thirdStats);
      $("#fourth_stats").html(fourthStats);

      d3.selectAll("p").style("color", "white");
      d3.selectAll("p").style("background-color", "black");
      function applyD3Selectors(){
      var barLength = [firstStats, secondStats, thirdStats, fourthStats];
      d3.selectAll("p")
          .data(barLength)
          .style("width", function(d) { return d + "px"; });
      }

      applyD3Selectors();
      // D3 end

    });
  });
};
