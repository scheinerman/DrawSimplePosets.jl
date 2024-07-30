export optim_embedding


export element_bijection

"""
    element_bijection(P::SimplePoset{T})::Bijection{Int,T} where {T}

Create a `Bijection` from the integers `1:n` to the elements of `P`
(where `n` is the cardinality of `P`). 
"""
function element_bijection(P::SimplePoset{T})::Bijection{Int,T} where {T}
    b = Bijection{Int,T}()
    elts = elements(P)
    n = card(P)
    for k = 1:n
        b[k] = elts[k]
    end
    return b
end



"""
    optim_embedding(P::SimplePoset{T})::Dict{T,Vector{Float64}} where {T}

This is a first pass at an optimizing method for poset drawing.
"""
function optim_embedding(P::SimplePoset{T})::Dict{T,Vector{Float64}} where {T}
    xy = basic_embedding(P) # just to get us started

    plist = elements(P)  # vector of P's elements
    n = card(P)

    bj = element_bijection(P)
    G = simplify(CoverDigraph(P))

    hts = average_height(P)

    # The variable y contains the heights of the elements indexed 1:n 
    y = [hts[bj[k]] for k=1:n]

    # The variable x contains the horizontal displacements. 
    x = [xy[bj[k]][1] for k=1:n]


    # OPTIMIZATION GOES HERE


    # convert to xy dictionary
    
    newxy = Dict{T,Vector{Float64}}()
    for k = 1:n
        v = bj[k]
        newxy[v] = [x[k]; y[k]]
    end




    return newxy
end
