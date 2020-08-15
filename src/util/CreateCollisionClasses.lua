function createCollisionClasses()
    WORLD:addCollisionClass('Player')
    WORLD:addCollisionClass('Bullet')
    WORLD:addCollisionClass('Enemy')
    WORLD:addCollisionClass('EnemyBullet')

    WORLD:addCollisionClass('LimitWall')
    WORLD:addCollisionClass('Ignore')
end