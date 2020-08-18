require('src.enemy.Base')
require('src.enemy.EnemyBullet')

Knifer = Base:extend('Knifer')

function Knifer:new(x, y)
    this = {
        class = 'Knifer',

        player = MAP.player,
        enemyGenerator = MAP.enemyGenerator,

        speed = 200
    }

    setmetatable(this, self)

    local sprite = love.graphics.newImage('assets/sprites/enemy/knifer.png')
    this:setSprite(sprite)
    this:createCollider(x, y)

    return this
end

function Knifer:move()
    if self:isTouchingTheFloor() then
        self.collider:setLinearVelocity(self.direction.x, self.direction.y)
    end
end

function Knifer:isTouchingTheFloor()
    for _, floor in pairs(MAP.floors) do
        if self.collider:isTouching(floor.body) then return true end
    end
    return false
end
