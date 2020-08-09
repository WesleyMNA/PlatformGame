require('src.player.Player')
require('src.gui.Controller')

Map = {}
Map.__index = Map

function Map:new()
    local this = {
        class = 'Map'
    }

    this.player = Player:new(this, 100, 100)
    this.controller = Controller:new(this, this.player)

    local h = 120
    this.floor = WORLD:newRectangleCollider(0, WINDOW_HEIGHT-h, WINDOW_WIDTH, h)
    this.floor:setType('static')

    this.wall = WORLD:newLineCollider(0,0, 0, WINDOW_HEIGHT)
    this.wall:setType('static')

    this.wall2 = WORLD:newLineCollider(WINDOW_WIDTH, 0, WINDOW_WIDTH, WINDOW_HEIGHT)
    this.wall2:setType('static')

    setmetatable(this, self)
    return this
end

function Map:update(dt)
    self.controller:update(dt)
    self.player:update(dt)
end

function Map:render()
    self.controller:render()
    self.player:render()
end