function main_readlines(input)
    d = 0
    h = 0
    aim = 0
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

readlines() |> main |> println
