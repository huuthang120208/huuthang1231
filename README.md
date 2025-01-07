do
    do
        repeat
            local player = game:GetService("Players").LocalPlayer
            local mainGui = player.PlayerGui:FindFirstChild("Main (minimal)")
            if mainGui then
                local ChooseTeam = mainGui:FindFirstChild("ChooseTeam", true)
                if ChooseTeam and ChooseTeam.Visible then
                    for i, v in pairs(getgc()) do
                        if type(v) == "function" then
                            local success, constants = pcall(getconstants, v)
                            if success and constants and table.find(constants, "Marines") then
                                pcall(function()
                                    v(shared.Team or "Marines")
                                end)
                            end
                        end
                    end
                end
            end
            wait(1)
        until game.Players.LocalPlayer.Team
        repeat wait() until game.Players.LocalPlayer.Character
     end
end
spawn(function()
    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
        wait(5)
    end
end)
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local PlaceId = 4442272183 
local function GetServerList(cursor)
    local url = "https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    if cursor then
        url = url .. "&cursor=" .. cursor
    end

    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)

    if success then
        return result
    else
        warn("Không lấy được server", result)
        return nil
    end
end
local function JoinRandomLowPlayerServer()
    local cursor = nil
    local serverFound = false

    while not serverFound do
        local servers = GetServerList(cursor)
        if servers and servers.data then
            local eligibleServers = {}
            for _, server in ipairs(servers.data) do
                if server.playing >= 1 and server.playing <= 10 then
                    table.insert(eligibleServers, server)
                end
            end
            if #eligibleServers > 0 then
                local randomServer = eligibleServers[math.random(1, #eligibleServers)]
                print("Đang tham gia vào server ID: " .. randomServer.id .. " với số người chơi: " .. randomServer.playing)
                
                local success, errorMessage = pcall(function()
                    TeleportService:TeleportToPlaceInstance(PlaceId, randomServer.id, Players.LocalPlayer)
                end)

                if success then
                    serverFound = true
                else
                    print("Không thể tham gia server: ", errorMessage)
                end
            end
        end

        if servers and servers.nextPageCursor then
            cursor = servers.nextPageCursor 
        else
            break
        end
        wait(0.1)
    end
end
function checkcountitem(x,xx)
    for i,v in next,game.ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory") do
        if v.Name == x and v.Count >= xx then
            return true
        end
    end
    return false
end
function poscheckspawn(pos)
    dist = math.huge
    local name
    for i,v in next,game:GetService("Workspace")["_WorldOrigin"].PlayerSpawns.Pirates:GetChildren() do
        if v:IsA("Model") then
            local magnitude = (v.Part.Position - pos).magnitude
            if magnitude < dist then
                dist = magnitude
                name = v
            end
        end
    end
    return name
end
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
local function DisableNoClip()
	if NoClipConnection then
		NoClipConnection:Disconnect()
		NoClipConnection = nil
	end
end

local function EnableNoClip()
	DisableNoClip()

	NoClipConnection = game:GetService("RunService").Stepped:Connect(function()
		if not game:GetService("Players").LocalPlayer.Character then
			return
		end

		for _, Item in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
			if Item:IsA("BasePart") and Item.CanCollide then
				Item.CanCollide = false
			end
		end
	end)
end
function CheckNameBoss(bossName)
    local enemies = game:GetService("Workspace").Enemies
    if enemies:FindFirstChild(bossName) then
        local boss = enemies[bossName]
        if boss:IsA("Model") and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
            print("Boss được tìm thấy: ", boss.Name)
            return boss
        else
            print("Boss tồn tại nhưng không thỏa mãn điều kiện (Model hoặc Humanoid).")
        end
    else
        print("Không tìm thấy boss trong Workspace.Enemies.")
    end
    return nil
end
function EquipWeapon(ToolSe)
    if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
        getgenv().tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
        wait(.1)
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
    end
end
function NameWeapon(x)
    local a 
    for i,v in next, game.Players.LocalPlayer.Backpack:GetChildren() do
        if v:IsA("Tool") and v.ToolTip == x  then
            a = v.Name
        end
    end
    for i,v in next, game.Players.LocalPlayer.Character:GetChildren() do
        if v:IsA("Tool") and v.ToolTip == x  then
            a = v.Name
        end
    end
    return a 
end
function GetGhoul()
    if not checkcountitem("Ectoplasm",100) then
        print("Không đủ Ectoplasm")
        task.wait(3)
        return 
    end
    if game.Players.LocalPlayer.Backpack:FindFirstChild("Hellfire Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Hellfire Torch") then
        if (CFrame.new(918.615234,122.202454,33454.3789,-0.999998808,0,0.00172644004,0,1,0,-0.00172644004,0,-0.999998808).Position-plr.Character.HumanoidRootPart.Position).Magnitude <= 8 then 
            local args = {
                [1] = "Ectoplasm",
                [2] = "BuyCheck",
                [3] = 4
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            v352 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 4)
        else
            toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,CFrame.new(918.615234,122.202454,33454.3789,-0.999998808,0,0.00172644004,0,1,0,-0.00172644004,0,-0.999998808).Position,CFrame.new(918.615234,122.202454,33454.3789,-0.999998808,0,0.00172644004,0,1,0,-0.00172644004,0,-0.999998808))
        end
    else
        if CheckNameBoss("Cursed Captain") then
            local boss  = CheckNameBoss("Cursed Captain")
            if boss then
                repeat task.wait()
                    EnableNoClip()
                    toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,boss.HumanoidRootPart.Position,boss.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
                    if (plr.Character.HumanoidRootPart.Position-boss.HumanoidRootPart.Position).Magnitude < 50 then
                        print("đánh nè đánh nè")
                    end
                    EquipWeapon(NameWeapon("Melee"))
                until not boss  or not boss .Parent or boss.Humanoid.Health == 0 
                task.wait(2)
            end
        else
            JoinRandomLowPlayerServer()
        end
    end
end
    
spawn(function()
    while task.wait() do 
        pcall(function()
            GetGhoul()
        end)
    end
end)
