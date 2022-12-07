quote
    day = "day7"
    path = joinpath(@__DIR__, "data/$day.in")
    using Revise; includet("src/$day.jl")
    main()
end

struct File
    size::Int
end

mutable struct Dir
    files::Dict{String, Union{File, Dir}}
    parent::Union{Dir, Nothing}
end

Dir(parent=nothing) = Dir(Dict{String, Union{File, Dir}}(), parent)

function main()
    # fs = parse_fs(IOBuffer(sample))
    fs = parse_fs(path)

    used, small_dirs = problem(fs)

    println("problem 1: ", sum(small_dirs))

    _, possible_deleted = problem(fs; limit=typemax(Int))

    available = 70000000
    unused = available - used
    needed = 30000000 - unused

    for x in sort(possible_deleted)
        if x >= needed
            println("problem 2: ", x)
            break
        end
    end
end


problem(file::File, small; limit=0) = file.size

function problem(dir::Dir, small_dirs=[]; limit=100_000)
    size = sum(dir.files) do (name, file)
        problem(file, small_dirs; limit)[1]
    end

    size < limit && push!(small_dirs, size)

    return size, small_dirs
end

function parse_fs(path)
    root = Dir()
    cwd = root
    for line in eachline(path)
        if startswith(line, "\$") 
            cmd = split(line)
            len = length(cmd)
            if len == 3
                target = cmd[3]
                cwd =
                    if target == "/"
                        root
                    elseif target == ".."
                        cwd.parent
                    else
                        cwd.files[target]
                    end
            end
        elseif startswith(line, "dir")
            name = String(first(match(r"dir ([\w\.]+)", line).captures))
            cwd.files[name] = Dir(cwd)
        else
            size_str, name = String.(match(r"(\d+) ([\w\.]+)", line).captures)
            size = parse(Int, size_str)
            cwd.files[name] = File(size)
        end
    end

    return root
end


function pretty_print(dir, depth=0)
    for (name, file) in dir.files
        println("  "^depth * string(file.size), " ", name)
        if file isa Dir
            pretty_print(file, depth+1)
        end
    end
end

const sample = raw"""
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
"""
