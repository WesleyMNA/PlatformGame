require('src.Animation')

Player = {}
Player.__index = Player

function Player:new(map, x, y)
    local this = {
        class = 'Player',

        map = map,

        spritesheets = {},
        quads = {},
        animations = {},

        state = 'walk',
        collider = WORLD:newCircleCollider(x, y, 30),
        width = 64,
        height = 64,
        speed = 300,

        direction = {
            x = 0,
            y = 0
        },

        scale = {
            x = 1,
            y = 1
        }
    }

    this.spritesheets.walk = love.graphics.newImage('sprites/player/walk.png')
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

    this.spritesheets.jump = love.graphics.newImage('sprites/player/jump.png')
    local jumpingData = {
        fps = 10,
        frames = 3,
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
end

function Player:render()
    love.graphics.setColor(WHITE)
    love.graphics.draw(
        self.spritesheets[self.state], self.quads[self.state],
        self:getX(), self:getY(), 0,
        self.scale.x, self.scale.y,
        32, 32
    )
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

function Player:getX()
    return self.collider:getX()
end

function Player:getY()
    return self.collider:getY()
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
