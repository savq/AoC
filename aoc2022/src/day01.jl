function nmaximum(vec::Vector{T}, n) where {T <: Number}
    xs = repeat([typemin(T)], n)
    for val in vec
        for (i, x) in enumerate(xs)
            if val > x
                xs[(i+1):n] = xs[i:(n-1)]
                xs[i] = val
                break
            end
        end
    end
    return xs
end

function main(path)
    calories = 0
    elfs = Int[]
    for line in readlines(path)
        if line == ""
            # Done reading an elfs inventory. Append sum to vector
            append!(elfs, calories)
            calories = 0
        else
            calories += parse(Int, line)
        end
    end

    # Find the Elf carrying the most Calories.
    # How many total Calories is that Elf carrying?
    ans1 = maximum(elfs)

    # Find the top three Elves carrying the most Calories.
    # How many Calories are those Elves carrying in total?
    ans2 = sum(nmaximum(elfs, 3))

    return ans1, ans2
end

quote
    using Revise
    day = "day1"
    includet("src/$day.jl")
    path = joinpath(@__DIR__, "data/$day.in")
    main(path)
end
