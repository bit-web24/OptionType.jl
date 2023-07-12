# OptionType.jl

[![Build Status](https://github.com/bit-web24/Options.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/bit-web24/Options.jl/actions/workflows/CI.yml?query=branch%3Amain)

OptionType.jl is a Julia package that provides a convenient and flexible way to work with optional values, inspired by Rust's Option type. It offers a set of functions and a custom Option type, allowing you to handle optional values more effectively and write cleaner code.

## Features

- **Option type**: The package defines the `Option{T}` type, which represents an optional value that can either be `Some(value)` or `None`. The `Option{T}` type is generic, allowing you to work with any data type.

- **Functions for option handling**: OptionType.jl provides a collection of functions for working with `Option{T}` values. These functions include `isempty`, `get`, `map`, `and_then`, and `or_else`, allowing you to check for emptiness, retrieve values with fallback options, transform options, and chain operations on options.

## Usage

Here's a quick example to showcase the usage of OptionType.jl:

```julia
using OptionType

x = Some(42)
y = None

println(isempty(x))                 # Output: false
println(get(x, 0))                  # Output: 42
result = and_then(x, val -> val + 1, 0)
println(result)                     # Output: 43
fallback = () -> 100
result = or_else(y, fallback)
println(result)                     # Output: 100
```

## Installation
To install OptionType.jl, you can use the Julia package manager. Open a Julia REPL and run the following command:
```bash
]add OptionType
```

## Contributing
Contributions to OptionType.jl are welcome! If you encounter any issues, have suggestions, or would like to contribute to the project, please create a new issue or submit a pull request on the GitHub repository.

## License
OptionType.jl is released under the MIT License.
