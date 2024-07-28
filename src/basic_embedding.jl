export basic_embedding

"""
    basic_embedding(P::SimplePoset{T})::Dict{T, Vector{Float64}} where T

Create a basic embedding for `P`.
"""
function basic_embedding(P::SimplePoset{T})::Dict{T,Vector{Float64}} where {T}
    PP = deepcopy(P)
    d = Dict{T,Vector{Float64}}()
    y = 0
    while card(PP) > 0
        y += 1
        bot = minimals(PP)
        nbot = length(bot)  # number of minimals
        for j = 1:nbot
            x = j - nbot / 2 - 0.5
            v = bot[j]
            d[v] = [x, y]
            delete!(PP, v)
        end
    end
    return d
end