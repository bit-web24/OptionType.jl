using Options
using Test

@testset "Some Tests" begin
    x = Options.Some(10)
    y = Options.Some("Hello")

    @test Options.isempty(x) == false
    @test Options.isempty(y) == false

    @test Options.get(x, 0) == 10
    @test Options.get(y, "Default") == "Hello"
    @test Options.get(Options.map(x -> x^2, x), 0) == 100
    @test Options.get(Options.map(s -> uppercase(s), y), "Default") == "HELLO"
end

@testset "None Tests" begin
    n = Options.None

    @test Options.isempty(n) == true

    @test Options.get(n, 0) == 0
    @test Options.get(Options.map(x -> x^2, n), 0) == 0
end

@testset "and_then Tests" begin
    x = Options.Some(5)
    y = Options.None

    add_one = x -> x + 1
    double = x -> x * 2

    @test Options.and_then(x, add_one, 0) == 6
    @test Options.and_then(x, double, 0) == 10
    @test Options.and_then(x, add_one, Options.None) == 6
    @test Options.and_then(x, double, Options.None) == 10
    @test Options.and_then(y, add_one, 0) == 0
    @test Options.and_then(y, double, 0) == 0
    @test Options.and_then(y, add_one, Options.None) == Options.None
    @test Options.and_then(y, double, Options.None) == Options.None
    @test Options.and_then(x, add_one) == 6
    @test Options.and_then(y, add_one) == Options.None
end

@testset "or_else Tests" begin
    x = Options.Some(5)
    y = Options.None

    fallback = () -> 10

    @test Options.or_else(x, fallback) == 5
    @test Options.or_else(y, fallback) == 10
end
