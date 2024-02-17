module DrawSimplePosets

using SimplePosets, SimpleGraphs, DrawSimpleGraphs, SimpleDrawing

import SimpleDrawing: draw
import DrawSimpleGraphs: embed, getxy

export draw, embed, getxy

export HasseDiagram
"""
HasseDiagram(P::SimplePoset) 

Create a new `HasseDiagram` for the poset `P`.
"""
struct HasseDiagram{T}

    P::SimplePoset{T}
    G::UndirectedGraph{T}


    function HasseDiagram(PP::SimplePoset{T}) where {T}
        G = simplify(CoverDigraph(PP))
        d = basic_embedding(PP)
        embed(G, d)  # for now
        new{T}(PP, G)
    end
end

draw(H::HasseDiagram) = draw(H.G)
draw(P::SimplePoset) = draw(HasseDiagram(P))

"""
    getxy(H::HasseDiagram)

Return a dictionary mapping elements of the poset associated
with `H` to coordinates (type `Vector{Float64}`)
"""
getxy(H::HasseDiagram) = getxy(H.G)


include("embed.jl")

end # module DrawSimplePosets
