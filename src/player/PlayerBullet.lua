require('src.model.Bullet')

PlayerBullet = Bullet:extend('PlayerBullet')

function PlayerBullet:new(x, y, shooter)
    local this = {}

    setmetatable(this, self)

    this:setShooter(shooter)
    this:setStartX(x)

    local sprite = love.graphics.newImage('assets/sprites/player/bullet.png')
    this:setSprite(sprite)

    this:createCollider(x, y)
    this.collider:setCollisionClass('PlayerBullet')

    return this
end

function PlayerBullet:isColliding()
    if self:isHittingEnemy() then return true end

    if self:isHittingTheFloor() then return true end

    if self:isHittingLimitWall() then return true end

    return false
end

function PlayerBullet:isHittingEnemy()
    return self.collider:enter('Enemy')
end
