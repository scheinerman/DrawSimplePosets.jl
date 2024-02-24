# These functions are pulled from graphs to apply to Hasse diagrams

import DrawSimpleGraphs: draw_labels
export draw_labels

draw_labels(H::HasseDiagram, x...) = draw_labels(H.G, x...)

import SimpleGraphs: set_line_color, get_line_color
export set_line_color, get_line_color

set_line_color(H::HasseDiagram, x...) = set_line_color(H.G, x...)
get_line_color(H::HasseDiagram) = get_line_color(H.G)

import SimpleGraphs: set_vertex_size, get_vertex_size
export set_vertex_size, get_vertex_size

set_vertex_size(H::HasseDiagram, x...) = set_vertex_size(H.G, x...)
get_vertex_size(H::HasseDiagram) = get_vertex_size(H.G)

import SimpleGraphs: set_vertex_color, get_vertex_color
export set_vertex_color, get_vertex_color

set_vertex_color(H::HasseDiagram, x...) = set_vertex_color(H.G, x...)
get_vertex_color(H::HasseDiagram, x...) = get_vertex_color(H.G, x...)