function drawBarchart(data){
    console.log(data);

    // set the dimensions and margins of the graph
    var margin = {top: 30, right: 30, bottom: 75, left: 40},
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
        var x = d3.scaleBand()
            .rangeRound([0, width])
            .padding(0.1)
            .domain(data.map(function (d) {
                return d.column;
            }));

        svg.append("g")
            .attr("transform", "translate(0," + height + ")")
            .call(d3.axisBottom(x)) 
        .selectAll("text")
            .attr("dy", ".35em")
            .attr("transform", "rotate(45)")
            .style("text-anchor", "start");

        // Y axis: scale and draw:
        var y = d3.scaleLinear()
            .rangeRound([height, 0])
            .domain([0, d3.max(data, function (d) {
				return d.freq;
            })]);
            
        svg.append("g")
            .call(d3.axisLeft(y));

        svg.selectAll(".bar")
            .data(data)
            .enter().append("rect")
            .attr("class", "bar")
            .attr("x", function (d) {
                return x(d.column);
            })
            .attr("y", function (d) {
                return y(d.freq);
            })
            .attr("width", x.bandwidth())
            .attr("height", function (d) {
                return height - y(d.freq);
            })
            .style("fill", "#69b3a2");

        svg.selectAll(".bartext")
            .data(data)
            .enter().append("text")
            .attr("class", "bartext")
            .attr("text-anchor", "middle")
            .attr("x", function(d) { return x(d.column) + 15; })
            .attr("y", function(d) { return y(d.freq) -5 ; })
            .text(function(d) { return d.freq; })
            .style("font-size", "13px");

    },200);
 
};