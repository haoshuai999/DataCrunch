var loadData = function(){
    $.ajax({
      type: 'GET',
      contentType: 'application/json; charset=utf-8',
      url: window.location.pathname,
      dataType: 'json',
      success: function(data){
        drawHistogram(data);
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
    console.log("called");
    loadData(); 
});