export setxy!, setx!, sety!

function embed(P::SimplePoset{T}, method::Function = basic_embedding) where {T}
    H = HasseDiagram(P)
    xy = method(P)
    setxy!(H, xy)
    return H
end

"""
    setxy!(H::HasseDiagram{T}, xy::Dict{T,Vector{Float64}})

This function assigns x,y-coordinates to the elements of the poset 
represented by this Hasse diagram. 
"""
function setxy!(H::HasseDiagram{T}, xy::Dict{T,Vector{Float64}}) where {T}
    embed(H.G, xy)
end

setxy!(H::HasseDiagram) = setxy!(H, basic_embedding(H.P))



"""
    setx!(H::HasseDiagram{T}, xx::Dict{T,S}) 

Reset the x-coordinates of the Hasse diagram using the values in `xx`.
That is, if `v` has coordinates `[x; y]` then change that to `[xx[v]; y]`
"""
function setx!(H::HasseDiagram{T}, xx::Dict{T,S}) where {T,S<:Real}
    d = getxy(H)
    for v in keys(xx)
        if has(H.P, v)
            x = xx[v]
            y = d[v][2]
            d[v] = [x; y]
        end
    end
    setxy!(H, d)
end



"""
    sety!(H::HasseDiagram{T}, yy::Dict{T,S}) 

Reset the y-coordinates of the Hasse diagram using the values in `yy`.
That is, if `v` has coordinates `[x; y]` then change that to `[x; y[v]]`
"""
function sety!(H::HasseDiagram{T}, yy::Dict{T,S}) where {T,S<:Real}
    d = getxy(H)
    for v in keys(yy)
        if has(H.P, v)
            x = d[v][1]
            y = yy[v]
            d[v] = [x; y]
        end
    end
    setxy!(H, d)
end



include("basic_embedding.jl")
include("optim_embedding.jl")