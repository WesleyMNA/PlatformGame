require('src.player.Player')
require('src.enemy.EnemyGenerator')

require('src.maps.map01')

Map = {}
Map.__index = Map

function Map:new()
    local this = {
        class = 'Map',

        sprite = love.graphics.newImage('assets/sprites/map/map1.png')
    }

    this.player = Player:new(100, 100)
    this.enemyGenerator = EnemyGenerator:new(mapData.enemies, this.player)

    setmetatable(this, self)

    this.floors = {}
    for _, floorData in pairs(mapData.floors) do
        this:createFloor(floorData)
    end

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

function Map:createFloor(floorData)
    local x = floorData.x * TILE_SIZE
    local y = WINDOW_HEIGHT - TILE_SIZE * floorData.y
    local w = TILE_SIZE * floorData.width
    local floor = WORLD:newRectangleCollider(x, y, w, 1)
    floor:setType('static')
    floor:setCollisionClass('Floor')
    table.insert(self.floors, floor)

    local floorStartLimit = WORLD:newLineCollider(x, y, x, WINDOW_HEIGHT)
    floorStartLimit:setType('static')
    floorStartLimit:setCollisionClass('LimitWall')
    x = x + w
    local floorEndLimit = WORLD:newLineCollider(x, y, x, WINDOW_HEIGHT)
    floorEndLimit:setType('static')
    floorEndLimit:setCollisionClass('LimitWall')
end

function Map:createMapLimits(mapData)
    local mapLimitStart = WORLD:newLineCollider(0, 0, 0, WINDOW_HEIGHT)
    mapLimitStart:setType('static')
    mapLimitStart:setCollisionClass('LimitWall')

    local mapLimitEnd = WORLD:newLineCollider(mapData.width, 0, mapData.width, WINDOW_HEIGHT)
    mapLimitEnd:setType('static')
    mapLimitEnd:setCollisionClass('LimitWall')
end