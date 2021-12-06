let A = parse.(Int, readlines())
    # Part 1
    println(count(>(0), diff(A)))
    # Part 2
    println(count(A[i-3] < A[i] for i in 4:length(A)))
end

println(count(>(0), diff(parse.(Int, eachline()))))
