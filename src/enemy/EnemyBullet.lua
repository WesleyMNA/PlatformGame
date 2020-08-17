require('src.model.Bullet')

EnemyBullet = Bullet:extend('EnemyBullet')

function EnemyBullet:new(x, y, shooter)
    local this = {}

    setmetatable(this, self)

    this:setShooter(shooter)
    this:setStartX(x)

    this:setSprite(love.graphics.newImage('assets/sprites/enemy/bullet.png'))

    this:createCollider(x, y)
    this.collider:setCollisionClass('EnemyBullet')

    return this
end

function EnemyBullet:isColliding()
    if self:isHittingPlayer() then return true end

    if self:isHittingTheFloor() then return true end

    if self:isHittingLimitWall() then return true end

    return false
end


function EnemyBullet:isHittingPlayer()
    return self.collider:enter('Player')
end
