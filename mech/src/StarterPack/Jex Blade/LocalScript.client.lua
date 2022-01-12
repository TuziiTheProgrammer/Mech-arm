local player = game:GetService("Players").LocalPlayer
local anims = script.Parent.Parent.Animations
player.CharacterAdded:wait()
local char = player.Character
local events = script.Parent.Parent:FindFirstChild("Events")
local mouse = player:GetMouse()
local t = os.time()



script.Parent.Equipped:Connect(function()	
	char.Stuff["WepCheck"].Value = true;
	local hold = char.Humanoid:waitForChild("Animator"):LoadAnimation(anims["Hold"])
	hold.Priority = Enum.AnimationPriority.Action
	hold.Looped = true
	hold:Play()
	mouse.Button1Down:connect(function()
		if os.time() - t >= 3 then
			t = os.time()
			events.Mech:FireServer("EQ", script.Parent)
		end
		print(char.Stuff["WepCheck"].Value)
	end)
end)


script.Parent.Unequipped:Connect(function()
	char.Stuff["WepCheck"].Value = false;
	for _, thing in pairs(char.Humanoid:GetPlayingAnimationTracks())do
		if thing.Name == "Hold" then
			thing:Stop()
		end
	end
end)






