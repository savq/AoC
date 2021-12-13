# TODO: organize

sortstr(s) = String(sort(codeunits(s))) # m.d. failing here?
arr2num(d::AbstractArray) = sum(reverse(d) .* 10 .^ (0:(length(d)-1))) # big-endian

function find_signal_wires(signal_patterns)
    d = Dict()
    for pat in signal_patterns
        l = length(pat)
        if l == 2;     d[1] = pat
        elseif l == 4; d[4] = pat
        elseif l == 3; d[7] = pat
        elseif l == 7; d[8] = pat
        end
    end

    seg5 = filter(s -> length(s) == 5, signal_patterns)
    seg6 = filter(s -> length(s) == 6, signal_patterns)

    d[3] = filter(x -> x ⊇ d[7], seg5)[1]
    d[9] = filter(x -> x ⊇ d[3], seg6)[1]
    d[2] = filter(x -> x ⊈ d[9], seg5)[1]
    d[5] = filter(x -> x ⊆ d[9] && x != d[3], seg5)[1]
    d[6] = filter(x -> x ⊇ d[5] && x != d[9], seg6)[1]
    d[0] = setdiff(signal_patterns, values(d))[1]

    Dict(sortstr(v) => k for (k,v) in d)
end

decode(outputs, wires) = [wires[o] for o in outputs]

function parse_line(line)
    instr, outstr = split(line, "|")
    sortstr.(split(instr)), sortstr.(split(outstr))
end


function solve2(lines)
    s = 0
    for line in lines
        signal_patterns, output_values = parse_line(line)
        wires = find_signal_wires(signal_patterns)
        dec = decode(output_values, wires)
        s += arr2num(dec)
    end
    s
end

function solve1(lines)
    s = 0
    for line in lines
        _, output = split(line, "|")
        lengths = length.(split(output))
        s += count(lengths) do x
            x == 2 || x == 4 || x == 3 || x == 7
        end
    end
    s
end

function main()
    path = abspath(joinpath(@__DIR__, "..", "data/", "08.in"))
    input = readlines(path)
    solve1(input) |> println
    solve2(input) |> println
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
