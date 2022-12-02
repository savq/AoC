function read_input(path)
    lines = readlines(path)
    [parse(Int, lines[i][j]) for i in 1:length(lines), j in 1:length(lines[1])]
end


function islowpoint(m, i, j)
    h, w = size(m)
    p = true
    # check left
    if i > 1
        p &= m[i-1, j] > m[i, j]
    end
    # check right
    if i < h
        p &= m[i, j] < m[i+1, j]
    end
    # check up
    if j > 1
        p &= m[i, j-1] > m[i, j]
    end
    # check down
    if j < w
        p &= m[i, j] < m[i, j+1]
    end
    return p
end

function solve1(heightmap)
    h, w = size(heightmap)
    s = 0
    for i in 1:h, j in 1:w
        if islowpoint(heightmap, i, j)
            s += heightmap[i, j] + 1
        end
    end
    s
end

function visit!(b, m, i, j, s=0)
    h, w = size(m)
    if b[i, j] || m[i, j] == 9
        return 0
    else
        b[i, j] = true
    end
    # visit left
    if i > 1
        s += visit!(b, m, i-1, j)
    end
    # check right
    if i < h
        s += visit!(b, m, i+1, j)
    end
    # check up
    if j > 1
        s += visit!(b, m, i, j-1)
    end
    # check down
    if j < w
        s += visit!(b, m, i, j+1)
    end
    return s + 1
end

function solve2(heightmap)
    h, w = size(heightmap)
    visited  = zeros(Bool, h, w)

    basin_sizes = Int[]
    for i in 1:h, j in 1:w
        if (s = visit!(visited, heightmap, i, j)) != 0
            push!(basin_sizes, s)
        end
    end
    reduce(*, last(sort(basin_sizes), 3))
end

function main()
    path = abspath(joinpath(@__DIR__, "..", "data/", "09.in"))
    input = read_input(path)
    solve1(input) |> println
    solve2(input) |> println
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
