"""
    realdot(x, y)

Compute `real(dot(x, y))` while avoiding computing the imaginary part if possible.

This function can be useful if you work with derivatives of functions on complex
numbers. In particular, this computation shows up in pullbacks for non-holomorphic
functions.
"""
@inline realdot(x, y) = real(dot(x, y))
@inline realdot(x::Number, y::Number) = muladd(real(x), real(y), imag(x) * imag(y))
@inline realdot(x::Real, y::Number) = x * real(y)
@inline realdot(x::Number, y::Real) = real(x) * y
@inline realdot(x::Real, y::Real) = x * y
