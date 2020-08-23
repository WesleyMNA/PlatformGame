require('src.enemy.Base')
require('src.enemy.EnemyBullet')

Shooter = Base:extend('Shooter')

function Shooter:new(x, y)
    this = {
        class = 'Shooter',

        player = MAP.player,
        enemyGenerator = MAP.enemyGenerator,

        bullets = {},
        shootSpeed = 0.5
    }

    setmetatable(this, self)

    local sprite = love.graphics.newImage('assets/sprites/enemy/shooter.png')
    this:setSprite(sprite)
    this:createCollider(x, y)

    return this
end

function Shooter:update(dt)
    if self.bullets then updateLoop(dt, self.bullets) end

    if self:isAlive() then
        if self:isPlayerTooFurther() then return end

        self:changeDirection()

        self:attack()
        self:resetShoot(dt)

        self:collide()
    else
        self:die()
        if self:thereAreNoBullets() then self:destroy() end
    end
end

function Shooter:attack()
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

function Shooter:die()
    local sprite = love.graphics.newImage('assets/sprites/enemy/empty.png')
    self:setSprite(sprite)
    self.collider:setCollisionClass('Ignore')
    self.collider:setCategory(2)
    self.collider:setMask(3)
end

function Shooter:destroy()
    self.enemyGenerator:removeEnemy(self)
end

function Shooter:thereAreNoBullets()
    return #self.bullets <= 0
end