task.spawn(function()
	local plr_settings = Instance.new("Folder", game:GetService("Players").LocalPlayer)

	plr_settings.Name = "CommandSettings"

	local bool1 = Instance.new("BoolValue", plr_settings)

	bool1.Name = "SpawnEntities"
	bool1.Value = true
end)

game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
	if msg == "/crash" then
		while true do
			game:GetService("ReplicatedStorage").SpawnEntity:FireServer("X-183")
		end
	elseif msg:find("/spawn") then
		local split = msg:split(" ")

		if split[2] then
			game:GetService("ReplicatedStorage").SpawnEntity:FireServer(tostring(split[2]))
		end
	elseif msg == "/loopkick" then
		while task.wait() do
			for _, v in pairs(game:GetService("Players"):GetPlayers()) do
				if v ~= game.Players.LocalPlayer then
					game:GetService("ReplicatedStorage").KickPlayer:FireServer(tostring(v.Name), "Kicked by Admin.")
				end
			end
		end
	elseif msg:find("/kick") then
		local split = msg:split(" ")
		
		if split[2] then
			game:GetService("ReplicatedStorage").KickPlayer:FireServer(tostring(split[2]), "Kicked by admin.")
		end
	elseif msg:find("/serverban") then
		local split = msg:split(" ")
		
		if split[2] then
			while task.wait(0.02) do
				game:GetService("ReplicatedStorage").KickPlayer:FireServer(tostring(split[2]), "Banned by admin.")
			end
		end
	elseif msg:find("/spawnEntities") then
		local split = msg:split(" ")
		
		if split[2] then
			if tostring(split[2]):find("Disable") then
				bool1.Value = false
			elseif tostring(split[2]):find("Enable") then
				bool1.Value = true
			end
		end
		
		task.spawn(function()
			if bool1.Value == true then
				repeat
					for _, v in pairs(workspace:WaitForChild("Entities"):GetChildren()) do
						if v:IsA("Model") then
							game:GetService("ReplicatedStorage"):WaitForChild("DeleteEntity"):FireServer(tostring(v.Name))
						end
					end
					
					task.wait()
				until bool1.Value == false
			end
		end)
	elseif msg == "/staffBan" then
		while task.wait() do
			for _, v in pairs(game:GetService("Players"):GetPlayers()) do
				if v ~= game.Players.LocalPlayer then
					local rank = v:GetRoleInGroup(36007169)

					if rank ~= "Member" and rank ~= "Guest" then
						game:GetService("ReplicatedStorage").KickPlayer:FireServer(tostring(v.Name), "Banned from server.")
						print("Staff Found: "..tostring(v.Name..";"..v.UserId))
					end
 				end
			end
		end
	elseif msg == "/godmode" then
		game:GetService("ReplicatedStorage").Immunity:FireServer(tostring(game:GetService("Players").LocalPlayer.Name))
	end
 end)

warn("Commands Loaded! (Press F9 to close menu). [V1.0.2]")
