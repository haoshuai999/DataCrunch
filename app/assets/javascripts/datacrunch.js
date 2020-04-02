var loadData = function(column_name){
    $.ajax({
      type: 'GET',
      contentType: 'application/json; charset=utf-8',
      url: window.location.pathname,
      dataType: 'text',
      success: function(data){
        drawHistogram(data, column_name);
      },
      failure: function(result){
        error();
      }
    });
};

function error() {
    console.log("Something went wrong!");
}

// draw bar plot
// function drawBarPlot(data){};

// fetch data on page load
$(document).ready(function(){
    $("tr:nth-child(2) td").each(function(i){
      $(this).on("click", function(){
        $("svg").remove();
        var column_name = $("tr:nth-child(2) td:nth-child("+ (i+1) + ") a").text();
        console.log(i);
        loadData(column_name); 
      });
    });
});