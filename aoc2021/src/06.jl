function solve1(nums)
    for _ in 1:80, i in 1:length(nums)
        if nums[i] == 0
            nums[i] = 6
            push!(nums, 8)
        else
            nums[i] -= 1
        end
    end
    return length(nums)
end

function solve2(nums)
    ## Initialize
    fish = zeros(Int128, 9)
    for n in nums
        fish[n+1] += 1
    end
    ## "simulate"
    for _ in 1:256
        temp = fish[1]
        for i in 1:8
            fish[i] = fish[i+1]
        end
        fish[9] = temp   # new fish
        fish[7] += temp  # reset fish
    end
    return sum(fish)
end

function main()
    path = abspath(joinpath(@__DIR__, "..", "data/", "06.in"))
    input = parse.(Int, split(readline(path), ","))
    solve1(input) |> println
    solve2(input) |> println
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
