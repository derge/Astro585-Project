function get_segment(N_good::Int64,N_bad::Int64,idx::Array)
    segment = Any[];
    n = length(idx);
    push!(segment,[idx[1]])
    for i = 1:n-1
        n_seg = length(segment)         # the current length of segment[]
        if (n_seg == 0)
            push!(segment,[idx[i+1]])
        else
            if(idx[i+1] - idx[i] < N_bad)
                append!(segment[n_seg],[idx[i+1]])
            elseif(length(segment[n_seg]) < N_good)
                pop!(segment)
            else
                push!(segment,[idx[i+1]])
            end
        end
    end
    if(length(segment[end]) < N_good)        # check the last element
        pop!(segment)
        end
    return segment
end
