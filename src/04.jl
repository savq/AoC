parse_nums(str) = parse.(Int, split(str, ","))

parse_board(rows) = hcat([parse.(Int, split(row)) for row in rows]...)

function read_input(path)
    input = readlines(path)
    nums = parse_nums(input[1])
    boards = [parse_board(input[i:(i+4)]) for i in 3:6:length(input)]
    return boards, nums
end

play!(board, n) = map!(x -> if x == n; -1 else x end, board, board)

function bingo(board)
    count(==(-5), sum(board, dims=1)) >= 1 ||
    count(==(-5), sum(board, dims=2)) >= 1
end

function solve1(boards, nums)
    for num in nums, board in boards
        play!(board, num)
        if bingo(board)
            score = sum(filter(>(-1), board)) * num
            return score
        end
    end
end

function solve2(boards, nums)
    score = 0
    solved = zeros(Bool, length(boards))
    for num in nums, i in 1:length(boards)
        play!(boards[i], num)
        if !solved[i] && bingo(boards[i])
            ## this board might be the last to win
            score = sum(filter(>(-1), boards[i])) * num
            ## mark board so it's not played anymore
            solved[i] = true
        end
    end
    return score
end

function main()
    path = abspath(joinpath(@__DIR__, "..", "data/", "04.in"))
    board, nums = read_input(path)
    solve1(board, nums) |> println
    solve2(board, nums) |> println
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
