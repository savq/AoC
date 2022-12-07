const test = """
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
"""

function parse_crates(path)
    lines = eachline(path; keep=true)
    len = length(first(lines))

    lines = eachline(path; keep=true)
    # seek(path, 0) # FIXME: needed if path is IOBuffer

    # Create the appropiate number of stacks
    stacks = Vector[Char[] for x in 1:(len ÷ 4)]

    # Read the stacks
    for line in lines
        line == "\n" && break
        i = 1
        for j in 2:4:len
            isletter(line[j]) && push!(stacks[i], line[j])
            i += 1
        end
    end

    # Read moves
    moves = map(lines) do line
        parse.(Int, match(r"move (\d+) from (\d+) to (\d+)", line).captures)
    end

    return reverse.(stacks), moves
end

function restack!(stacks, moves)
    for (n, c1, c2) in moves
        for _ in 1:n
            push!(stacks[c2], pop!(stacks[c1]))
        end
    end
end

function restack2!(stacks, moves)
    for (n, c1, c2) in moves
        len = length(stacks[c1])
        append!(stacks[c2], splice!(stacks[c1], (len-n+1):len))
    end
end

function main(path)
    stacks, moves = parse_crates(path)

    stacks1 = deepcopy(stacks)
    restack!(stacks1, moves)
    println(join(pop!(s) for s in stacks1))

    stacks2 = deepcopy(stacks)
    restack2!(stacks2, moves)
    println(join(pop!(s) for s in stacks2))
end


quote
    using Revise; includet("src/day5.jl")
end
