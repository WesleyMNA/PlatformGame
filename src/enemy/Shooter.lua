require('src.enemy.Base')
require('src.enemy.EnemyBullet')

Shooter = Base:extend('Shooter')

function Shooter:new(x, y)
    this = {
        class = 'Shooter',

        bullets = {},
        shootSpeed = 0.5
    }

    setmetatable(this, self)

    local sprite = love.graphics.newImage('assets/sprites/enemy/base.png')
    this:setSprite(sprite)
    this:createCollider(x, y)

    return this
end

function Shooter:attack()
    -- if self:isJumping() then return end

    if self.shootSpeed >= 0.5 then
        self.shootSpeed = 0
        local bullet = EnemyBullet:new(self:getX(), self:getY(), self)
        table.insert(self.bullets, bullet)
    end
end

function Shooter:resetShoot(dt)
    self.shootSpeed = self.shootSpeed + dt
end

function Shooter:destroyBullet(bullet)
    local index = table.indexOf(self.bullets, bullet)
    table.remove(self.bullets, index)
    bullet.collider:destroy()
end
