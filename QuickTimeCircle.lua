local QuickTimeCircle, super = Class(Object)

function QuickTimeCircle:init(x, y, letter, speed)
    self.radius = 30 -- radius for the progress ring
    self.letter = letter
    self.speed = speed
    super:init(self, x, y)


self.success=  false
    self:setOrigin(0.5, 0.5)

    self.collider = CircleCollider(self, 0, 0, self.radius)


    self.inner_radius = 25 -- radius for the middle circle
    self.collider2 = CircleCollider(self, 0, 0, self.inner_radius)
    self.collider2.inverted = true


    self.progress = 1 -- value from 0 to 1
    self.layer = WORLD_LAYERS["ui"]

    self.font = Assets.getFont("main")


   -- bullet:collidesWith(self.collider)

     self.shot = HitCircle(0, 0, self.speed)
     self.shot.layer = self.layer + 1
    self:addChild(self.shot)
     

     self.counter = 0
end

function QuickTimeCircle:update()

    if Input.pressed(self.letter) then
        print("hi hi hi")
        self.counter = self.counter + 1
    end

    if Input.pressed(self.letter) and self.shot:collidesWith(self.collider) and self.shot:collidesWith(self.collider2) and self.counter < 2 then
        print("hi")
        self.success = true
    end

    super:update(self)

    
end
function QuickTimeCircle:draw()
    super:draw(self)
    love.graphics.push()
    love.graphics.translate(self.width/2, self.height/2)
    
    --love.graphics.setColor(0,0,0, self.alpha)
    --love.graphics.circle("fill", 0, 0, self.radius + 2) -- outline
    --love.graphics.setColor(0.5,0.5,0.5, self.alpha)
    --love.graphics.circle("fill", 0, 0, self.radius) -- dark region of ring
 
    love.graphics.setColor(1,1,1, self.alpha - 0.4)
    love.graphics.arc("fill", "pie", 0, 0, self.radius , -math.pi/2, -math.pi/2 + (math.pi*2 * self.progress)) -- progress part of ring
    love.graphics.setColor(0,0,0, self.alpha)
    love.graphics.circle("fill", 0, 0, self.inner_radius) -- middle circle of ring

    love.graphics.setColor(1,1,1, self.alpha)
    love.graphics.setFont(self.font)
    love.graphics.print(Input.getText(self.letter), -15, -16)



    love.graphics.pop()

    if DEBUG_RENDER then
        self.collider:draw(1, 0, 0)
        self.collider2:draw(1, 0, 1)

    end
end
return QuickTimeCircle