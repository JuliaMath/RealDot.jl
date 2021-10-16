# RealDot

[![Build Status](https://github.com/devmotion/RealDot.jl/workflows/CI/badge.svg?branch=main)](https://github.com/devmotion/RealDot.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/devmotion/RealDot.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/devmotion/RealDot.jl)
[![Coverage](https://coveralls.io/repos/github/devmotion/RealDot.jl/badge.svg?branch=main)](https://coveralls.io/github/devmotion/RealDot.jl?branch=main)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)

This package only contains and exports a single function `realdot(x, y)`. It computes
`real(LinearAlgebra.dot(x, y))` while avoiding computing the imaginary part of
`LinearAlgebra.dot((x, y)` if possible.

This function can be useful e.g. if you define pullbacks for non-holomorphic functions
(see e.g. [this discussion in the ChainRulesCore.jl repo](https://github.com/JuliaDiff/ChainRulesCore.jl/pull/474)). It was implemented initially in [ChainRules.jl](https://github.com/JuliaDiff/ChainRules.jl) in [this PR](https://github.com/JuliaDiff/ChainRules.jl/pull/216) as `_realconjtimes`.
