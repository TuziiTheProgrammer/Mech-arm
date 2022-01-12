local player = script.Parent.Parent
player.CharacterAdded:wait()
local char = player.Character
local os_ = os.time()
local mouse = player:GetMouse()
script.Parent.Events.start:FireServer()


mouse.Button1Down:connect(function()
	if char:findFirstChild("Stuff")["WepCheck"].Value == false then
		if os.time() - os_ >= 1.5 then
			os_ = os.time()
			script.Parent.Events.Mech:FireServer("Combat", (char.HumanoidRootPart.CFrame*CFrame.new(0,0,-1.5)).p)
		end
	end	
end)

game:GetService("UserInputService").InputBegan:connect(function(inpu, pro)
	if pro then return end
	if os.time() - os_ >= 3 then
		os_ = os.time()
		if inpu.UserInputType == Enum.UserInputType.Keyboard then
			local key = inpu.KeyCode
			if key == Enum.KeyCode.E then				
				script.Parent.Events.Mech:FireServer("MechON")
			end
		end
	end
end)

