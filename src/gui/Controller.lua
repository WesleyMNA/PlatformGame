require('src.gui.Button')

Controller = {}
Controller.__index = Controller

function Controller:new(map, player)
    local this = {
        class = 'Controller',

        player = player,
        map = map
    }

    local buttonY = WINDOW_HEIGHT - 100
    local leftSprite = love.graphics.newImage('assets/sprites/gui/left-arrow.png')
    local rightSprite = love.graphics.newImage('assets/sprites/gui/right-arrow.png')
    this.moveButtons = {
        left = Button:new(10, buttonY, leftSprite),
        right = Button:new(100, buttonY, rightSprite)
    }
    this.moveButtons.left.update = function (dt)
        if this.moveButtons.left:isClicked() or love.keyboard.isDown('a') then
            this.player:setDirectionX(-1)
        end
    end

    this.moveButtons.right.update = function (dt)
        if this.moveButtons.right:isClicked() or love.keyboard.isDown('d') then 
            this.player:setDirectionX(1)
        end
    end

    local attackSprite = love.graphics.newImage('assets/sprites/gui/attack.png')
    local jumpSprite = love.graphics.newImage('assets/sprites/gui/jump.png')
    this.actionButtons = {
        attack = Button:new(WINDOW_WIDTH-60, buttonY-10, attackSprite),
        jump = Button:new(WINDOW_WIDTH-150, buttonY+20, jumpSprite)
    }
    this.actionButtons.attack.update = function (dt)
        if this.actionButtons.attack:isClicked() or love.keyboard.isDown('m') then
            this.player:attack()
        end
    end

    this.actionButtons.jump.update = function (dt)
        if this.actionButtons.jump:isClicked() or love.keyboard.isDown('space') then
            this.player:setDirectionY(-1)
        end
    end

    setmetatable(this, self)
    return this
end

function Controller:update(dt)
    if self:screenTouched() or self:keyPressed() then
        updateLoop(dt, self.moveButtons)
        updateLoop(dt, self.actionButtons)
    end
end

function Controller:render()
    renderLoop(self.moveButtons)
    renderLoop(self.actionButtons)
end

function Controller:screenTouched()
    if #love.touch.getTouches() == 0 then return false end
    return true
end

function Controller:keyPressed()
    local bool = love.keyboard.isDown('a') or
        love.keyboard.isDown('d') or
        love.keyboard.isDown('space') or
        love.keyboard.isDown('m')
    return bool
end