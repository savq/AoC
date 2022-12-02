function solve1(positions)
    minimum(sum(abs.(positions .- i)) for i in UnitRange(extrema(positions)...))
end

"Calculate the “crab” distance between two points on the number line"
crabdist(p, q) = sum(1:abs(p - q))

function solve2(positions)
    minimum(sum(crabdist.(positions, i)) for i in UnitRange(extrema(positions)...))
end

function main()
    path = abspath(joinpath(@__DIR__, "..", "data/", "07.in"))
    input = parse.(Int, split(readline(path), ","))
    solve1(input) |> println
    solve2(input) |> println
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
