function createCollisionClasses()
    WORLD:addCollisionClass('Player')
    WORLD:addCollisionClass('PlayerBullet')
    
    WORLD:addCollisionClass('Enemy')
    WORLD:addCollisionClass('EnemyBullet')

    WORLD:addCollisionClass('Floor')
    WORLD:addCollisionClass('LimitWall')

    WORLD:addCollisionClass('Ignore')
end