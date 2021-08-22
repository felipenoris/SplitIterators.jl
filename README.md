# SplitIterators.jl

[![License][license-img]](LICENSE)
[![CI][ci-img]][ci-url]
[![codecov][codecov-img]][codecov-url]

[license-img]: http://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat-square
[ci-img]: https://github.com/felipenoris/SplitIterators.jl/workflows/CI/badge.svg
[ci-url]: https://github.com/felipenoris/SplitIterators.jl/actions?query=workflow%3ACI
[codecov-img]: https://img.shields.io/codecov/c/github/felipenoris/SplitIterators.jl/master.svg?label=codecov&style=flat-square
[codecov-url]: http://codecov.io/github/felipenoris/SplitIterators.jl?branch=master

This package provides a `split` function for iterators.

```julia
    split(iterator, parts_count)

Splits an iterator into at most `parts_count` partitions with almost the same size.
```