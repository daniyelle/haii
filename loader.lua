local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

-- Get the animator (best practice)
local animator = humanoid:FindFirstChildOfClass("Animator") 
if not animator then
    animator = Instance.new("Animator")
    animator.Parent = humanoid
end

-- Animation ID
local animId = "rbxassetid://8687587407"

-- Load animation safely
local function playAnim()
    local animation = Instance.new("Animation")
    animation.AnimationId = animId
    local track = animator:LoadAnimation(animation)
    track:Play()
end

-- Example keybind (press E)
game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.E then
        playAnim()
    end
end)
