require('src.Map')
require('src.Util')
local wf = require 'libs.windfield'

WORLD = wf.newWorld(0, 512, true)

local map

function love.load()
    map = Map:new()
end

function love.update(dt)
    WORLD:update(dt)
    map:update(dt)
end

function love.draw()
    WORLD:draw()
    map:render()
end
