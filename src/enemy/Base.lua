Base = {}
Base.__index = Base

function Base:new(x, y)
    local this = {
        class = 'Base',

        sprite = love.graphics.newImage('assets/sprites/enemies/base.png'),
        collider = WORLD:newCircleCollider(x, y, 16),

        bullets = {}
    }

    this.collider:setMass(10000000000)
    this.collider:setCollisionClass('Enemy')

    this.width = this.sprite:getWidth()
    this.height = this.sprite:getHeight()

    setmetatable(this, self)
    return this
end

function Base:update(dt)
    self:collide()
end

function Base:render()
    -- renderLoop(self.bullets)
    love.graphics.setColor(WHITE)
    love.graphics.draw(
        self.sprite,
        self:getX(), self:getY(), 0, 1, 1,
        self.width/2, self.height/2
    )
end

function Base:collide()
    if self:isShot() then
        print(1)
    end
end

function Base:isShot()
    return self.collider:enter('Bullet')
end

function Base:getX()
    return self.collider:getX()
end

function Base:getY()
    return self.collider:getY()
end