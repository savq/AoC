const open2close = Dict(
    '(' => ')',
    '[' => ']',
    '{' => '}',
    '<' => '>',
)

const close2open = Dict(v => k for (k, v) in open2close)

const syn_scores = Dict(
    ')' => 3,
    ']' => 57,
    '}' => 1197,
    '>' => 25137,
)

const compl_scores = Dict(
    ')' => 1,
    ']' => 2,
    '}' => 3,
    '>' => 4,
)

function solve2(lines)
    scores = []
    for line in lines
        st = []
        corrupt = false
        for char in line
            if char in keys(open2close)
                push!(st, char)
            elseif close2open[char] != pop!(st)
                corrupt = true
                break
            end
        end
        if !corrupt
            complement = [open2close[x] for x in reverse(st)]
            score = 0
            for c in complement
                score = muladd(score, 5, compl_scores[c])
            end
            push!(scores, score)
        end
    end
    sort(scores)[length(scores) ÷ 2 + 1]
end

function solve1(lines)
    score = 0
    for line in lines
        st = []
        for char in line
            if char in keys(open2close)
                push!(st, char)
            elseif close2open[char] != pop!(st)
                ## line is corrupt
                score += syn_scores[char]
                break
            end
        end
    end
    return score
end

function main()
    path = abspath(joinpath(@__DIR__, "..", "data/", "10.in"))
    input = readlines(path)
    solve1(input)
    solve2(input)
end
