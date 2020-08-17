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
        if self.player:getX() >= enemy.playerX and not enemy.created then
            local base = Shooter:new(enemy.x, enemy.y)
            enemy.created = true
            self:addEnemy(base)
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