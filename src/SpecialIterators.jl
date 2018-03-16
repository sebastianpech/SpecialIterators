module SpecialIterators

import Base:start,next,done,iteratorsize,iteratoreltype,eltype,length,size

export ziperate

struct Ziperate{I,N}
    itr::Vector{I}
    len::Int
    function Ziperate(itr::Vector{I},nth::Int) where I
        # Get the maximum length and round it up to not loose information
        len = maximum([length(l) for l in itr])
        new{I,length(itr)}(itr,len)
    end
end

ziperate(itr::I) where I = Ziperate(itr,1)

function done(z::Ziperate,state)
    for i in state
        if i > z.len
            return true
        end
    end
    return false
end

start(::Ziperate{I,N}) where {I,N} = ones(Int,N)

function next(z::Ziperate{I},state) where I
    ret = Vector{eltype(I)}()
    sizehint!(ret,length(z.itr))
    for (i,v) in enumerate(z.itr)
        if done(v,state[i])
            push!(ret,v[end])
        else
            _next,state[i] = next(v,state[i])
            push!(ret,_next)
        end
    end
    return ret,state
end

length(z::Ziperate) = z.len

size(z::Ziperate{I,N}) where {I,N} = (length(z),N)

eltype(::Type(Ziperate{I,N})) where {I,N} = I

end
