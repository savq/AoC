solve1(A) = count(>(0), diff(A))

solve2(A) = count(A[i-3] < A[i] for i in 4:length(A))

function main()
    path = abspath(joinpath(@__DIR__, "..", "data/", "01.in"))
    A = parse.(Int, readlines(path))
    println(solve1(A))
    println(solve2(A))
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
