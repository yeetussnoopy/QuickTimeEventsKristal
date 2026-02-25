return {
    qt = function(cutscene, event)
        cutscene:wait(1)
        local conf = Utils.random(0.07, 0.10)
        local qt = QuickTimeCircle(324, 167, "confirm", 0.07, 30, false, true, true, function(self)
            if self.success then
                --if you sucessfully clicked it
                Assets.playSound("bell")
            else
                --if you didnt click it at all
                Assets.playSound("error")
            end
            --self:remove()
        end, function(self)
            --on missclick early
            Assets.playSound("awkward")
        end)
        Game.stage:addChild(qt)
    end,
}
