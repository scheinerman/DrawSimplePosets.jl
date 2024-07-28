export optim_embedding


"""
    optim_embedding(P::SimplePoset{T})::Dict{T,Vector{Float64}} where {T}

This is a first pass at an optimizing method for poset drawing.
"""
function optim_embedding(P::SimplePoset{T})::Dict{T,Vector{Float64}} where {T}
    xy = basic_embedding(P) # just to get us started

    plist = elements(P)  # vector of P's elements
    n = card(P)

    y = random_average_height(P, 20n)  

    for t in plist 
        xy[t][2] = y[t]
    end

    
    return xy
end
