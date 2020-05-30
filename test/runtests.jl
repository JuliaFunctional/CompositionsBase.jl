module TestCompositionsBase

using CompositionsBase
using CompositionsBase: @var_str
using Test

@testset "binary" begin
    @test tuple ∘ inv ===
          compose(tuple, inv) ===
          var"⨟"(inv, tuple) ===
          opcompose(inv, tuple)
end

if VERSION >= v"1.5.0-DEV.56"  # TODO: remove this once Compact adds it
@testset "unary" begin
    @test ∘(tuple) === compose(tuple) === var"⨟"(tuple) === opcompose(tuple) === tuple
end
end  # if

if VERSION >= v"1.5.0-DEV.302"  # for ⨟
    include("test_julia15.jl")
end

end  # module
