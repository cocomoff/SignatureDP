# -*- coding: utf-8 -*-

function dp_show(A)
    display(A); println()
end


α = Set{Symbol}[
    Set([:a, :b]),
    Set([:a, :b, :c]),
    Set([:a, :c, :d]),
    Set([:a, :b, :d])
]
k = 3
n = length(α)

@show α

# DP Table
A = Array{Set{Symbol}, 2}(undef, k, n)
for i in 1:k, j in 1:n
    A[i, j] = Set([])
end

# DP
A[1, 1] = α[1]
for i in 2:n
    A[1, i] = union(α[i], A[1, i - 1])
end
for s in 2:k
    for i in s:n
        Sig = Set{Set{Symbol}}([])
        # println("$s $i")
        for j in s:i
            # println("> $j $(A[s-1, j-1])")
            αji = α[j]
            for l in j:i
                union!(αji, α[l])
            end
            # println("> consider : α[$j,$i] = $(αji)")
            isαA = intersect(αji, A[s-1, j-1])
            # println("> intersect: $isαA")
            push!(Sig, isαA)
        end
        store = Set{Symbol}([:a, :b, :c, :d])
        for s in Sig
            # union!(store, s)
            intersect!(store, s)
        end
        # println("$s $i: $Sig $store")
        A[s, i] = store
    end
end


dp_show(A)