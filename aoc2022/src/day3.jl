using .Iterators

const test = """
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
"""

function problem1(path)
    common_items = flatten([(l=length(line); intersect(line[1:(l÷2)], line[(l÷2)+1:end])) for line in eachline(path)])
    sum(Int, [islowercase(x) ? (x - 0x60) : (x - 0x26) for x in xs])
end

function problem2(path)
    groups = reshape(readlines(path), 3, :)
    common_items = flatten([intersect(xs[:, i]...) for i in 1:size(xs, 2)])
    sum(Int, [islowercase(x) ? (x - 0x60) : (x - 0x26) for x in xs])
end

quote
    using Revise
    day = "day3"
    includet("src/$day.jl")
    path = joinpath(@__DIR__, "data/$day.in")

    problem1(IOBuffer(test))
    problem1(path)

    problem2(IOBuffer(test))
    problem2(path)
end

