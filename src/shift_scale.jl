export shift!, scale!, bounds


"""
    shift!(H::HasseDiagram, dx::Real, dy::Real = 0)

Modify the drawing `H` by adding `dx` to all `x`-coordinates and `dy` to all `y`-coordinates.
"""
function shift!(H::HasseDiagram, dx::Real, dy::Real = 0)
    xy = getxy(H)
    delta = [dx; dy]

    for a in keys(xy)
        xy[a] += delta
    end
    embed(H.G, xy)
    nothing
end


"""
    scale!(H::HasseDiagram, mx::Real, my::Real = 1)

Modify the drawing `H` by multiplying `mx` to all `x`-coordinates and `my` to all `y`-coordinates.
"""
function scale!(H::HasseDiagram, mx::Real, my::Real = 1)
    @assert mx != 0 && my != 0 "Multiplier(s) may not be zero"

    xy = getxy(H)

    for a in keys(xy)
        p = xy[a]
        p[1] *= mx
        p[2] *= my
        xy[a] = p
    end
    embed(H.G, xy)
    nothing
end


"""
    bounds(H::HasseDiagram)

Return a 4-tuple `(xmin,ymin,xmax,ymax)` that gives the boundary
of the Hasse diagram drawing. 

Note that the circles representing the elements of the poset may extend
beyond the boundary. 
"""
function bounds(H::HasseDiagram)
    xy = getxy(H)

    x = [xy[a][1] for a in keys(xy)]
    y = [xy[a][2] for a in keys(xy)]

    return minimum(x), minimum(y), maximum(x), maximum(y)
end
