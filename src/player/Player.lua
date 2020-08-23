require('src.Animation')
require('src.player.PlayerBullet')

Player = {}
Player.__index = Player

function Player:new(x, y)
    local this = {
        class = 'Player',

        spritesheets = {},
        quads = {},
        animations = {},
        bullets = {},

        state = 'walk',
        collider = WORLD:newCircleCollider(x, y, 16),
        speed = 300,
        jumpHeight = 200,
        shootSpeed = 0.1,

        direction = {
            x = 0,
            y = 0
        },

        scale = {
            x = 1,
            y = 1
        }
    }

    this.collider:setCollisionClass('Player')
    this.collider:setMask(2)

    -- WALK
    this.spritesheets.walk = love.graphics.newImage('assets/sprites/player/walk.png')
    this.height = this.spritesheets.walk:getHeight()
    this.width = this.height

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
    this.spritesheets.jump = love.graphics.newImage('assets/sprites/player/jump.png')
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

    if self:getY() >= WINDOW_HEIGHT then self:die() end

    self:collide()
    self:resetDirection()
    self:resetShoot(dt)
end

function Player:render()
    renderLoop(self.bullets)

    love.graphics.draw(
        self.spritesheets[self.state], self.quads[self.state],
        self:getX(), self:getY(), 0,
        self:getScaleX(), self:getScaleY(),
        self.width/2, self.height/2
    )
end

function Player:attack()
    if self:isJumping() then return end

    if self.shootSpeed >= 0.1 then
        self.shootSpeed = 0
        local bullet = PlayerBullet:new(self:getX(), self:getY(), self)
        table.insert(self.bullets, bullet)
    end
end

function Player:collide()
    -- if self.collider:enter('Enemy') then
    --     local aux = 700 * self:getScaleX() * -1
    --     self.collider:applyLinearImpulse(aux, -100)
    -- end
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

function Player:die()
    self.collider.body:setPosition(100, 100)
end

function Player:isMoving()
    if self.direction.x ~= 0 then return true end
    return false
end

function Player:isJumping()
    return not self:isTouchingTheFloor()
end

function Player:isTouchingTheFloor()
    return self.collider:isTouching(MAP.floor.body)
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
    self.direction.y = y * self.jumpHeight
end
