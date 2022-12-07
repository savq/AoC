const test = """
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
"""

function problem1(path)
    count(eachline(path)) do line
        a, b, c, d = parse.(Int, split(line, r"[,-]"))
        r1 = a:b
        r2 = c:d
        (r1 ⊆ r2) || (r1 ⊇ r2)
    end
end

function problem2(path)
    count(eachline(path)) do line
        a, b, c, d = parse.(Int, split(line, r"[,-]"))
        r1 = a:b
        r2 = c:d
        !isdisjoint(r1, r2)
    end
end

quote
    using Revise
    day = "day4"
    path = joinpath(@__DIR__, "data", day)
    includet("src/$day.jl")

    # problem1(IOBuffer(test))
    # problem2(IOBuffer(test))

    problem1(path)
    problem2(path)
end

