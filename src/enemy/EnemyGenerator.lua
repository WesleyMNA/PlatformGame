require('src.enemy.Knifer')
require('src.enemy.Shooter')

EnemyGenerator = {}
EnemyGenerator.__index = EnemyGenerator

function EnemyGenerator:new(player)
    local this = {
        class = 'EnemyGenerator',

        player = player,

        enemiesInScene = {}
    }

    this.enemies = {
        shooter = function(x, y)
            return Shooter:new(x, y)
        end,
        knifer = function(x, y)
            return Knifer:new(x, y)
        end,
    }

    setmetatable(this, self)
    return this
end

function EnemyGenerator:update(dt)
    updateLoop(dt, self.enemiesInScene)

    if math.random(100) == 1 then
        local x = math.random(800)
        local shooter = Shooter:new(x, 100)
        self:addEnemy(shooter)
    end

    if math.random(100) == 1 then
        local x = math.random(800)
        local knifer = Knifer:new(x, 100)
        self:addEnemy(knifer)
    end
end

function EnemyGenerator:render()
    love.graphics.setColor(WHITE)
    renderLoop(self.enemiesInScene)
end

function EnemyGenerator:addEnemy(enemy)
    table.insert(self.enemiesInScene, enemy)
end

function EnemyGenerator:removeEnemy(enemy)
    local index = table.indexOf(self.enemiesInScene, enemy)
    table.remove(self.enemiesInScene, index)
    enemy.collider:destroy()
end