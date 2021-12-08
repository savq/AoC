using Base.Iterators

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
    return w, h
end

function solve1(lines)
    w, h = find_dims(lines)
    M = zeros(Int, w, h)
    for line in lines
        xl, xr = minmax(line.x1, line.x2)
        yd, yu = minmax(line.y1, line.y2)
        if xl != xr && yd != yu
            continue
        end
        for i in xl:xr, j in yd:yu
            M[i, j] += 1
        end
    end
    return count(>=(2), M)
end

function solve2(lines)
    w, h = find_dims(lines)
    M = zeros(Int, w, h)
    for line in lines
        xrange =
            if line.x1 == line.x2
                cycle(line.x1)
            elseif line.x1 < line.x2
                range(line.x1, line.x2; step=1)
            else
                range(line.x1, line.x2; step=-1)
            end

        yrange =
            if line.y1 == line.y2
                cycle(line.y1)
            elseif line.y1 < line.y2
                range(line.y1, line.y2; step=1)
            else
                range(line.y1, line.y2; step=-1)
            end

        for (i, j) in zip(xrange, yrange)
            M[i, j] += 1
        end
    end
    return count(>=(2), M)
end

function main()
    path = abspath(joinpath(@__DIR__, "..", "data/", "05.in"))
    input = read_input(path)
    solve1(input) |> println
    solve2(input) |> println
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
