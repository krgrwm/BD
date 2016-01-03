push!(LOAD_PATH, ".")
using term
using BD


function draw_grid(ba::BDGrid)
    for i in 1:ba.height
        for j in 1:ba.width
            c = get_cell(ba, (i, j)) ? "green":"black"
            print(color(c, "*"))
        end
        print('\n')
    end
end

function main()
    width, height, N = map(x->parse(Int, x), ARGS)

    bd = BDGrid(width, height)
    for i in 1:N
        fall!(bd)
    end

    draw_grid(bd)
end

main()
