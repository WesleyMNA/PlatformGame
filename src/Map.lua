require('src.Controller')

Map = {}
Map.__index = Map


function Map:new()
    local this = {
        class = 'Map'
    }

    this.player = Player:new(this, 100, 100)
    this.controller = Controller:new(this, this.player)

    this.floor = WORLD:newRectangleCollider(0, WINDOW_HEIGHT-100, WINDOW_WIDTH, 100)
    this.floor:setType('static')

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