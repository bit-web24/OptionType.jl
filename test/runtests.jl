using OptionType
using Test

@testset "Some Tests" begin
    x = OptionType.Some(10)
    y = OptionType.Some("Hello")

    @test OptionType.isempty(x) == false
    @test OptionType.isempty(y) == false

    @test OptionType.get(x, 0) == 10
    @test OptionType.get(y, "Default") == "Hello"
    @test OptionType.get(OptionType.map(x -> x^2, x), 0) == 100
    @test OptionType.get(OptionType.map(s -> uppercase(s), y), "Default") == "HELLO"
end

@testset "None Tests" begin
    n = OptionType.None

    @test OptionType.isempty(n) == true

    @test OptionType.get(n, 0) == 0
    @test OptionType.get(OptionType.map(x -> x^2, n), 0) == 0
end

@testset "and_then Tests" begin
    x = OptionType.Some(5)
    y = OptionType.None

    add_one = x -> x + 1
    double = x -> x * 2

    @test OptionType.and_then(x, add_one, 0) == 6
    @test OptionType.and_then(x, double, 0) == 10
    @test OptionType.and_then(x, add_one, OptionType.None) == 6
    @test OptionType.and_then(x, double, OptionType.None) == 10
    @test OptionType.and_then(y, add_one, 0) == 0
    @test OptionType.and_then(y, double, 0) == 0
    @test OptionType.and_then(y, add_one, OptionType.None) == OptionType.None
    @test OptionType.and_then(y, double, OptionType.None) == OptionType.None
    @test OptionType.and_then(x, add_one) == 6
    @test OptionType.and_then(y, add_one) == OptionType.None
end

@testset "or_else Tests" begin
    x = OptionType.Some(5)
    y = OptionType.None

    fallback = () -> 10

    @test OptionType.or_else(x, fallback) == 5
    @test OptionType.or_else(y, fallback) == 10
end
