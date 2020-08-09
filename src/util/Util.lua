WINDOW_WIDTH = love.graphics.getWidth()
WINDOW_HEIGHT = love.graphics.getHeight()

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

function getDirection(ax, target)
    if target - ax == 0 then
        return 0
    elseif target - ax < 0 then
        return -1
    else
        return 1
    end
end

function table.indexOf(t, object)
    if type(t) ~= "table" then error("table expected, got " .. type(t), 2) end

    for i, v in pairs(t) do
        if object == v then
            return i
        end
    end
end
