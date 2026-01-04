-- Safe Animation Loader
-- Only runs in Roblox environment
-- Version: v1.0

local function SafeAnimationLoader(animId, keybind)
    -- Check for Roblox environment
    if not game or not Instance then
        warn("[SafeAnimationLoader] Not running inside Roblox. Aborting.")
        return
    end

    -- Services
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")

    -- Get local player
    local player = Players.LocalPlayer
    if not player then
        warn("[SafeAnimationLoader] LocalPlayer not found.")
        return
    end

    -- Wait for character and humanoid
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then
        warn("[SafeAnimationLoader] Humanoid not found in character.")
        return
    end

    -- Get or create animator
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Name = "SafeAnimator"
        animator.Parent = humanoid
    end

    -- Create animation instance
    local animation = Instance.new("Animation")
    animation.Name = "SafeAnimation"
    animation.AnimationId = "rbxassetid://" .. tostring(animId)

    local track = animator:LoadAnimation(animation)
    track.Looped = false

    -- Default keybind is E if none provided
    keybind = keybind or Enum.KeyCode.E

    -- Connect keybind
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == keybind then
            if track.IsPlaying then
                track:Stop()
            else
                track:Play()
            end
        end
    end)

    print("[SafeAnimationLoader] Animation loaded. Press " .. tostring(keybind) .. " to play.")
end

-- Example usage:
SafeAnimationLoader(8687587407, Enum.KeyCode.E)
