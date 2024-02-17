"""
    draw(H::HasseDiagram)

Draw the Hasse digram `H` using its current `xy`-embedding. 
If it does not have an `xy`-embedding, create one for it
using `basic_embedding`.
"""
function draw(H::HasseDiagram)
    if !hasxy(H.G)
        setxy!(H)
    end
    draw(H.G)
end


draw(P::SimplePoset) = draw(HasseDiagram(P))

"""
    getxy(H::HasseDiagram)

Return a dictionary mapping elements of the poset associated
with `H` to coordinates (type `Vector{Float64}`)
"""
function getxy(H::HasseDiagram)
    if !hasxy(H.G)
        setxy!(H)
    end
    getxy(H.G)
end
