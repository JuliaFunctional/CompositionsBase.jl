module TestCompositionsBase
import Compat
using CompositionsBase
using CompositionsBase: @var_str
using Test

@testset "binary" begin
    @test tuple ∘ inv ===
          compose(tuple, inv) ===
          var"⨟"(inv, tuple) ===
          opcompose(inv, tuple)
end

@testset "unary" begin
    @test ∘(tuple) === compose(tuple) === var"⨟"(tuple) === opcompose(tuple) === tuple
end

if VERSION >= v"1.5.0-DEV.302"  # for ⨟
    include("test_julia15.jl")
end

end  # module
