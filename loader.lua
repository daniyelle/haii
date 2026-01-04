local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- get animator (best practice)
local animator = humanoid:FindFirstChildOfClass("Animator")
if not animator then
    animator = Instance.new("Animator")
    animator.Parent = humanoid
end

-- load animation ONCE
local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://8687587407"

local track = animator:LoadAnimation(animation)
track.Looped = false

-- keybind
local KEY = Enum.KeyCode.E

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == KEY then
        if track.IsPlaying then
            track:Stop()
        else
            track:Play()
        end
    end
end)
