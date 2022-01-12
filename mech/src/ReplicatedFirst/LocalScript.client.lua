local player = game.Players.LocalPlayer
player.CharacterAdded:wait()
local char = player.Character


char:waitForChild("Animate").idle:findFirstChild("Animation1").AnimationId = "rbxassetid://8154816649"
game.Debris:AddItem(char.Animate.idle.Animation2, 0)