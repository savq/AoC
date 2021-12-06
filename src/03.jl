function read_input(path)
    pad = length(readline(path))
    BitArray.(digits.(parse.(UInt, readlines(path); base=2); base=2, pad=pad))
end

bitvec2int(bitarr) = reduce((n, b) -> (n << 1) + b, bitarr; init=0)

commonbits(M) = sum(M, dims=2) .> size(M, 2) ÷ 2

function solve1(input)
    M = hcat(input...)
    common = reverse(commonbits(M))
    γ = bitvec2int(common)
    ε = bitvec2int(.!common)
    γ * ε
end

function commonbit(vecs, i; co2=false)
    s = 0
    for vec in vecs
        s += vec[i]
    end
    if co2
        s < ceil(length(vecs) / 2)
    else
        s ≥ ceil(length(vecs) / 2)
    end
end

function find_ratings(bitstrings; co2=false)
    for d in 1:length(bitstrings[1])  # for each digit position
        l = length(bitstrings)
        l == 1 && break
        cbit = commonbit(bitstrings, d; co2=co2)  # find the most common digit
        invalid = zeros(Bool, l)
        for j in 1:l # for each bitstring
            if bitstrings[j][d] ≠ cbit
                invalid[j] = true  # mark it as invalid
                if count(invalid) ≥ l-1  # if there's only one bitstring, we're done
                    break
                end
            end
        end
        deleteat!(bitstrings, invalid)
    end
    bitstrings
end

function solve2(input)
    o2 = bitvec2int(find_ratings(reverse.(input))[1])
    co2 = bitvec2int(find_ratings(reverse.(input), co2=true)[1])
    o2 * co2
end

function main()
    path = abspath(joinpath(@__DIR__, "..", "data/", "03.in"))
    input = read_input(path)
    # solve1(input) |> println
    solve2(input) |> println
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
