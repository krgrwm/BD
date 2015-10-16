using Base.Test
using main

ba = BAGrid(5, 2)

@test get_cell(ba, (2, 1))
@test get_cell(ba, (2, 5))
@test !get_cell(ba, (1, 1))
@test !get_cell(ba, (1, 5))

exists_nbhd(ba, (2,2), moore(1))

update!(ba, (2,1), false)
@test !get_cell(ba, (2, 1))
