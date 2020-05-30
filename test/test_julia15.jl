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

end  # module
