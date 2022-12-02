function solve1(input)
    moves = Dict("forward" => 1, "up" => -1im, "down" => 1im)
    pos = sum(map(x -> parse(Int, x[2])*moves[x[1]], split.(input)))
    pos.re * pos.im
end

function solve2(input)
    d, h, aim = 0, 0, 0
    for (move, xstr) in split.(input)
        x = parse(Int, xstr)
        if move == "down"
            aim += x
        elseif move == "up"
            aim -= x
        else
            h += x
            d += x * aim
        end
    end
    d * h
end

function main()
    path = abspath(joinpath(@__DIR__, "..", "data/", "02.in"))
    input = readlines(path)
    println(solve1(input))
    println(solve2(input))
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
