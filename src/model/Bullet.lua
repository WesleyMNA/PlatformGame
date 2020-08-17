Bullet = {}
Bullet.__index = Bullet

function Bullet:extend(type)
    local this = {
        class = type,

        state = 'move',
        speed = 600,
        range = 700
    }

    this.__index = this

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

function Bullet:createCollider(x, y)
    x = x + 5 * self.scale.x
    y = y - 1
    self.collider = WORLD:newCircleCollider(x, y, 2)
    self.collider:setGravityScale(0)
end

function Bullet:collide()
    if self:isColliding() or self:isOutOfRange() then
        self.shooter:destroyBullet(self)
    end
end

function Bullet:isInMap()
    return self.collider.body
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

function Bullet:isHittingLimitWall()
    return self.collider:enter('LimitWall')
end

function Bullet:isHittingTheFloor()
    return self.collider:enter('Floor')
end

function Bullet:getX()
    return self.collider:getX()
end

function Bullet:getY()
    return self.collider:getY()
end

function Bullet:setShooter(shooter)
    self.shooter = shooter
    self.scale = {
        x = self.shooter:getScaleX(),
        y = 1
    }
    self.direction = {
        x = self.scale.x * self.speed,
        y = 0
    }
end

function Bullet:setStartX(x)
    self.startX = x
end

function Bullet:setSprite(sprite)
    self.sprite = sprite
    self.width = sprite:getWidth()
    self.height = sprite:getHeight()
end

