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
    x0 = [xy[bj[k]][1] for k=1:n]


    # OPTIMIZATION GOES HERE


    function energy(x)
        nrg = 0.0

        # sum distance-squared for cover edges
        for e in G.E     # for each cover
            u,v = e
            i = bj(u)
            j = bj(v)
            d = dist2(x[i],y[i],x[j],y[j])
            nrg += sqrt(d)   # attraction
        end

        # repel forces for incomparables
        for uv in incomparables(P)
            u,v = uv
            i = bj(u)
            j = bj(v)
            d = dist2(x[i],y[i],x[j],y[j])
            nrg += -1/(d^(3)) # repulsion
        end
        return nrg
    end

    @show energy(x0)

    result = optimize(energy, x0, iterations = 100_000)
    @show result

    x = Optim.minimizer(result)

    # convert to xy dictionary
    newxy = Dict{T,Vector{Float64}}()
    for k = 1:n
        v = bj[k]
        newxy[v] = [x[k]; y[k]]
    end




    return newxy
end


function dist2(x1,y1,x2,y2)
    return (x1-x2)^2 + (y1-y2)^2
end