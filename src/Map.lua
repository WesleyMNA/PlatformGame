require('src.player.Player')

Map = {}
Map.__index = Map

function Map:new()
    local this = {
        class = 'Map',

        sprite = love.graphics.newImage('sprites/map/map1.png')
    }

    this.player = Player:new(this, 100, 100)

    local h = 112
    this.floor = WORLD:newRectangleCollider(0, WINDOW_HEIGHT-h, WINDOW_WIDTH*5, h)
    this.floor:setType('static')

    local wall = WORLD:newLineCollider(0, 0, 0, WINDOW_HEIGHT)
    wall:setType('static')

    setmetatable(this, self)
    return this
end

function Map:update(dt)
    self.player:update(dt)
end

function Map:render()
    love.graphics.draw(self.sprite, 0, 0)
    self.player:render()
end