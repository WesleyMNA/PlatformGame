Bullet = {}
Bullet.__index = Bullet

function Bullet:new(x, y, player)
    local this = {
        class = 'Bullet',

        map = player.map,
        player = player,
        startX = x,

        sprite = love.graphics.newImage('assets/sprites/player/bullet.png'),
        state = 'move',
        speed = 600,
        range = 700,

        scale = {
            x = player:getScaleX(),
            y = 1
        },
    }

    this.direction = {
        x = player:getScaleX() * this.speed,
        y = 0
    }

    this.width = this.sprite:getWidth()
    this.height = this.sprite:getHeight()

    x = x + 5 * this.scale.x
    y = y - 1
    this.collider = WORLD:newCircleCollider(x, y, 2)
    this.collider:setGravityScale(0)
    this.collider:setCollisionClass('Bullet')
    -- this.collider:setMask(1)

    setmetatable(this, self)
    return this
end

function Bullet:update(dt)
    self:collide()
    self:move()
end

function Bullet:render()
    love.graphics.setColor(WHITE)
    love.graphics.draw(
        self.sprite, self:getX(), self:getY(), 0,
        self.scale.x, self.scale.y,
        self.width/2, self.height/2
    )
end

function Bullet:move()
    if self:isInMap() then
        self.collider:setLinearVelocity(self.direction.x, self.direction.y)
    end
end

function Bullet:collide()
    if self:isColliding() or self:isOutOfRange() then
        self.player:destroyBullet(self)
    end
end

function Bullet:isInMap()
    return self.collider.body
end

function Bullet:isColliding()
    if self:isHittingTheFloor() then return true end

    if self:isHittingEnemy() then return true end

    if self:isHittingLimitWall() then return true end

    return false
end

function Bullet:isOutOfRange()
    local distance = self:getX() - self.startX
    if self:getX() < 0 or
    distance >= self.range or
    distance <= -self.range then
        return true
    end
    return false
end

function Bullet:isHittingEnemy()
    return self.collider:enter('Enemy')
end

function Bullet:isHittingLimitWall()
    return self.collider:enter('LimitWall')
end

function Bullet:isHittingTheFloor()
    for _, floor in pairs(self.map.floors) do
        if self.collider:isTouching(floor.body) then return true end
    end
    return false
end

function Bullet:getX()
    return self.collider:getX()
end

function Bullet:getY()
    return self.collider:getY()
end