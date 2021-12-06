parse_nums(str) = parse.(Int, split(str, ","))

parse_board(rows) = hcat([parse.(Int, split(row)) for row in rows]...)

function read_input(path)
    input = readlines(path)
    nums = parse_nums(input[1])
    boards = [parse_board(input[i:(i+4)]) for i in 3:6:length(input)]
    boards, nums
end

function bingo(b)
    count(==(-5), sum(b, dims=1)) >= 1 ||
    count(==(-5), sum(b, dims=2)) >= 1
end

function solve1(boards, nums)
    for num in nums
        ## 1. play boards
        for board in boards
            map!(x -> if x == num; -1 else x end, board, board)
        end
        ## 2. check boards
        for board in boards
            if bingo(board)
                ## 3. calculate score
                return sum(filter(>(-1), board)) * num
            end
        end
    end
end

## TODO:
function solve2(boards, nums)
    likely_solve = 0
    for num in nums
        ## 1. play boards
        for board in boards
            map!(x -> if x == num; -1 else x end, board, board)
        end
        solved_boards = zeros(Bool, length(boards))
        ## 2. check boards
        @show length(boards)
        for i in 1:length(boards)
            if bingo(boards[i])
                ## this might be the last board that wins
                likely_solve = sum(filter(>(-1), boards[i])) * num
                ## mark it so it's not played anymore
                solved_boards[i] = true
                @show num
                @show i
                @show likely_solve
            end
        end
        deleteat!(boards, solved_boards)
    end
    return likely_solve
end

function main()
    path = abspath(joinpath(@__DIR__, "..", "data/", "04.in"))
    board, nums = read_input(path)
    solve1(board, nums) |> println
    # solve2(board, nums) |> println
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
