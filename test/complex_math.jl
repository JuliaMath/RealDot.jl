# struct need to be defined outside of tests for julia 1.0 compat
# custom complex number to test fallback definition
struct CustomComplex{T}
    re::T
    im::T
end

Base.real(x::CustomComplex) = x.re
Base.imag(x::CustomComplex) = x.im

function LinearAlgebra.dot(a::CustomComplex, b::Number)
    return CustomComplex(reim((a.re - a.im * im) * b)...)
end
function LinearAlgebra.dot(a::Number, b::CustomComplex)
    return CustomComplex(reim(conj(a) * (b.re + b.im * im))...)
end
function LinearAlgebra.dot(a::CustomComplex, b::CustomComplex)
    return CustomComplex(reim((a.re - a.im * im) * (b.re + b.im * im))...)
end

@testset "complex_math.jl" begin
    @testset "realdot" begin
        scalars = (randn(), randn(ComplexF64), CustomComplex(reim(randn(ComplexF64))...))
        arrays = (randn(10), randn(ComplexF64, 10))
        for inputs in (scalars, arrays)
            for x in inputs, y in inputs
                @test realdot(x, y) == real(dot(x, y))
            end
        end
    end
end
