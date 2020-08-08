Button = {}
Button.__index = Button

function Button:new(x, y)
    local this = {
        class = 'Button',

        x = x,
        y = y,
        width = 50,
        height = 50
    }

    setmetatable(this, self)
    return this
end

function Button:render()
    love.graphics.setColor(RED)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
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
