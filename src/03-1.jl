function read_input(path)
    pad = length(readline(path))
    BitArray.(digits.(parse.(UInt, readlines(path); base=2); base=2, pad=pad))
end

bitvec2int(bitarr) = reduce((n, b) -> (n << 1) + b, bitarr; init=0)

commonbits(M) = [x >= size(M, 2) ÷ 2 for x in sum(M, dims=2)]
# commonbits(M) = sum(M, dims=2) .>= size(M, 2) ÷ 2

function solve1(input)
    M = hcat(input...)
    common = commonbits(M)
    γ = bitvec2int(common)
    ε = bitvec2int(.!common)
    γ * ε
end

read_input("inputs/day3.input1") |> solve2
