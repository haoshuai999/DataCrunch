var loadData = function(){
    $.ajax({
      type: 'GET',
      contentType: 'application/json; charset=utf-8',
      url: window.location.pathname,
      dataType: 'json',
      success: function(data){
        console.log(data);
        drawHistogram(data["data_json"], data["columnname"]);
        //Maybe add modal js here?
      },
      failure: function(result){
        error();
      }
    });
    console.log("called");
};

function error() {
    console.log("Something went wrong!");
}


$(document).ready(function(){
  
  // $(".download-btn").append("<i class='material-icons'>face</i>")
  console.log($(".download-btn"))

});

// // fetch data on page load
// $(document).ready(function(){
//     $("tr:nth-child(2) td").each(function(i){
//       $(this).on("click", function(){
//         $("svg").remove();
//         var column_name = $("tr:nth-child(2) td:nth-child("+ (i+1) + ") a").text();
//         console.log(i);
//         loadData(column_name); 
//       });
//     });
// });
