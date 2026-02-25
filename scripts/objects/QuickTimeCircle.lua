local QuickTimeCircle, super = Class(Object)

function QuickTimeCircle:init(x, y, letter, speed, radius, allow_ghost_tapping, remove_on_complete, remove_on_whiff, on_complete, on_whiff)
    self.radius = 30 -- radius for the progress ring
    self.letter = letter
    self.speed = speed or 0.085
    self.on_complete = on_complete or nil
    self.allow_ghost_tapping = allow_ghost_tapping or false
    self.remove_on_whiff = remove_on_whiff or true
    self.on_whiff = on_whiff or nil
    self.remove_on_complete = remove_on_complete or true
    super.init(self, x, y)


    self.success = false
    self:setOrigin(0.5, 0.5)

    self.collider = CircleCollider(self, 0, 0, self.radius)


    self.inner_radius = 25 -- radius for the middle circle
    self.collider2 = CircleCollider(self, 0, 0, self.inner_radius)
    self.collider2.inverted = true


    self.layer = WORLD_LAYERS["ui"]

    self.font = Assets.getFont("main")


    -- bullet:collidesWith(self.collider)

    self.shot = HitCircle(0, 0, self.speed, (radius or nil))
    self.shot.layer = self.layer + 1
    self:addChild(self.shot)


    self.counter = 0

    self.huge = 2


    if allow_ghost_tapping or false then
        self.huge = math.huge
    end
end

function QuickTimeCircle:onAdd()
    self.counter = 0
end

function QuickTimeCircle:update()
    if Input.pressed(self.letter) then
        self.counter = self.counter + 1

        if self.shot:collidesWith(self.collider) and self.shot:collidesWith(self.collider2) and self.counter < self.huge then
            self.success = true
        else
            if self.remove_on_whiff and not self.allow_ghost_tapping then
                if self.on_whiff then
                    self.on_whiff(self)
                end
                self:remove()
            end
        end
    end



    if self.shot.scale_x < 0.31 then
        if self.on_complete then
            self.on_complete(self)
        end
        if self.remove_on_complete then
            self:remove()
        end
    end

    super.update(self)
end

function QuickTimeCircle:draw()
    super.draw(self)
    love.graphics.push()
    love.graphics.translate(self.width / 2, self.height / 2)
    love.graphics.setColor(1, 1, 1, self.alpha - 0.4)
    love.graphics.arc("fill", "pie", 0, 0, self.radius, -math.pi / 2, -math.pi / 2 + (math.pi * 2))
    love.graphics.setColor(0, 0, 0, self.alpha)
    love.graphics.circle("fill", 0, 0, self.inner_radius)

    love.graphics.setColor(1, 1, 1, self.alpha)
    love.graphics.setFont(self.font)
    love.graphics.print(Input.getText(self.letter), -15, -16)



    love.graphics.pop()

    if DEBUG_RENDER then
        self.collider:draw(1, 0, 0)
        self.collider2:draw(1, 0, 1)



        Draw.setColor(COLORS.red)
        love.graphics.setFont(Assets.getFont("main_mono"))
        love.graphics.print("can press?:" ..
            (tostring(self.shot:collidesWith(self.collider) and self.shot:collidesWith(self.collider2))))

        love.graphics.print("success:" .. tostring(self.success), 0, 30)

        love.graphics.print("pressed key?:" .. tostring(self.counter), 0, 60)
    end
end

return QuickTimeCircle
