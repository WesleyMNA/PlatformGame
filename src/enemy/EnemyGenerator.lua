require('src.enemy.Knifer')
require('src.enemy.Shooter')

EnemyGenerator = {}
EnemyGenerator.__index = EnemyGenerator

function EnemyGenerator:new(enemyData, player)
    local this = {
        class = 'EnemyGenerator',

        enemyData = enemyData,
        player = player,

        enemiesInScene = {}
    }

    setmetatable(this, self)
    return this
end

function EnemyGenerator:update(dt)
    for _, enemy in pairs(self.enemyData) do
        if not enemy.created then
            -- local test = Knifer:new(enemy.x, enemy.y)
            local test = Shooter:new(enemy.x, enemy.y)
            enemy.created = true
            self:addEnemy(test)
        end
    end
    updateLoop(dt, self.enemiesInScene)
end

function EnemyGenerator:render()
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