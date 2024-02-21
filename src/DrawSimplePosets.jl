module DrawSimplePosets

using SimplePosets, SimpleGraphs, DrawSimpleGraphs, SimpleDrawing

import SimpleDrawing: draw, draw!
import DrawSimpleGraphs: embed, getxy

export draw, draw!, embed, getxy, setxy!

export HasseDiagram
"""
HasseDiagram(P::SimplePoset) 

Create a new `HasseDiagram` for the poset `P` that has no embedding.
"""
struct HasseDiagram{T}

    P::SimplePoset{T}
    G::UndirectedGraph{T}

    function HasseDiagram(PP::SimplePoset{T}) where {T}
        G = simplify(CoverDigraph(PP))
        new{T}(PP, G)
    end
end

import Base: show

function show(io::IO, H::HasseDiagram)
    print(io, "Hasse diagram of $(H.P)")
end

include("embed.jl")
include("draw.jl")
include("shift_scale.jl")

end # module DrawSimplePosets
