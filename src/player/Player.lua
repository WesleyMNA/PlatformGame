require('src.Animation')
require('src.player.Bullet')

Player = {}
Player.__index = Player

function Player:new(map, x, y)
    local this = {
        class = 'Player',

        map = map,

        spritesheets = {},
        quads = {},
        animations = {},
        bullets = {},

        state = 'walk',
        collider = WORLD:newCircleCollider(x, y, 16),
        speed = 300,

        direction = {
            x = 0,
            y = 0
        },

        scale = {
            x = 1,
            y = 1
        },

        shootSpeed = 0.5
    }

    this.collider:setCollisionClass('Player')

    -- WALK
    this.spritesheets.walk = love.graphics.newImage('sprites/player/walk.png')
    this.width = this.spritesheets.walk:getHeight()
    this.height = this.width

    local walkingData = {
        fps = 10,
        frames = 3,
        xoffsetMul = this.width,
        yoffset = 0,
        loop = true
    }
    this.quads.walk = love.graphics.newQuad(
        0, 0, this.width, this.height,
        this.spritesheets.walk:getDimensions()
    )
    this.animations.walk = Animation:new(this.quads.walk, walkingData)

    -- JUMP
    this.spritesheets.jump = love.graphics.newImage('sprites/player/jump.png')
    local jumpingData = {
        fps = 1,
        frames = 1,
        xoffsetMul = this.width,
        yoffset = 0,
        loop = false
    }
    this.quads.jump = love.graphics.newQuad(
        0, 0, this.width, this.height,
        this.spritesheets.jump:getDimensions()
    )
    this.animations.jump = Animation:new(this.quads.jump, jumpingData)

    setmetatable(this, self)
    return this
end

function Player:update(dt)
    updateLoop(dt, self.bullets)

    if self:isTouchingTheFloor() then
        self.state = 'walk'
        self:move()
    end

    if self:isJumping() then
        self.state = 'jump'
        self.animations[self.state]:update(dt)
    elseif self:isMoving() then
        self.state = 'walk'
        self.animations[self.state]:update(dt)
    else
        self.animations[self.state]:reset()
    end

    self:resetDirection()
    self:resetShoot(dt)
end

function Player:render()
    renderLoop(self.bullets)
    love.graphics.setColor(WHITE)
    love.graphics.draw(
        self.spritesheets[self.state], self.quads[self.state],
        self:getX(), self:getY(), 0,
        self:getScaleX(), self:getScaleY(),
        self.width/2, self.height/2
    )
end

function Player:attack()
    if self:isJumping() then return end

    if self.shootSpeed >= 0.5 then
        self.shootSpeed = 0
        local bullet = Bullet:new(self:getX(), self:getY(), self)
        table.insert(self.bullets, bullet)
    end
end

function Player:resetShoot(dt)
    self.shootSpeed = self.shootSpeed + dt
end

function Player:destroyBullet(bullet)
    local index = table.indexOf(self.bullets, bullet)
    table.remove(self.bullets, index)
    bullet.collider:destroy()
end

function Player:move()
    self.collider:setLinearVelocity(self.direction.x, self.direction.y)
end

function Player:isMoving()
    if self.direction.x ~= 0 then return true end
    return false
end

function Player:isJumping()
    return not self:isTouchingTheFloor()
end

function Player:isTouchingTheFloor()
    return self.collider:isTouching(self.map.floor.body)
end

function Player:getPosition()
    return self.collider:getX(), self.collider:getY()
end

function Player:getX()
    return self.collider:getX()
end

function Player:getY()
    return self.collider:getY()
end

function Player:getScaleX()
    return self.scale.x
end

function Player:getScaleY()
    return self.scale.y
end

function Player:resetDirection()
    self.direction = {x = 0, y = 0}
end

function Player:setDirectionX(x)
    self.direction.x = x * self.speed
    self.scale.x = x
end

function Player:setDirectionY(y)
    self.direction.y = y * self.speed
end
