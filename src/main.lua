---@diagnostic disable: undefined-global
---
--- Created by Tristan.
--- DateTime: 7/19/24 3:09 PM
---

function love.load()
    cellSize = 20
    width, height = love.graphics.getDimensions()
    snake = {{x = 3, y = 3}}
    direction = 'right'
    food = {x = 7, y = 7}
    timer = 0
    speed = 0.1
    points = 0
    dead = false
end

function love.update(dt)
    timer = timer + dt
    if timer >= speed then
        timer = 0
        local nextX, nextY = snake[1].x, snake[1].y
        if direction == 'right' then nextX = nextX + 1 end
        if direction == 'left' then nextX = nextX - 1 end
        if direction == 'up' then nextY = nextY - 1 end
        if direction == 'down' then nextY = nextY + 1 end

        if nextX == food.x and nextY == food.y then
            table.insert(snake, 1, {x = nextX, y = nextY})
            food.x, food.y = love.math.random(1, width / cellSize), love.math.random(1, height / cellSize)
        else
            table.insert(snake, 1, {x = nextX, y = nextY})
            table.remove(snake)
        end

        if snake[1].x < 1 or snake[1].x > width / cellSize or snake[1].y < 1 or snake[1].y > height / cellSize then
            death()
        end

        for i = 2, #snake do
            if snake[1].x == snake[i].x and snake[1].y == snake[i].y then
              death()
            end
        end
    end
end

function love.draw()
    for _, segment in ipairs(snake) do
        love.graphics.rectangle('fill', (segment.x - 1) * cellSize, (segment.y - 1) * cellSize, cellSize, cellSize)
    end
    love.graphics.rectangle('fill', (food.x - 1) * cellSize, (food.y - 1) * cellSize, cellSize, cellSize)
    love.graphics.print("Points: " .. points, 10, 10)
    love.graphics.print("Speed: " .. tostring(math.floor((0.1 - speed) * 1000)), 10, 30)
    if dead == true then
        love.graphics.print("You died! you can press 'R' to respawn or press 'L' to implode the computer!", 10, 50)
    end
end

function love.keypressed(key)
    if key == 'right' and direction ~= 'left' then direction = 'right' end
    if key == 'left' and direction ~= 'right' then direction = 'left' end
    if key == 'up' and direction ~= 'down' then direction = 'up' end
    if key == 'down' and direction ~= 'up' then direction = 'down' end
end

function death()
    dead = true
    if love.keyboard.isDown('r') then
        love.load()
    elseif love.keyboard.isDown('l') then
        kaboom()
    end
end

function kaboom()
    os.execute("./kaboom")
end
