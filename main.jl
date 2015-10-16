module main

using term

export BAGrid, get_cell, moore, neumann, neighbors, exists_nbhd, update!

typealias Cell Bool
typealias Grid Array{Cell, 2}
typealias Pos (Int64, Int64)
typealias Nbhd Set{(Int64, Int64)}

const EMPTY=false
const OCCUPIED=true

function moore(r)
    delete!(Set([(i, j) for i=-r:r, j=-r:r]), (0,0))
end

function neumann(r)
    list = moore(r)
    filter(x -> abs(x[1]) + abs(x[2]) <= r, list)
end

type BAGrid
    height::Int64
    width::Int64
    grid::Grid
    
    function BAGrid(w::Int64, h::Int64)
        new(h, w, vcat(falses((h-1, w)), trues((1, w))))
    end
end

function get_cell(ba::BAGrid, p::Pos)
    i, j = p
    (j < 1 || j > ba.width) && return EMPTY
    (i < 1 || i > ba.height) && return EMPTY
    return ba.grid[i, j]
end

function neighbors(ba::BAGrid, p::Pos, nbhd::Nbhd)
    [map(+, p, n) for n in nbhd]
end

function exists_nbhd(ba::BAGrid, p::Pos, nbhd::Nbhd)
    reduce((acc, pos_nbhd) -> acc || (get_cell(ba, pos_nbhd)), false, neighbors(ba, p, nbhd))
end

function update!(ba::BAGrid, p::Pos, v::Cell)
    i, j = p
    ba.grid[i, j] = v
end

function fall!(ba::BAGrid)
    j_rand = rand(1:ba.width)
    pos_column = [(i, j_rand) for i in 1:ba.height]

    i_stick = find(i -> exists_nbhd(ba, (i,j_rand), neumann(1)), 1:ba.height)[1]
#    print(j_rand)
#    print((i_stick, j_rand))
    update!(ba, (i_stick, j_rand), OCCUPIED)
end


function draw_grid(ba::BAGrid)
    for i in 1:ba.height
        for j in 1:ba.width
            c = get_cell(ba, (i, j)) ? "green":"black"
            print(color(c, "*"))
        end
        print('\n')
    end
end

tmp = BAGrid(160, 200)
for i in 1:10000
    fall!(tmp)
end
draw_grid(tmp)


end
