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

      var data = [1,2,3,4];

var x = d3.scale.linear()
    .domain([0, d3.max(data)])
    .range([0, 200]);

d3.select(".chart")
  .selectAll("div")
    .data(data)
  .enter().append("div")
    .style("width", function(d) { return x(d) + "px"; })
    .text(function(d) { return d; });


    });
  });
};
