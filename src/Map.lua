require('src.player.Player')
require('src.enemy.EnemyGenerator')

Map = {}
Map.__index = Map

function Map:new()
    local this = {
        class = 'Map',

        sprite = love.graphics.newImage('assets/sprites/map/map.png')
    }

    this.player = Player:new(100, 100)
    this.enemyGenerator = EnemyGenerator:new(this.player)

    local y = WINDOW_HEIGHT - 7 * TILE_SIZE
    this.floor = WORLD:newRectangleCollider(0, y, this.sprite:getWidth(), 1)
    this.floor:setType('static')
    this.floor:setCollisionClass('Floor')

    setmetatable(this, self)

    this:createMapLimits(mapData)

    return this
end

function Map:update(dt)
    self.player:update(dt)
    self.enemyGenerator:update(dt)
end

function Map:render()
    love.graphics.setColor(WHITE)
    love.graphics.draw(self.sprite)
    self.player:render()
    self.enemyGenerator:render()
end

function Map:createMapLimits(mapData)
    local mapLimitStart = WORLD:newLineCollider(0, 0, 0, WINDOW_HEIGHT)
    mapLimitStart:setType('static')
    mapLimitStart:setCollisionClass('LimitWall')

    local mapLimitEnd = WORLD:newLineCollider(
        self.sprite:getWidth(), 0,
        self.sprite:getWidth(), WINDOW_HEIGHT
    )
    mapLimitEnd:setType('static')
    mapLimitEnd:setCollisionClass('LimitWall')
end