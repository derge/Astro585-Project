function getSegmentIndex(Ngood::Int64, Nbad::Int64,index::Array)
    # Ngood: minimum number of good points in a row
    # Nbad:  number of bad points in a row makes the segment break
    n = length(index)
    segment = Any[]
    push!(segment,[index[1]])
    for i = 1:n-1
        Nseg = length(segment)         # the current length of segment[]
        if (Nseg == 0)
            push!(segment,[index[i+1]])
        else
            if(index[i+1] - index[i] < Nbad)
                append!(segment[Nseg],[index[i+1]])
            elseif(length(segment[Nseg]) < Ngood)
                pop!(segment)
            else
                push!(segment,[index[i+1]])
            end
        end
    end
    if(length(segment[end]) < Ngood)        # check the last element
        pop!(segment)
        end
    return segment
end
