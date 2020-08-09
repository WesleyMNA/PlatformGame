require('src.Map')
require('src.util.Util')
require('src.util.Color')
require('src.util.CreateCollisionClasses')

local wf = require 'libs.windfield'

WORLD = wf.newWorld(0, 512, true)
createCollisionClasses()

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
