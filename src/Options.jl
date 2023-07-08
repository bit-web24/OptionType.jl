module Options

export Option, None, Some, isempty, get, map, and_then, or_else

struct Option{T}
    value::Union{T, Nothing}
end

const None = Option{Any}(nothing)

function Some(x::T) where {T}
    Option(x)
end

# Function to check if an option is empty
function isempty(option::Option)
    option.value === nothing
end

# Function to get the value of an Option or return a default value
function get(option::Option{T}, default::T) where {T}
    isempty(option) ? default : option.value
end

# Function to get the value of an Option or panic with a custom error message
function get(option::Option{T}, error_message::AbstractString) where {T}
    isempty(option) ? error(error_message) : option.value
end

# Function to transform an Option using a provided function
function map(f::Function, option::Option)
    isempty(option) ? None : Some(f(option.value))
end

# Function to apply a function to an Option, returning the result or a default value
function and_then(option::Option, f::Function, default::Any)
    isempty(option) ? default : f(option.value)
end

# Function to apply a function to an Option, returning the result or a provided Option
function and_then(option::Option, f::Function, default::Option)
    isempty(option) ? default : f(option.value)
end

# Function to apply a function to an Option, returning the result or None
function and_then(option::Option, f::Function)
    and_then(option, f, None)
end

# Function to apply a function to an Option, returning the result or None
function or_else(option::Option, f::Function)
    isempty(option) ? f() : option.value
end

end
