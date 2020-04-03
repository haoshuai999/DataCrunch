function drawHistogram(data_url, column_name){
    // var column_name = datafile.shift();
    console.log(data_url);
    console.log(column_name);

    // set the dimensions and margins of the graph
    var margin = {top: 10, right: 30, bottom: 30, left: 40},
        width = 460 - margin.left - margin.right,
        height = 400 - margin.top - margin.bottom;

    // append the svg object to the body of the page
    var svg = d3.select("#histogram")
    .append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
    .append("g")
        .attr("transform",
            "translate(" + margin.left + "," + margin.top + ")");

    var split_array = data_url.split('.')
    var file_type = split_array[split_array.length - 1];
    console.log(file_type);
    // get the data
    if (file_type == 'csv'){
        d3.csv(data_url).then(function(data) {
    
            setTimeout(function(){
                // X axis: scale and draw:
                console.log(column_name)
                var x = d3.scaleLinear()
                    .domain([d3.min(data, function(d) { return +d[column_name] }), d3.max(data, function(d) { return +d[column_name] })])    
                    .range([0, width]);
                svg.append("g")
                    .attr("transform", "translate(0," + height + ")")
                    .call(d3.axisBottom(x));
                
                // set the parameters for the histogram
                var histogram = d3.histogram()
                    .value(function(d) { return d[column_name]; })   // I need to give the vector of value
                    .domain(x.domain())  // then the domain of the graphic
                    .thresholds(x.ticks(70)); // then the numbers of bins
    
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
                        .attr("width", function(d) { return x(d.x1) - x(d.x0) -1 ; })
                        .attr("height", function(d) { return height - y(d.length); })
                        .style("fill", "#69b3a2")
    
            },200);
        });
    }
    else if(file_type == 'json'){
        d3.json(data_url).then(function(data) {
    
            setTimeout(function(){
                // X axis: scale and draw:
                console.log(column_name)
                var x = d3.scaleLinear()
                    .domain([d3.min(data, function(d) { return +d[column_name] }), d3.max(data, function(d) { return +d[column_name] })])    
                    .range([0, width]);
                svg.append("g")
                    .attr("transform", "translate(0," + height + ")")
                    .call(d3.axisBottom(x));
                
                // set the parameters for the histogram
                var histogram = d3.histogram()
                    .value(function(d) { return d[column_name]; })   // I need to give the vector of value
                    .domain(x.domain())  // then the domain of the graphic
                    .thresholds(x.ticks(70)); // then the numbers of bins
    
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
                        .attr("width", function(d) { return x(d.x1) - x(d.x0) -1 ; })
                        .attr("height", function(d) { return height - y(d.length); })
                        .style("fill", "#69b3a2")
    
            },200);
        });
    }
    // else if(file_type == 'xls' || file_type == 'xlsx' ){
    //     var table = XLSX.readFile(data_url);
    //     var data = XLSX.utils.sheet_to_json(table);
    //     setTimeout(function(){
    //         // X axis: scale and draw:
    //         console.log(column_name)
    //         var x = d3.scaleLinear()
    //             .domain([d3.min(data, function(d) { return +d[column_name] }), d3.max(data, function(d) { return +d[column_name] })])    
    //             .range([0, width]);
    //         svg.append("g")
    //             .attr("transform", "translate(0," + height + ")")
    //             .call(d3.axisBottom(x));
            
    //         // set the parameters for the histogram
    //         var histogram = d3.histogram()
    //             .value(function(d) { return d[column_name]; })   // I need to give the vector of value
    //             .domain(x.domain())  // then the domain of the graphic
    //             .thresholds(x.ticks(70)); // then the numbers of bins

    //         // And apply this function to data to get the bins
    //         var bins = histogram(data);
    //         // var bins = 3;

    //         // Y axis: scale and draw:
    //         var y = d3.scaleLinear()
    //             .range([height, 0]);
    //         y.domain([0, d3.max(bins, function(d) { return d.length; })]);   // d3.hist has to be called before the Y axis obviously
    //         svg.append("g")
    //             .call(d3.axisLeft(y));

    //         // append the bar rectangles to the svg element
    //         svg.selectAll("rect")
    //             .data(bins)
    //             .enter()
    //             .append("rect")
    //                 .attr("x", 1)
    //                 .attr("transform", function(d) { return "translate(" + x(d.x0) + "," + y(d.length) + ")"; })
    //                 .attr("width", function(d) { return x(d.x1) - x(d.x0) -1 ; })
    //                 .attr("height", function(d) { return height - y(d.length); })
    //                 .style("fill", "#69b3a2")

    //     },200);
    // }
    else{
        console.log("error!");
    }
 
};