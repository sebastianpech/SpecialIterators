import Base:start,next,done,iteratorsize,iteratoreltype,eltype,length,size

struct Exterate{I}
    itr::I
    len::Int
    function Exterate(itr::I,len::Int) where I
        new{I}(itr,len)
    end
end

exterate(itr::I,len::Int) where I = Exterate(itr,len)

function eltype(::Type{Exterate{I}}) where I
    @show eltype(I)
    eltype(I)
end

done(z::Exterate,state) = state[1] > z.len

_start(itr) = (1,start(itr),start(itr))
start(v::Exterate) = _start(v.itr)

length(z::Exterate) = z.len

@inline function next(z::Exterate{I},state::S)::Tuple{eltype(I),S} where {I,S}
    if done(z.itr,state[2])
        ret = next(z.itr,state[3])
        return ret[1],(state[1]+1,ret[2],state[3])
    end
    ret = next(z.itr,state[2])
    return ret[1],(state[1]+1,ret[2],state[2])
end
