local plr = game.Players.LocalPlayer
TableLocations = {
    ["GhostShipInterior"] = game:GetService("Workspace").Map.GhostShipInterior.TeleportSpawn.Position
}
function toTarget(pos, targetPos, targetCFrame,TpInstant)
    if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.Sit then
        getgenv().noclip = false
        if getgenv().Tween then
            getgenv().Tween:Pause()
            getgenv().Tween:Cancel()
        end
        game.Players.LocalPlayer.Character.Humanoid.Sit = false
        game.Players.LocalPlayer.Character.Humanoid.Jump = true
        plr.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame*CFrame.new(0,10,0)
        return 
    end
    local aaa = 160
    local tween_s = game:service"TweenService"
    local info = TweenInfo.new((targetPos - pos).Magnitude/aaa, Enum.EasingStyle.Quad)
    if game.PlaceId == 4442272183 and (targetPos-game:GetService("Workspace").Map.GhostShipInterior.TeleportSpawn.Position).Magnitude > 3000 and  (game:GetService("Workspace").Map.GhostShipInterior.TeleportSpawn.Position-plr.Character.HumanoidRootPart.Position).Magnitude <= 3000 then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",game:GetService("Workspace").Map.GhostShip.TeleportSpawn.Position)
        return 
    end
    if TableLocations then
        for i,v2 in pairs(TableLocations) do
            if  (targetPos-v2).Magnitude <= 3000 and  (targetPos-plr.Character.HumanoidRootPart.Position).Magnitude >= 3000 then
                if getgenv().Tween then
                    getgenv().Tween:Pause()
                    getgenv().Tween:Cancel()
                end
                args = {
                    "requestEntrance",
                    v2,
                }
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                return 
            end
        end
    end
    if (targetPos-pos).Magnitude >= 3000 and poscheckspawn(targetPos).Name ~= game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value   then
        if getgenv().Tween then
            getgenv().Tween:Pause()
            getgenv().Tween:Cancel()
        end
        plr.Character.LastSpawnPoint.Disabled = true
        local TimeReset = tick()
        repeat task.wait()
            plr.Character.LastSpawnPoint.Disabled = true
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SetLastSpawnPoint", poscheckspawn(targetPos).Name)
            plr.Character.HumanoidRootPart.CFrame = poscheckspawn(targetPos).Part.CFrame
            if tick()-TimeReset >= 3 and plr.Character.Humanoid.Health > 0 then
                plr.Character.Humanoid.Health = 0
                task.wait()
                TimeReset = tick()
            end
        until poscheckspawn(targetPos).Name == game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value or not OrionLib.Flags["Reset Teleport"].Value
        plr.Character.Humanoid.Health = 0
        repeat task.wait()
        until plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 
        return
    end
    if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
        if (targetPos-pos).Magnitude <= 200 and not TpInstant then
            if getgenv().Tween then
                getgenv().Tween:Pause()
                getgenv().Tween:Cancel()
            end
            getgenv().noclip = true
            plr.Character.HumanoidRootPart.CFrame = targetCFrame
        else
            local a = Vector3.new(0,plr.Character:FindFirstChild("HumanoidRootPart").Position.Y,0) 
            local b = Vector3.new(0,game:GetService("Workspace").Map["WaterBase-Plane"].Position.Y,0)
            if (a-b).Magnitude <= 60 then
                plr.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame*CFrame.new(0,20,0)
            end
            getgenv().Tween = tween_s:Create(game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart"), info, {CFrame = targetCFrame})
            getgenv().noclip = true
            getgenv().Tween:Play()
        end
    end
end
toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,boss.HumanoidRootPart.Position,boss.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
