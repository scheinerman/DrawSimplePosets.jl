module DrawSimplePosets

using SimplePosets, SimpleGraphs, DrawSimpleGraphs, SimpleDrawing, Optim

import SimpleDrawing: draw, draw!
import DrawSimpleGraphs: getxy
import SimpleGraphs: embed

export draw, draw!, embed, getxy, setxy!

export HasseDiagram
"""
HasseDiagram(P::SimplePoset) 

Create a new `HasseDiagram` for the poset `P` that has a basic embedding.
"""
struct HasseDiagram{T}

    P::SimplePoset{T}
    G::UndirectedGraph{T}

    function HasseDiagram(PP::SimplePoset{T}) where {T}
        G = simplify(CoverDigraph(PP))
        H = new{T}(PP, G)
        setxy!(H)
        return H
    end
end


import Base: show

function show(io::IO, H::HasseDiagram)
    print(io, "Hasse diagram of $(H.P)")
end

include("embed.jl")
include("draw.jl")
include("shift_scale.jl")
include("pass_through.jl")

end # module DrawSimplePosets
