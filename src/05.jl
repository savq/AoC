struct Line{N <: Integer}
    x1::N
    y1::N
    x2::N
    y2::N
end

function read_input(path)
    ## add one so I don't have to deal with 0-index problems
    [Line((parse.(Int, match(r"(\d+),(\d+) -> (\d+),(\d+)", i).captures) .+ 1)...) for i in eachline(path)]
end

function find_dims(lines)
    w, h = 0, 0
    for line in lines
        w =  max(line.x1, line.x2, w)
        h =  max(line.y1, line.y2, h)
    end
    w, h
end

function solve1(lines)
    w, h = find_dims(lines)
    M = zeros(Int, w, h)
    for line in lines
        @show line
        xl, xr = minmax(line.x1, line.x2)
        yd, yu = minmax(line.y1, line.y2)
        if xl ≠ xr && yd ≠ yu
            continue
        end
        for i in xl:xr, j in yd:yu
            M[i, j] += 1
        end
    end
    count(>=(2), M)
end

function main()
    path = abspath(joinpath(@__DIR__, "..", "data/", "05.in"))
    solve1(read_input(path))
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
