# `DrawSimplePosets`
Create and draw Hasse diagrams. This is a companion to `DrawSimpleGraphs`.

> **NOTE**: This is a work in progress; more to come.

## Overview


A Hasse diagram is a drawing of a partially ordered set. Given a poset `P`,
we construct a drawing of `P` like this:
```
H = HasseDiagram(P)
```
At this point, `H` does *not* have an embedding of the elements of `P`. 

The function `setxy!(H, xy)` is used to assign coordinates to the elements of the poset. 
Here `xy` is a dictionary mapping elements of `P` (the poset used to create `H`) to 
points in the plane represented as a two-element vector. That is, if `P` is a `SimplePoset` whose elements have type `T`, then `xy` is of type `Dict{T, Vector{Float64}}`.

If `setxy!` is invoked as `setxy!(H)` then a default embedding is assigned to `H` (using the `basic_embedding` function).

Finally, calling `draw(H)` will draw the poset `P` on the screen using the embedding associated with `H`. 

For convenience, if `H` does not have an embedding, one will be automatically assigned to it using the `basic_embedding` function. 

Finally, if `draw` is applied to a poset `P`, then `draw(P)` is equivalent to `draw(HasseDiagram(P))`.

```
julia> using SimplePosets, DrawSimplePosets

julia> P = Divisors(120)
SimplePoset{Int64} (16 elements)

julia> draw(P)
```
results in this image:

![](divisors-120.png)

The `draw` function takes an optional second argument, `clear_first`, which is `true` by default. Use `draw(H,false)` to draw a Hasse diagram without first clearing the screen. Alternatively, `draw!(H)` has the same effect. 



## Basic Functions

### Construction

If `P` is a `SimplePoset`, then `HasseDiagram(P)` creates a Hasse diagram of `P`.


### Specifying coordinates

Given a Hasse diagram `H` of a poset `P` the function `setxy!` is used to assign
coordinates to the elements of `P`. The function `setxy!` is applied to the Hasse diagram
like this: 
```
setxy!(H, xy)
```
where `xy` is a dictionary mapping elements of the poset to coordinates in the plane. 
That is, if `P` is a `SimplePoset` whose elements have type `T`, then `xy` is of type `Dict{T, Vector{Float64}}`.

Calling `setxy!(H)` embues `H` with coordinates created by `basic_embedding`.

### Getting coordinates

Use `getxy(H)` to return a dictionary mapping the elements of the poset `P` 
to coordinates (values of type `Vector{Float64}`).

### Shifting and scaling

NOT YET IMPLEMENTED


## Embedding Functions

This section will list the available embedding functions. At present, there is only one: `basic_embedding`. I hope we have others "eventually". 

In general, an embedding function `f` takes a `SimplePoset` as its argument and returns
an `xy` embedding for that poset. 

### `basic_embedding`

The function `basic_embedding` creates `xy`-coordinates for a poset, `P` as follows.

The minimal elements of `P` are all assigned `y`-coordinate 1. The `x`-coordinates are chosen so 
these elements are evenly spaced, distance 1 apart, and overall centered at 0. For example, if there are three minimal elements, their coordinates will be `[-1, 1]`, `[0, 1]`, and `[1,1]`. If there are four minimal elements, their `x`-coordinates will be `-1.5`, `-0.5`, `0.5`, and `1.5`.

Next, the minimal elements of `P` are discarded [no change is made to the poset] and the minimal elements of the remainder are assigned `y`-coordinate 2. The `x`-coordinates of these minimals are assigned as 
previously described.

Now these minimal elements are discarded, the minimals of the remainder are assigned `y`-coordinate 3, and so forth.





## `DrawSimplePosets` versus `DrawSimpleGraphs`

These two modules have differing design philosophies. 

Drawings of undirected graphs using `SimpleGraphs` and `DrawSimpleGraphs` are attached to the graphs themselves. That is, the `xy`-embedding of an `UndirectedGraph` is part of the data structure 
of that graph. 

For partially ordered sets we have taken a different approach. A `SimplePoset` object contains no `xy`-embedding information. Rather, a `HasseDiagram` created from that poset has the embedding. It is possible to create two (or more) Hasse diagrams of the same poset, each with its own embedding. 

## Under the Hood

A `HasseDiagram` object `H` has two fields:
* `P` which is the poset from which `H` was created.
* `G` which is an `UndirectedGraph` whose vertices are the elements of `P` and in which there is an edge from `u` to `v` if either `u` is a cover for `v` or `v` is a cover for `u`. These are the edgeds that are drawn in the diagram.

After `H = HasseDiagram(P)` the field `H.P` is the same exact object as `P`. The field `H.G` is 
created from `P` by finding the covering digraph and then ignoring directions. Subsequent changes to `P` will affect `H.P` but not `H.G`. 
