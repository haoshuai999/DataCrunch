var loadData = function(){
    $.ajax({
      type: 'GET',
      contentType: 'application/json; charset=utf-8',
      url: $(this).attr("href"),
      dataType: 'json',
      success: function(data){
        console.log(data);
        console.log(data["datatype"]);
        if (data["datatype"] == 'numeric'){
          drawHistogram(data["continuous"], data["columnname"]);
        }
        else{
          drawBarchart(data["categorical"]);
        }
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
