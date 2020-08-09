Button = {}
Button.__index = Button

function Button:new(x, y, sprite)
    local this = {
        class = 'Button',

        sprite = sprite,
        x = x,
        y = y,
        width = sprite:getWidth(),
        height = sprite:getHeight()
    }

    setmetatable(this, self)
    return this
end

function Button:render()
    love.graphics.setColor(WHITE)
    love.graphics.draw(self.sprite, self.x, self.y)
end

function Button:isClicked()
    local bool = false
    local touches = love.touch.getTouches()
    for i, id in ipairs(touches) do
        local x, y = love.touch.getPosition(id)
        bool = x > self.x and x < self.x + self.width and
            y > self.y and y < self.y + self.height
        if bool then break end
    end
    return bool
end
