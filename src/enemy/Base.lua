Base = {}
Base.__index = Base

function Base:extend(type)
    local this = {
        class = type,

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

function Base:update(dt)
    if self.bullets then updateLoop(dt, self.bullets) end

    if self:isShooter() then
        self:attack()
        self:resetShoot(dt)
    end
    self:collide()
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
end

function Base:createCollider(x, y)
    self.collider = WORLD:newCircleCollider(x, y, 16)
    self.collider:setMass(10000000000)
    self.collider:setCollisionClass('Enemy')
end

function Base:collide()
    if self:isShot() then
        print(1)
    end
end

function Base:isShooter()
    return self.class == 'Shooter'
end

function Base:isShot()
    return self.collider:enter('Bullet')
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