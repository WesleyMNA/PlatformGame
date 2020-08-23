require('src.Map')
require('src.Camera')
require('src.util.Util')
require('src.util.Color')
require('src.gui.Controller')
require('src.util.CreateCollisionClasses')


local wf = require 'libs.windfield'

WORLD = wf.newWorld(0, 512, true)
createCollisionClasses()

MAP = Map:new()

local controller

function love.load()
    controller = Controller:new(MAP.player)
end

function love.update(dt)
    WORLD:update(dt)
    controller:update(dt)
    MAP:update(dt)

    if MAP.player:getX() > WINDOW_WIDTH/2 then 
        Camera.x = MAP.player:getX() - WINDOW_WIDTH/2
    end
end

function love.draw()
    Camera:set()
    MAP:render()
    -- WORLD:draw()
    Camera:unset()
    controller:render()
end
