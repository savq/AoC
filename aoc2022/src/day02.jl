@enum Rpc rock paper scissors

const LOSE, DRAW, WIN = 0, 3, 6

shape_score(x::Rpc) = Int(x) + 1
shape_score(x) = x + 1

function play(opp::Rpc, me::Rpc)
    if opp == me
        DRAW
    elseif mod(Int(x) - 1, 3) == Int(y)
        LOSE
    else
        WIN
    end
end

draw(x::Rpc) = shape_score(x) + DRAW
lose(x::Rpc) = shape_score(mod(Int(x) - 1, 3)) + LOSE
win(x::Rpc) = shape_score(mod(Int(x) + 1, 3)) + WIN

function getshape(letter)
    if letter == "A" || letter == "X"
        rock
    elseif letter == "B" || letter == "Y"
        paper
    elseif letter == "C" || letter == "Z"
        scissors
    end
end

function getplay(letter, opponent::Rpc)
    if letter == "X"
        lose(opponent)
    elseif letter == "Y"
        draw(opponent)
    elseif letter == "Z"
        win(opponent)
    end
end

function problem1(path)
    sum(readlines(path)) do line
        opponent, me = getshape.(split(line))
        play(opponent, me) + shape_score(me)
    end
end

function problem2(path)
    sum(readlines(path)) do line
        opponent_str, me_str = split(line)
        getplay(me_str, getshape(opponent_str))
    end
end

quote
    using Revise
    day = "day2"
    includet("src/$day.jl")
    path = joinpath(@__DIR__, "data/$day.in")
    problem1(path)
    problem2(path)
end

