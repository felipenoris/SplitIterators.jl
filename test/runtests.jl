
using Test

import SplitIterators

@testset "split 11 by 3" begin
    x = collect(1:11)

    for (i, part) in enumerate(SplitIterators.split(x, 3))
        if i == 1
            @test part == collect(1:4)
        elseif i == 2
            @test part == collect(5:8)
        elseif i == 3
            @test part == collect(9:11)
        else
            @test false
        end
    end

    @test length(SplitIterators.split(x, 3)) == 3
end

@testset "split range 11 by 3" begin
    x = 1:11

    for (i, part) in enumerate(SplitIterators.split(x, 3))
        if i == 1
            @test part == 1:4
        elseif i == 2
            @test part == 5:8
        elseif i == 3
            # TODO: should yield `9:11`
            @test part == collect(9:11)
        else
            @test false
        end
    end

    @test length(SplitIterators.split(x, 3)) == 3
end

@testset "split 11 by 11" begin
    x = collect(1:11)

    for (i, part) in enumerate(SplitIterators.split(x, 11))
        @test part == [i]
    end
end

@testset "split 11 by 15" begin
    x = collect(1:11)

    for (i, part) in enumerate(SplitIterators.split(x, 15))
        @test part == [i]
    end
end

@testset "split 11 by 1" begin
    x = collect(1:11)

    for (i, part) in enumerate(SplitIterators.split(x, 1))
        if i == 1
            @test part == collect(1:11)
        else
            @test false
        end
    end
end

@testset "split empty itr" begin
    x = []
    @test_throws ArgumentError SplitIterators.split(x, 10)
end
