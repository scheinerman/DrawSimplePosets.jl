module DrawSimplePosets

using SimplePosets, SimpleGraphs, DrawSimpleGraphs, SimpleDrawing

import SimpleDrawing: draw
export draw

export HasseDiagram

struct HasseDiagram{T}

    P::SimplePoset{T}
    G::UndirectedGraph{T}

    function HasseDiagram(PP::SimplePoset{T}) where T
        G = simplify(CoverDigraph(PP))
        embed(G, :combined)  # for now
        new{T}(PP,G)
    end
end

draw(H::HasseDiagram) = draw(H.G)
draw(P::SimplePoset) = draw(HasseDiagram(P))

end # module DrawSimplePosets
