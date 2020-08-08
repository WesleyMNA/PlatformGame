WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()

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

function renderLoop(objectList)
    for i, object in pairs(objectList) do
        object:render()
    end
end

function updateLoop(dt, objectList)
    for i, object in pairs(objectList) do
        object:update(dt)
    end
end

function copy(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
    return res
end

function addAlpha(color, alpha) 
    local aux = copy(color)
    aux[4] = alpha
    return aux
end

function getDirection(ax, target)
    if target - ax == 0 then
        return 0
    elseif target - ax < 0 then
        return -1
    else
        return 1
    end
end