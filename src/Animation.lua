Animation = {}
Animation.__index = Animation

function Animation:new(quad, animationData)
    local this = {
        class = 'Animation',
        quad = quad,
        fps = animationData.fps,
        timer = 1 / animationData.fps,
        frame = 1,
        frames = animationData.frames,
        xoffset = 0,
        xoffsetMul = animationData.xoffsetMul,
        yoffset = animationData.yoffset,
        loop = animationData.loop
    }

    setmetatable(this, self)
    return this
end

function Animation:update(dt)
    self.timer = self.timer - dt
    if self.timer <= 0 then
        self.timer = 1 / self.fps
        self.frame = self.frame + 1
        if self.frame >= self.frames then
            if self:hasLoop() then self.frame = 0
            else return end
        end
        self.xoffset = self.xoffsetMul * self.frame
        self.quad:setViewport(self.xoffset, self.yoffset, self.xoffsetMul, self.xoffsetMul)
    end
end

function Animation:hasLoop()
    return self.loop
end

function Animation:reset()
    self.frame = 0
    self.quad:setViewport(self.frame, self.yoffset, self.xoffsetMul, self.xoffsetMul)
end