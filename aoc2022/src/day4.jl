const test = """
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
"""

function problem1(path)
    sum(eachline(path)) do line
        sections = parse.(Int, split(line, r"[,-]"))
        r1 = range(sections[1:2]...)
        r2 = range(sections[3:4]...)
        (r1 ⊆ r2) || (r1 ⊇ r2)
    end
end

function problem2(path)
    sum(eachline(path)) do line
        sections = parse.(Int, split(line, r"[,-]"))
        r1 = range(sections[1:2]...)
        r2 = range(sections[3:4]...)
        !isempty(r1 ∩ r2)
    end
end

quote
    using Revise
    day = "day4"
    path = joinpath(@__DIR__, "data/$day.in")
    includet("src/$day.jl")

    # problem1(IOBuffer(test))
    # problem2(IOBuffer(test))

    problem1(path)
    problem2(path)
end

