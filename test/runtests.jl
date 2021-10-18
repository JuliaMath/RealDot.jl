using RealDot
using LinearAlgebra
using Test

# struct need to be defined outside of tests for julia 1.0 compat
# custom complex number (tests fallback definition)
struct CustomComplex{T} <: Number
    re::T
    im::T
end

Base.real(x::CustomComplex) = x.re
Base.imag(x::CustomComplex) = x.im

Base.conj(x::CustomComplex) = CustomComplex(x.re, -x.im)

function Base.:*(x::CustomComplex, y::Union{Real,Complex})
    return CustomComplex(reim(Complex(reim(x)...) * y)...)
end
Base.:*(x::Union{Real,Complex}, y::CustomComplex) = y * x
function Base.:*(x::CustomComplex, y::CustomComplex)
    return CustomComplex(reim(Complex(reim(x)...) * Complex(reim(y)...))...)
end

# custom quaternion to test definition for hypercomplex numbers
# adapted from Quaternions.jl
struct Quaternion{T<:Real} <: Number
    s::T
    v1::T
    v2::T
    v3::T
end

Base.real(q::Quaternion) = q.s
Base.conj(q::Quaternion) = Quaternion(q.s, -q.v1, -q.v2, -q.v3)

function Base.:*(q::Quaternion, w::Quaternion)
    return Quaternion(
        q.s * w.s - q.v1 * w.v1 - q.v2 * w.v2 - q.v3 * w.v3,
        q.s * w.v1 + q.v1 * w.s + q.v2 * w.v3 - q.v3 * w.v2,
        q.s * w.v2 - q.v1 * w.v3 + q.v2 * w.s + q.v3 * w.v1,
        q.s * w.v3 + q.v1 * w.v2 - q.v2 * w.v1 + q.v3 * w.s,
    )
end

function Base.:*(q::Quaternion, w::Union{Real,Complex,CustomComplex})
    a, b = reim(w)
    return q * Quaternion(a, b, zero(a), zero(a))
end
Base.:*(w::Union{Real,Complex,CustomComplex}, q::Quaternion) = conj(conj(q) * conj(w))

@testset "RealDot.jl" begin
    scalars = (
        randn(), randn(ComplexF64), CustomComplex(randn(2)...), Quaternion(randn(4)...)
    )
    arrays = (randn(10), randn(ComplexF64, 10))

    for inputs in (scalars, arrays)
        for x in inputs, y in inputs
            @test realdot(x, y) == real(dot(x, y))
        end
    end
end
