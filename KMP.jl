function compute_prefix_function(pattern)
    m = length(pattern)
    result = zeros(UInt, (m))
    k = 0
    for q in 2:m
        while k > 0 && pattern[k + 1] != pattern[q]
            k = result[k]
        end
        if pattern[k + 1] == pattern[q]
            k = k + 1
        end
        result[q] = k
    end
    return result
end
function kmp_matcher(text, pattern)
    n = length(text)
    m = length(pattern)
    pref = compute_prefix_function(pattern)
    q = 0
    result = []
    for i in 1:n
        while q > 0 && pattern[q + 1] != text[i]
            q = pref[q]
        end
        if pattern[q + 1] == text[i]
            q = q + 1
        end
        if q == m
            push!(result, i - m)
            q = pref[q]
        end
    end
    return result
end

function main()
    pattern = ARGS[1]
    text = ""
    text = open(ARGS[2]) do file
        read(file, String)
    end
    result = kmp_matcher(text, pattern)
    println("Wzorzec występuje z przesunięciami:")
    for r in result
        print(string(r) * ' ')
    end
    println("")
end

main()