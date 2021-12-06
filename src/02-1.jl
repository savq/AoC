moves = Dict("forward" => 1, "up" => -1im, "down" => 1im)
pos = sum(map(x -> parse(Int, x[2])*moves[x[1]], split.(eachline())))
println(pos.re * pos.im)
