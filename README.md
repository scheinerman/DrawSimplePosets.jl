# DrawSimplePosets
Create and draw Hasse diagrams. This is a companion to `DrawSimpleGraphs`.


## Basic Functions


### Creating a basic Hasse diagram

To create a Hasse diagram for a poset `P` use `HasseDiagram(P)`. This 
creates a `HasseDiagram` object with a rather basic embedding for the 
elements of `P`. For small posets, it's not too terrible.

To then view the poset, use `draw(H)`. 

The `draw` function may be used with a poset `P`. 
`draw(P)` is equivalent to `draw(HasseDiagram(P))`.

### Getting coordinates

Use `getxy(H)` to return a dictionary mapping the elements of the poset `P` 
to coordinates (values of type `Vector{Float64}`).

### Specifying an embedding

Given a dictionary mapping elements of a poset `P` to coordinates, use
`embed(P,xy)` to create a Hasse diagram in which element `v` has coordinates
`xy[v]`.