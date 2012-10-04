#= require jquery-1.8.1.min.js
#= require d3.v2.min.js


# d3.select("body").transition()
#   .delay(1000)
#   .style("background-color", "black")

# create a svg area
svg = d3.select("body").append("svg").attr("width", "100%").attr("height", "100%")

# Data
# dataset = [ 5, 10, 15, 20, 25 ]

# Visualize
# circles = svg.selectAll("circle")
#   .data(dataset)
#   .enter()
#   .append("circle")

# circles.attr("class", "red")
#   .attr("cx", (d, i) ->
#     (i * 50) + 25)
#   .attr("cy", 30)
#   .attr("r", (d) ->
#     d)

# # animate
# circles.on "mouseover", () ->
#   circles.transition().duration(200).delay(200)
#     .attr("cy", (d, i) ->
#       (i * 50))

# circles.on "mouseout", () ->
#   circles.transition().duration(200).delay(200)
#     .attr("cy", 30)

width = 1200
height = 800

force = d3.layout.force()
  .gravity(.05)
  .linkStrength(0.3)
  .distance(150)
  .charge(-130)
  .size([width, height])

d3.json "/lemis.json", (json) -> 
  force
    .nodes(json.nodes)
    .links(json.links)
    .start()

  link = svg.selectAll(".link")
    .data(json.links)
    .enter().append("line")
    .attr("class", "link")

  node = svg.selectAll(".node")
    .data(json.nodes)
    .enter().append("g")
    .attr("class", "node")
    .call(force.drag)

  node.append("image")
      .attr("xlink:href", "images/user.png")
      .attr("x", -8)
      .attr("y", -8)
      .attr("width", 16)
      .attr("height", 16)

  node.append("text")
    .attr("dx", 12)
    .attr("dy", ".35em")
    .text (d) -> 
      d.name 

  force.on "tick", () -> 
    link.attr("x1", (d) -> d.source.x )
        .attr("y1", (d) -> d.source.y )
        .attr("x2", (d) -> d.target.x )
        .attr("y2", (d) -> d.target.y )

    node.attr "transform", (d) -> 
      "translate(" + d.x + "," + d.y + ")"



  # interaction
  # node.on "mouseenter", () ->
  #   d3.select(this).transition().delay(200)
  #     .attr("width", "48")
  #     .attr("height", "48")
  # node.on "mouseout", () ->
  #   d3.select(this).transition()
  #     .attr("stroke", "")