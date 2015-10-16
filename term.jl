module term
export color, characters, clear_display

using Compat

function color(c::ASCIIString, str::Union(ASCIIString, Char))
    @compat colors = Dict{ASCIIString, ASCIIString}(
        "clear"  => "\033[0m",
        "black"  => "\033[40m",
        "red"    => "\033[41m",
        "green"  => "\033[42m",
        "yellow" => "\033[43m",
        "blue"   => "\033[44m",
        "purple" => "\033[45m",
        "cyan"   => "\033[46m",
        "white"  => "\033[47m"
        )
    string(colors[c], str, colors["clear"])
end

const characters = [' ', '.', '-', ':', '|', '/', '\\', '+', '*', 'o',
                    'a', 'b', 'c', 'd', 'e', '#', '@'
                    ]


function clear_display()
    print("\033[2J") # clear
    print("\033[1H") # hidari ue
    
end

end
