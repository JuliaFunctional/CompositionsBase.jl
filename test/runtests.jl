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

@testset "all derived from ∘" begin
    @test compose === ∘
    @test var"⨟" === opcompose

    struct FreeMagma
        word
    end
    Base.:(∘)(a::FreeMagma, b::FreeMagma) = FreeMagma((a.word, b.word))
    FM = FreeMagma
    @test opcompose(FM(1), FM(2)) === compose(FM(2), FM(1)) === FM((2,1))
    @test opcompose(FM(1), FM(2), FM(3)) === compose(FM(3), FM(2), FM(1)) === FM(((3,2),1))
    @test_throws MethodError opcompose()
    @test_throws MethodError compose()
end

end  # module
