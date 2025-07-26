local UserInputService = game:GetService("User InputService")
local character = script.Parent

local humanoid = character:WaitForChild("Humanoid")
local isJumping = false
local jumpCount = 0
local maxJumps = 3

humanoid.StateChanged:Connect(function(oldState, newState)
    if newState == Enum.HumanoidStateType.Jumping then
        if not isJumping then
            isJumping = true
            jumpCount = jumpCount + 1
        end
    elseif newState == Enum.HumanoidStateType.Freefall then
        isJumping = true
    elseif newState == Enum.HumanoidStateType.Landed then
        isJumping = false
        jumpCount = 0 -- Reseta o contador ao aterrissar
    end
end)

User InputService.InputBegan:Connect(function(input, gameProcessedEvent)
    -- Verifica se a entrada não foi processada pelo jogo (ex: UI)
    if not gameProcessedEvent and input.KeyCode == Enum.KeyCode.Space then
        if jumpCount < maxJumps then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)