module TestJulia15

using CompositionsBase
using Documenter: doctest
using Test

@testset "⨟" begin
    @test tuple ∘ inv === inv ⨟ tuple
    @test ⨟(tuple) === opcompose(tuple)
end

@testset "doctest" begin
    doctest(CompositionsBase; manual = false)
end

@testset "all derived from ∘" begin
    @test compose   === (∘)
    @test opcompose === (⨟)
    struct FreeMagma
        word
    end
    FM = FreeMagma
    Base.:(∘)(a::FM, b::FM) = FM((a.word, b.word))
    @test_throws MethodError opcompose()
    @test_throws MethodError compose()
    @test opcompose(FM(1))                      === FM(1)
    @test opcompose(FM(1), FM(2))               === compose(FM(2), FM(1))               === FM((2,1))
    @test opcompose(FM(1), FM(2), FM(3))        === compose(FM(3), FM(2), FM(1))        === FM(((3,2),1))
    @test opcompose(FM(1), FM(2), FM(3), FM(4)) === compose(FM(4), FM(3), FM(2), FM(1)) === FM((((4,3),2),1))
end

@testset "inference" begin
    @inferred opcompose(sin)
    @inferred opcompose(sin, cos)
    @inferred opcompose(sin, cos, tan)
    @inferred opcompose(sin, cos, tan, cot)
    @inferred opcompose(sin, cos, tan, cot, exp)
end

end  # module
