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
      var secondStats = Math.floor(parseFloat($("#second_stats").text()) / 13000);
      var thirdStats = Math.floor(parseFloat($("#third_stats").text()) / 13000);
      var fourthStats = Math.floor(parseFloat($("#fourth_stats").text()) / 5000);

      $("#first_stats").html('HTML');
      $("#second_stats").html('Ruby');
      $("#third_stats").html('Javascript');
      $("#fourth_stats").html('PHP');

      d3.selectAll("#first_stats").style("background-color","orange");
      d3.selectAll("#second_stats").style("background-color","green");
      d3.selectAll("#third_stats").style("background-color","blue");
      d3.selectAll("#fourth_stats").style("background-color","lavender");
      function applyD3Selectors(){
      var barLength = [firstStats, secondStats, thirdStats, fourthStats];
      d3.selectAll(".prof-text")
          .data(barLength)
          .style("width", function(d) { return d + "px"; });
      }

      applyD3Selectors();
      // D3 end

    });
  });
};
