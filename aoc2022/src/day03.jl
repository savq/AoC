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
    sum(eachline(path)) do line
        half = length(line) ÷ 2
        item = intersect(line[1:half], line[half+1:end])[1]
        Int(item - (islowercase(item) ? 0x60 : 0x26))
    end
end

function problem2(path)
    groups = reshape(readlines(path), 3, :)
    common_items = flatten([intersect(col...) for col in eachcol(groups)])
    sum(Int, [item - (islowercase(item) ? 0x60 : 0x26) for item in common_items])
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

