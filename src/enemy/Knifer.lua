require('src.enemy.Base')
require('src.enemy.EnemyBullet')

Knifer = Base:extend('Knifer')

function Knifer:new(x, y)
    this = {
        class = 'Knifer',

        player = MAP.player,
        enemyGenerator = MAP.enemyGenerator,

        speed = 200
    }

    setmetatable(this, self)

    local sprite = love.graphics.newImage('assets/sprites/enemy/knifer.png')
    this:setSprite(sprite)
    local animationData = {
        fps = 7,
        frames = 3,
        xoffsetMul = this.width,
        yoffset = 0,
        loop = true
    }
    this.quads = love.graphics.newQuad(
        0, 0, this.width, this.height,
        this.sprite:getDimensions()
    )
    this.animation = Animation:new(this.quads, animationData)

    this:createCollider(x, y)

    return this
end

function Knifer:update(dt)
    if self:isPlayerTooFurther() then return end

    if self:isAlive() then
        self:changeDirection()

        self:move()
        self.animation:update(dt)

        self:collide()
    else
        self:die()
    end
end

function Knifer:render()
    love.graphics.draw(
        self.sprite, self.quads,
        self:getX(), self:getY(), 0,
        self:getScaleX(), self:getScaleY(),
        self.width/2, self.height/2
    )
end

function Knifer:move()
    if self:isTouchingTheFloor() then
        self.collider:setLinearVelocity(self.direction.x, self.direction.y)
    end
end

function Knifer:isTouchingTheFloor()
    return self.collider:isTouching(MAP.floor.body)
end
