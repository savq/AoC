
const sample = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"

function day6(buffer, n=4)
    for i in n:length(buffer)
        # diff = true
        # itr = enumerate(@view buffer[(i-n+1):i])
        # for (j, c1) in itr, (k, c2) in itr
        #     if c1 == c2 && j != k
        #         diff = false
        #         break
        #     end
        # end
        # diff && return i
        ## Alternatively:
        allunique(buffer[(i-n+1):i]) && return i
    end
end

