function read_input(path)
    pad = length(readline(path))
    BitArray.(digits.(parse.(UInt, readlines(path); base=2); base=2, pad=pad))
end

bitvec2int(bitarr) = reduce((n, b) -> (n << 1) + b, bitarr; init=0)

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
        # @show l
        if l == 1
            break
        end
        cbit = commonbit(bitstrings, d; co2=co2)  # find the most common digit
        # @show cbit
        invalid = zeros(Bool, l)
        
        for j in 1:l # for each bitstring
            # @show bitstrings[j][d]
            if bitstrings[j][d] ≠ cbit
                invalid[j] = true  # mark it as invalid
                # @show invalid
                if count(invalid) ≥ l-1  # if there's only one bitstring, we're done
                    break
                end
            end
        end
        deleteat!(bitstrings, invalid)
        # @show bitstrings
    end
    bitstrings
end

function solve2(input)
    o2 = find_ratings(reverse.(input))
    co2 = find_ratings(reverse.(input), co2=true)
    @show bitvec2int(o2[1])
    @show bitvec2int(co2[1])
    @show bitvec2int(o2[1]) * bitvec2int(co2[1])
end

read_input("inputs/day3.input2") |> solve2

