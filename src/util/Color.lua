BLACK = {0, 0, 0}
WHITE = {1, 1, 1}
RED = {1, 0, 0}
GREEN = {0, 1, 0}
BLUE = {0, 0, 1}
YELLOW = {1, 1, 0}
PURPLE = {0.5, 0, 0.5}
ORANGE = {1, 0.64, 0}
GREY = {0.5, 0.5, 0.5}
TURQUOISE= {0.25, 0.87, 0.81}

function addAlpha(color, alpha) 
    local aux = copy(color)
    aux[4] = alpha
    return aux
end