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




          // BORDER





      function applyD3Selectors(){

      var firstStats = Math.floor(parseFloat($("#first_stats").text()));
      var secondStats = Math.floor(parseFloat($("#second_stats").text()));
      var thirdStats = Math.floor(parseFloat($("#third_stats").text()));
      var fourthStats = Math.floor(parseFloat($("#fourth_stats").text()));
      
      // $("#first_stats").html(firstStats);
      // $("#second_stats").html(secondStats);
      // $("#third_stats").html(thirdStats);
      // $("#fourth_stats").html(fourthStats);

      // d3.selectAll("#first_stats").style("background-color","orange");
      // d3.selectAll("#second_stats").style("background-color","green");
      // d3.selectAll("#third_stats").style("background-color","blue");
      // d3.selectAll("#fourth_stats").style("background-color","lavender");

      // d3.selectAll(".prof-text")
      //     .data(barLength)
      //     .style("width", function(d) { return d + "px"; });

// DIVIDER
      var data = [firstStats, secondStats, thirdStats, fourthStats];
      var x = d3.scale.linear()
          .domain([0, d3.max(data)])
          .range([0, 200]);

      d3.select(".text-container")
        .selectAll("prof-text")
          .data(data)
        .enter().append(".prof-text")
          .style("width", function(d) { return x(d) + "px"; })
          .text(function(d) { return d; });
      }

      applyD3Selectors();
      // D3 end

    });
  });
};
