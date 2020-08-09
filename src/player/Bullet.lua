Bullet = {}
Bullet.__index = Bullet

function Bullet:new(x, y, player)
    local this = {
        class = 'Bullet',

        map = player.map,
        player = player,

        state = 'move',
        speed = 500
    }

    this.directionX = player:getScaleX() * this.speed
    this.directionY = 0

    this.collider = WORLD:newCircleCollider(x, y, 2)
    this.collider:setGravityScale(0)
    this.collider:setCollisionClass('Bullet')
    this.collider:setMask(1)

    setmetatable(this, self)
    return this
end

function Bullet:update(dt)
    self:collide()
    self:move()
end

function Bullet:render()
    love.graphics.setColor(ORANGE)
    love.graphics.circle('fill', self:getX(), self:getY(), 2)
end

function Bullet:move()
    if self:isInMap() then
        self.collider:setLinearVelocity(self.directionX, self.directionY)
    end
end

function Bullet:collide()
    if self:isColliding() or self:isOutOfCamera() then
        self.player:destroyBullet(self)
    end
end

function Bullet:isInMap()
    return self.collider.body
end

function Bullet:isColliding()
    return self.collider:isTouching(self.map.floor.body)
end

function Bullet:isOutOfCamera()
    if self:getX() < 0 or self:getX() > WINDOW_WIDTH then
        return true
    end
    return false
end

function Bullet:getX()
    return self.collider:getX()
end

function Bullet:getY()
    return self.collider:getY()
end