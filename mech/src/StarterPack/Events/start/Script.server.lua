local anims = script.Parent.Parent.Parent.Animations
local replicated_s_m = game:GetService("ReplicatedStorage").MechStuff


activate = false
combo = 1
f_comb = true
s_Combo = 1
s_actiavte = false
equpped = false
tool = nil;

script.Parent.OnServerEvent:Connect(function(plr)
	local char = plr.Character
	local folder = Instance.new("Folder", char); folder.Name = "Stuff"
	local mech = game:GetService("ReplicatedStorage").MechStuff.Mech:Clone()
	mech.Parent = char
	for _, thing in pairs(mech:GetChildren())do
		thing.CanCollide = false
	end
	local mech_p = mech.BodyAttach
	mech_p.CFrame = char["Right Arm"].CFrame
	local weld = Instance.new("Weld", mech_p); weld.Part0 = mech_p; weld.Part1 = char["Right Arm"]
	----------- Wep handle part
	local wep_p = Instance.new("Part", char.Stuff); wep_p.Position = char["Right Arm"].Position; 
	wep_p.Name = "handle"
	wep_p.Size = Vector3.new(.5,.5,.5)
	wep_p.Transparency = 1
	local motor = Instance.new("Motor6D", wep_p); motor.Part0 = wep_p; motor.Part1 = char["Right Arm"]
	motor.C0 = CFrame.new(0, 1, 0)
	----------- back part
	local back_p = Instance.new("Part", char.Stuff); back_p.Size = Vector3.new(.5,.5,.5)
	back_p.Name = "back_p"
	back_p.Position = char["HumanoidRootPart"].Position
	back_p.Transparency = 1
	local weld1 = Instance.new("Weld", back_p); weld1.Part0 = back_p; weld1.Part1 = char["HumanoidRootPart"]
	weld1.C0 = CFrame.new(0,0,-.55)
	----------- wep activating checker
	local checker = Instance.new("BoolValue", char.Stuff); checker.Name = "WepCheck"; checker.Value = false
	-----------
end)

script.Parent.Parent.Mech.OnServerEvent:Connect(function(plr, act1, act2, act3)
	local char = plr.Character

	if act1 == "MechON" then
		if char.Stuff:FindFirstChild("Deb") ~= nil then
			activate = false
			game.Debris:AddItem(char.Stuff:findFirstChild("Deb"), 0)
			local animator = char.Humanoid:waitForChild("Animator")
			local ree = animator:LoadAnimation(anims["Thing"])
			local end_ = animator:LoadAnimation(anims["ending"])
			end_.Looped = false
			local tracks = char.Humanoid:GetPlayingAnimationTracks()
			for _, thing in pairs(tracks) do
				if thing.Name == "ending" then
					thing:Stop()
				end
			end
		else
			activate = true
			local deb = Instance.new("BoolValue", char.Stuff); deb.Name = "Deb"
			local animator = char.Humanoid:waitForChild("Animator")
			local ree = animator:LoadAnimation(anims["Thing"])
			local end_ = animator:LoadAnimation(anims["ending"])
			ree.Priority = Enum.AnimationPriority.Action
			end_.Priority = Enum.AnimationPriority.Action
			ree:Play()
			ree:AdjustSpeed(0.5)
			task.wait(ree.Length)
			ree:Stop()
			end_:Play()
			----- particle stuff
			if (s_actiavte == true )then
				local prtcle = replicated_s_m.EF.Af_ex:clone()
				prtcle.Parent = tool:FindFirstChild("Blade")
			end
		end
	elseif act1 == "EQ" then
		if s_Combo == 1 and char.Stuff:findFirstChild("Comb") == nil and char.Stuff["WepCheck"].Value == false then
			char.Stuff["WepCheck"].Value = true
			--s_actiavte = true
			local comb = Instance.new("BoolValue"); comb.Name = "Comb"
			local swing1 = char.Humanoid:waitForChild("Animator"):LoadAnimation(anims["Delete Attack"])
			char.Humanoid.WalkSpeed = 0
			swing1:Play()
			swing1:AdjustSpeed(.5)
			task.wait((swing1.Length) * 3)
			swing1:Stop()
			char.Humanoid.WalkSpeed = 16
			game.Debris:AddItem(comb, 0)
			--s_actiavte = false
		end 
	elseif act1 == "Combat" then
		if combo == 1 and char.Stuff:findFirstChild("Comb") == nil and f_comb == true then
			combo = 2
			local comb = Instance.new("BoolValue"); comb.Name = "Comb"
			local punch1 = char.Humanoid:waitForChild("Animator"):LoadAnimation(anims["Punch left"])
			punch1.Priority = Enum.AnimationPriority.Action		
			char.Humanoid.WalkSpeed = 0
			punch1:Play()
			punch1:AdjustSpeed(0.5)
			task.wait((punch1.Length) * 3)
			punch1:Stop()
			char.Humanoid.WalkSpeed = 16
			game.Debris:AddItem(comb, 0)
		elseif combo == 2 and char.Stuff:findFirstChild("Comb") == nil  and f_comb == true then
			combo = 1
			local comb = Instance.new("BoolValue"); comb.Name = "Comb"
			local punch = char.Humanoid:waitForChild("Animator"):LoadAnimation(anims["Mech Punch"])
			punch.Priority = Enum.AnimationPriority.Action
			char.Humanoid.WalkSpeed = 0
			punch:Play()
			punch:AdjustSpeed(0.5)
			task.wait((punch.Length) * 3 )
			punch:Stop()
			char.Humanoid.WalkSpeed = 16
			game.Debris:AddItem(comb, 0)
		end
		local region = Region3.new(act2-Vector3.new(1.5,1.5,1.5), act2+Vector3.new(1.5,1.5,1.5))
		local regist = workspace:FindPartsInRegion3WithIgnoreList(region, {char}, 20)
		for _, thing in pairs(regist) do
			if thing.Parent:findFirstChild("Humanoid") and thing.Parent:findFirstChild("Deb") == nil then
				local deb = Instance.new("BoolValue", thing); deb.Name = "Deb"
				if activate ~= true then
					thing.Parent.Humanoid:TakeDamage(2.5)
				else
					thing.Parent.Humanoid:TakeDamage(5)
				end
				game.Debris:AddItem(deb, 0)
			end
		end
	end
end)
