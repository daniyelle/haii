-- animation test (anti-cheat)
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local Animator = Humanoid:FindFirstChildOfClass("Animator")
if not Animator then
	Animator = Instance.new("Animator")
	Animator.Parent = Humanoid
end

local TestAnimation = Instance.new("Animation")
TestAnimation.AnimationId = "rbxassetid://8687587407"

local TestTrack = Animator:LoadAnimation(TestAnimation)
TestTrack.Looped = false
TestTrack.Priority = Enum.AnimationPriority.Action

local TEST_KEY = Enum.KeyCode.E
local lastPlay = 0
local COOLDOWN = 0.5 -- helps test spam detection

UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode ~= TEST_KEY then return end

	-- debounce / cooldown
	if os.clock() - lastPlay < COOLDOWN then
		return
	end
	lastPlay = os.clock()

	if TestTrack.IsPlaying then
		TestTrack:Stop()
	else
		TestTrack:Play()
	end
end)
