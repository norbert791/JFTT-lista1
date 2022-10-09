

function finite_automation_matcher(sentence, pattern, transition_function)
    m = length(pattern)
    n = length(sentence)
    q = 0
    result = []
    for i in 1:n
        q = transition_function(q, sentence[i])
        if q == m
            s = i - m
            push!(result, s)
        end
    end      
    return result
end

#For given pattern and alphabet compute transition function value for each state q and input a.
function compute_transition_function(pattern, alphabet = map(x -> Char(x), 0:127))
    m = length(pattern)
    result_map = Dict()
    for q in 0:m
        for character in alphabet
            k = min(m, q + 1)
            while (!endswith(pattern[1:q] * character, pattern[1:k]))
                k = k - 1
            end
            result_map[(q, character)] = k
        end
    end
    return (q, a) -> result_map[(q, a)]
end

function main()
    pattern = ARGS[1]
    text = ""
    text = open(ARGS[2]) do file
        read(file, String)
    end
    result = finite_automation_matcher(text, pattern, compute_transition_function(pattern))
    println("Wzorzec występuje z przesunięciami:")
    for r in result
        print(string(r) * ' ')
    end
    println("")
end

main()