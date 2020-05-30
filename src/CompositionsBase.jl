module CompositionsBase

# Use README as the docstring of the module:
@doc let path = joinpath(dirname(@__DIR__), "README.md")
    include_dependency(path)
    replace(read(path, String), r"^```julia"m => "```jldoctest README")
end CompositionsBase

if !isdefined(Base, Symbol("@var_str"))
    macro var_str(x)
        return Symbol(x)
    end
end

const compose = ∘

# Since `⨟` may not be rendered correctly in all environments, let's
# use ASCII version as the definition and then `⨟` as an alias.  This
# is not symmetric with how `compose` is defined but appropriately
# "opposite."
opcompose(fs...) = ∘(reverse(fs)...)
const var"⨟" = opcompose

"""
    g ⨟ f
    opcompose(g, f)

The opposite composition operator defined as

    g ⨟ f = f ∘ g
    ⨟(f) = f
    ⨟(fs...) = ∘(reverse(fs)...)
"""
(var"⨟", opcompose)

export ∘, compose, opcompose
@eval export $(Symbol("⨟"))  # for Julia 1.0

end # module
