quick time events! for the Deltarune Kristal Engine: https://kristal.cc/ 

# newly updated with ten trillion new features which include: 

```lua
function QuickTimeCircle:init(x, y, letter, speed, radius, allow_ghost_tapping, remove_on_complete, remove_on_whiff, on_complete, on_whiff)

```
example: 

```lua
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
```
put in objects folder 

Click the image below to see how it works (or use the video link): https://www.youtube.com/watch?app=desktop&v=54-AKUCFBw0

[![Game Mechanic in Action](https://i.ytimg.com/vi/LMXWyg5cmjI/hqdefault.jpg?sqp=-oaymwEmCOADEOgC8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGH8gEygXMA8=&rs=AOn4CLBDVwbqq08gdVhSgAM0apr5ZIw5Bg)](https://www.youtube.com/watch?app=desktop&v=54-AKUCFBw0)

nostaglia
