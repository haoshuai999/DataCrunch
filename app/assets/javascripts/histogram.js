function drawHistogram(data, column_name){
    // var column_name = datafile.shift();
    if (column_name.includes(".")){
        column_name_array = column_name.split(".");
        nested_length = column_name_array.length
    }
    else{
        nested_length = 1
    }

    console.log(data);
    console.log(column_name);

    var num_of_bar = 20
    // set the dimensions and margins of the graph
    var margin = {top: 10, right: 30, bottom: 75, left: 40},
        width = 460 - margin.left - margin.right,
        height = 400 - margin.top - margin.bottom;

    // append the svg object to the body of the page
    var svg = d3.select("#chart")
    .append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
    .append("g")
        .attr("transform",
            "translate(" + margin.left + "," + margin.top + ")");

    setTimeout(function(){
        // X axis: scale and draw:
        var min = d3.min(data, function(d) { 
            if (nested_length == 1){
                return d[column_name]
            }
            else if(nested_length == 2){
                return d[column_name_array[0]][column_name_array[1]]
            }
            else if(nested_length == 3){
                return d[column_name_array[0]][column_name_array[1]][column_name_array[2]]
            }
            else if(nested_length == 4){
                return d[column_name_array[0]][column_name_array[1]][column_name_array[2]][column_name_array[3]]
            }
            else{
                console.log("error. Too many nested layers")
            }
            //return d["Funding"]["Request"];
        });
        var max = d3.max(data, function(d) { 
            // if (column_name.includes(".")){
            //     column_name_array = column_name.split(".");
            //     for (let i = 0; i < column_name_array.length - 1; i++){
            //         d = d[column_name_array[i]];
            //     }
            //     console.log(d);
            // }
            //console.log(d[column_name_array.pop()]);
            //return d[column_name_array.pop()];
            //console.log(d["Funding"]["Request"]);
            if (nested_length == 1){
                return d[column_name]
            }
            else if(nested_length == 2){
                return d[column_name_array[0]][column_name_array[1]]
            }
            else if(nested_length == 3){
                return d[column_name_array[0]][column_name_array[1]][column_name_array[2]]
            }
            else if(nested_length == 4){
                return d[column_name_array[0]][column_name_array[1]][column_name_array[2]][column_name_array[3]]
            }
            else{
                console.log("error. Too many nested layers")
            }
        });
        
        var extra_bar = (max - min)/num_of_bar;
        if ((min - extra_bar) < 0){
            min = 0
        }
        else{
            min = min - extra_bar
        }

        var x = d3.scaleLinear()
            .domain([min, max + extra_bar])
            //.domain(d3.extent(data, function(d) { return +d[column_name] }))    
            .range([0, width]);
        svg.append("g")
            .attr("transform", "translate(0," + height + ")")
            .call(d3.axisBottom(x))
        .selectAll("text")
            .attr("dy", ".35em")
            .attr("transform", "rotate(45)")
            .style("text-anchor", "start");
        
        // set the parameters for the histogram
        var histogram = d3.histogram()
            .value(function(d) { 
                if (nested_length == 1){
                    return d[column_name]
                }
                else if(nested_length == 2){
                    return d[column_name_array[0]][column_name_array[1]]
                }
                else if(nested_length == 3){
                    return d[column_name_array[0]][column_name_array[1]][column_name_array[2]]
                }
                else if(nested_length == 4){
                    return d[column_name_array[0]][column_name_array[1]][column_name_array[2]][column_name_array[3]]
                }
                else{
                    console.log("error. Too many nested layers")
                }
            })   // I need to give the vector of value
            .domain(x.domain())  // then the domain of the graphic
            .thresholds(x.ticks(num_of_bar)); // then the numbers of bins

        // And apply this function to data to get the bins
        var bins = histogram(data);
        // var bins = 3;

        // Y axis: scale and draw:
        var y = d3.scaleLinear()
            .range([height, 0]);
        y.domain([0, d3.max(bins, function(d) { return d.length; })]);   // d3.hist has to be called before the Y axis obviously
        svg.append("g")
            .call(d3.axisLeft(y));

        // append the bar rectangles to the svg element
        svg.selectAll("rect")
            .data(bins)
            .enter()
            .append("rect")
                .attr("x", 1)
                .attr("transform", function(d) { return "translate(" + x(d.x0) + "," + y(d.length) + ")"; })
                .attr("width", function(d) { return x(d.x1) - x(d.x0); })
                .attr("height", function(d) { return height - y(d.length); })
                .style("fill", "#69b3a2")

    },200);
 
};