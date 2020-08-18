Base = {}
Base.__index = Base

function Base:extend(type)
    local this = {
        class = type,

        health = 1,
        speed = 100,
        direction = {
            x = 0,
            y = 0
        },
        scale = {
            x = 1,
            y = 1
        }
    }

    this.__index = this

    setmetatable(this, self)
    return this
end

scale = 1

function Base:update(dt)
    if self.bullets then updateLoop(dt, self.bullets) end

    if self:isPlayerTooFurther() then return end

    self:changeDirection()

    if self:isShooter() then
        self:attack()
        self:resetShoot(dt)
    end

    if self:isKnifer() then
        self:move()
    end

    self:collide()
    self:die()
end

function Base:render()
    if self.bullets then renderLoop(self.bullets) end

    love.graphics.setColor(WHITE)
    love.graphics.draw(
        self.sprite,
        self:getX(), self:getY(), 0,
        self:getScaleX(), self:getScaleY(),
        self.width/2, self.height/2
    )

    -- love.graphics.setColor(RED)
    -- love.graphics.print(self.health, self:getX(), self:getY()-50)
end

function Base:createCollider(x, y)
    self.collider = WORLD:newCircleCollider(x, y, 16)
    self.collider:setMass(10000000000)
    self.collider:setCollisionClass('Enemy')
end

function Base:collide()
    if self:isShot() then self.health = self.health - 1 end
end

function Base:die()
    if self.health <= 0 then
        self.enemyGenerator:removeEnemy(self)
    end
end

function Base:changeDirection()
    local aux = self.player:getX() - self:getX()
    local result = 0
    if aux >= 1 then result = 1
    else result = -1 end

    self.scale.x, self.direction.x = result, result * self.speed
end

function Base:isShooter()
    return self.class == 'Shooter'
end

function Base:isKnifer()
    return self.class == 'Knifer'
end

function Base:isShot()
    return self.collider:enter('PlayerBullet')
end

function Base:isPlayerTooFurther()
    return math.abs(self:getX() - self.player:getX()) > 300
end

function Base:getScaleX()
    return self.scale.x
end

function Base:getScaleY()
    return self.scale.y
end

function Base:getX()
    return self.collider:getX()
end

function Base:getY()
    return self.collider:getY()
end

function Base:setSprite(sprite)
    self.sprite = sprite
    self.width = sprite:getWidth()
    self.height = sprite:getHeight()
end