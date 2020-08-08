require('src.Button')
require('src.Player')

local function keyPressed()
    local bool = love.keyboard.isDown('a') or
        love.keyboard.isDown('d') or
        love.keyboard.isDown('space')
    return bool
end

Controller = {}
Controller.__index = Controller

function Controller:new(map, player)
    local this = {
        class = 'Controller',

        player = player,
        map = map
    }

    local buttonY = WINDOW_HEIGHT - 100
    this.moveButtons = {
        left = Button:new(10, buttonY),
        right = Button:new(100, buttonY)
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


    this.actionButtons = {
        attack = Button:new(WINDOW_WIDTH-60, buttonY-20),
        jump = Button:new(WINDOW_WIDTH-150, buttonY+20)
    }
    this.actionButtons.attack.update = function (dt)
        if this.actionButtons.attack:isClicked() then
            return
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
    if self:screenTouched() or keyPressed() then
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