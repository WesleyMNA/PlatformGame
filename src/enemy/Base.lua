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

function Base:render()
    if self.bullets then renderLoop(self.bullets) end

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
    self.collider:setCategory(2)
    self.collider:setMask(2)
end

function Base:collide()
    if self:isShot() then self.health = self.health - 1 end
end

function Base:die()
    self.enemyGenerator:removeEnemy(self)
end

function Base:changeDirection()
    local aux = self.player:getX() - self:getX()
    local result = 0
    if aux >= 1 then result = 1
    else result = -1 end

    self.scale.x, self.direction.x = result, result * self.speed
end

function Base:isAlive()
    return self.health > 0
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
    self.height = sprite:getHeight()
    self.width = self.height
end