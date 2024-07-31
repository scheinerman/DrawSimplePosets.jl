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


function optim_embedding(
    P::SimplePoset{T},
    reps::Int = 20,
)::Dict{T,Vector{Float64}} where {T}

    # first x0 from standard basic_embedding
    xy = basic_embedding(P) # just to get us started


    # TEMP ... RANDOMIZE
    for v in elements(P)
        xy[v] = [xy[v][1], randn()]
    end


    n = card(P)
    bj = element_bijection(P)

    x0 = [xy[bj[k]][1] for k = 1:n]

    xy, best = optim_embedding_work(P, x0)
    @show best

    for step = 1:reps
        @show step
        x0 = 10 * randn(n)
        tmp, val = optim_embedding_work(P, x0)
        if val < best
            xy = tmp
            best = val
            @show best
        end
    end

    return xy

end


"""
    optim_embedding_work(P::SimplePoset{T}, x0)::Dict{T,Vector{Float64}} where {T}

This is a first pass at an optimizing method for poset drawing.
"""
function optim_embedding_work(P::SimplePoset{T}, x0) where {T}
    plist = elements(P)  # vector of P's elements
    n = card(P)

    bj = element_bijection(P)
    G = simplify(CoverDigraph(P))

    hts = average_height(P)

    # The variable y contains the heights of the elements indexed 1:n 
    y = [hts[bj[k]] for k = 1:n]



    # OPTIMIZATION FUNCTION GOES HERE

    function energy(x)
        nrg = 0.0

        # attraction forces for covers 
        for e in G.E     # for each cover
            u, v = e
            i = bj(u)
            j = bj(v)
            d = sqrt(dist2(x[i], y[i], x[j], y[j]))

            nrg += (d - 1)^2   # attraction
        end


        # repel forces for incomparables
        # for uv in incomparables(P)
        #     u, v = uv
        #     i = bj(u)
        #     j = bj(v)
        #     d = dist2(x[i], y[i], x[j], y[j])
        #     nrg += 10 / (d) # repulsion
        # end


        # repel forces for all pairs that are not covers
        for i = 1:n-1
            for j = i+1:n
                u = bj[i]
                v = bj[j]
                if !has(G, u, v)
                    d = dist2(x[i], y[i], x[j], y[j])
                    nrg += n/d
                end
            end
        end


        return nrg
    end





    #@show energy(x0)

    result = optimize(energy, x0, iterations = 100_000)
    # @show result

    #@show minimum(result)

    x = Optim.minimizer(result)

    # convert to xy dictionary
    newxy = Dict{T,Vector{Float64}}()
    for k = 1:n
        v = bj[k]
        newxy[v] = [x[k]; y[k]]
    end

    return newxy, minimum(result)
end


function dist2(x1, y1, x2, y2)
    return (x1 - x2)^2 + (y1 - y2)^2
end
