---@diagnostic disable: undefined-global
---
--- Created by Tristan.
--- DateTime: 7/19/24 3:09 PM
--- This may cause problems, I am not responsible for any damage caused by this code.
---

function love.load()
    CellSize = 20
    Width, Height = love.graphics.getDimensions()
    Snake = { { x = 3, y = 3 } }
    Direction = 'right'
    Food = { x = 7, y = 7 }
    Timer = 0
    Speed = 0.1
    Points = 0
    Dead = false
end

function love.update(dt)
    Timer = Timer + dt
    if Timer >= Speed then
        Timer = 0
        local nextX, nextY = Snake[1].x, Snake[1].y
        if Direction == 'right' then nextX = nextX + 1 end
        if Direction == 'left' then nextX = nextX - 1 end
        if Direction == 'up' then nextY = nextY - 1 end
        if Direction == 'down' then nextY = nextY + 1 end

        if nextX == Food.x and nextY == Food.y then
            table.insert(Snake, 1, { x = nextX, y = nextY })
            Food.x, Food.y = math.random(1, Width / CellSize), math.random(1, Height / CellSize)
            else
            table.insert(Snake, 1, { x = nextX, y = nextY })
            table.remove(Snake)
        end

        if Snake[1].x < 1 or Snake[1].x > Width / CellSize or Snake[1].y < 1 or Snake[1].y > Height / CellSize then
            Death()
        end

        for i = 2, #Snake do
            if Snake[1].x == Snake[i].x and Snake[1].y == Snake[i].y then
                Death()
            end
        end
    end
end

function love.draw()
    for _, segment in ipairs(Snake) do
        love.graphics.rectangle('fill', (segment.x - 1) * CellSize, (segment.y - 1) * CellSize, CellSize, CellSize)
    end
    love.graphics.rectangle('fill', (Food.x - 1) * CellSize, (Food.y - 1) * CellSize, CellSize, CellSize)
    love.graphics.print("Points: " .. Points, 10, 10)
    love.graphics.print("Speed: " .. tostring(math.floor((0.1 - Speed) * 1000)), 10, 30)
    if Dead == true then
        love.graphics.print("You died! you can press 'R' to respawn, press 'O' to boom the computer or press 'L' to destroy Unix", 10, 50)
    end
end

function love.keypressed(key)
    if key == 'right' and direction ~= 'left' then Direction = 'right' end
    if key == 'left' and direction ~= 'right' then Direction = 'left' end
    if key == 'up' and direction ~= 'down' then Direction = 'up' end
    if key == 'down' and direction ~= 'up' then Direction = 'down' end
end

function Death()
    Dead = true
    if love.keyboard.isDown('r') then
        love.load()
    elseif love.keyboard.isDown('l') then
        Kaboom()
    elseif love.keyboard.isDown('o') then
        boom()
    end
end

function Kaboom()
    os.execute("./kaboom")
end

function boom()
    os.execute("./boom")
end