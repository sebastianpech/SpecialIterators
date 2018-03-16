module SpecialIterators

import Base:start,next,done,iteratorsize,iteratoreltype,eltype,length,size

include("Exterate.jl")
include("Ziperate.jl")

export ziperate,exterate

end
