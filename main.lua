require('src.Map')
require('src.Camera')
require('src.util.Util')
require('src.util.Color')
require('src.gui.Controller')
require('src.util.CreateCollisionClasses')


local wf = require 'libs.windfield'

WORLD = wf.newWorld(0, 512, true)
createCollisionClasses()

local map
local controller

function love.load()
    map = Map:new()
    controller = Controller:new(map, map.player)
end

function love.update(dt)
    WORLD:update(dt)
    controller:update(dt)
    map:update(dt)

    if map.player:getX() > WINDOW_WIDTH/2 then
        Camera.x = map.player:getX() - WINDOW_WIDTH/2
    end
end

function love.draw()
    Camera:set()
    map:render()
    WORLD:draw()
    Camera:unset()
    controller:render()
end
