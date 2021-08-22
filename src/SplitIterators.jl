module SplitIterators

import .Base:
    iterate, length, eltype, IteratorEltype, IteratorSize

"""
    split(iterator, parts_count)

Splits an iterator into at most `parts_count` partitions with almost the same size.
"""
function split(itr, parts_count::Integer)
    parts_count < 1 && throw(ArgumentError("cannot split iterator into $parts_count partitions"))
    len = length(itr)
    if iszero(len)
        throw(ArgumentError("cannot split empty iterator"))
    end
    parts_count = min(parts_count, len)
    d, m = div(len, parts_count), mod(len, parts_count)

    # divides itr into m partitions with d+1 elements, and (len - m) partitions with d elements.
    big_itr = Iterators.partition(itr, d + 1)
    small_itr = Iterators.partition(Iterators.drop(itr, (d+1)*m), d)
    return SplitIterator(parts_count, m, big_itr, small_itr)
end

struct SplitIterator{T1<:Iterators.PartitionIterator,T2<:Iterators.PartitionIterator}
    parts_count::Int
    big_itr_parts_count::Int
    big_itr::T1
    small_itr::T2
end

eltype(::Type{SplitIterator{T}}) where {T} = eltype(T)
IteratorEltype(::Type{SplitIterator{T}}) where {T} = IteratorEltype(T)
IteratorSize(::Type{SplitIterator{T}}) where {T} = IteratorSize(T)
length(itr::SplitIterator) = itr.parts_count

struct SplitIteratorState{T}
    next_partition::Int
    next_inner_itr_state::T
end

function iterate(itr::SplitIterator, state::SplitIteratorState=SplitIteratorState(1, nothing))
    current_partition = state.next_partition

    if current_partition > itr.parts_count
        return nothing
    end

    inner_itr = current_partition > itr.big_itr_parts_count ? itr.small_itr : itr.big_itr

    local iterate_result
    if current_partition == itr.big_itr_parts_count + 1 || state == SplitIteratorState(1, nothing)
        # inner_itr change
        iterate_result = iterate(inner_itr)
    else
        iterate_result = iterate(inner_itr, state.next_inner_itr_state)
    end

    if iterate_result == nothing
        return nothing
    else
        next_el, next_inner_state = iterate_result
        return next_el, SplitIteratorState(current_partition + 1, next_inner_state)
    end
end

end # module