repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players
repeat task.wait() until game.Players.LocalPlayer
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui")
spawn(function()
    while task.wait(1) do
        if game:GetService("CoreGui").RobloxPromptGui.promptOverlay:FindFirstChild("ErrorPrompt") and not string.find(game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ErrorPrompt.MessageArea.ErrorFrame.ErrorMessage
                .Text, "Server is full") then
            game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
        end
    end
end)

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
                        if success and constants and table.find(constants, "Pirates") then
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
spawn(function()
    while true do  
        if game.PlaceId == 2753915549 or game.PlaceId == 7449423635 then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
        end
        task.wait(5)
    end
end)
spawn(function()
    while game:GetService("Players").LocalPlayer.Character and not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") do
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
        if game.Players.LocalPlayer.Character.Humanoid.Sit then
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jump = true 
        end           
        wait(5)
    end
end)
spawn(function()
    while task.wait() do
        pcall(function() 
            if not game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
                task.wait(3)
            end
        end)
    end
end)
local VirtualUser = game:GetService('VirtualUser')

game:GetService('Players').LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
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
        wait(0.5)
    end
end
--[[
local function CheckJobIdServer()
    return {} 
end
local SettingHopServer = SettingHopServer or {}
local function JoinPlayerServer()
    for i = 1, 100 do
        local success, huhu = pcall(function()
            return game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer(i)
        end)

        if success and type(huhu) == "table" then
            for k, v in pairs(huhu) do
                if type(v) == "table" and v.Count and v.Count >= 10 and k ~= game.JobId and not table.find(CheckJobIdServer(), k) then
                    -- Thực hiện chuyển server
                    game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", k)

                    -- Ghi dữ liệu vào file JSON
                    local HttpService = game:GetService("HttpService")
                    writefile(FolderName .. "/Jobid.json", HttpService:JSONEncode(SettingHopServer))
                end
            end
        else
            warn("Failed to retrieve server data for index: " .. i)
        end
    end
end
]]
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
    local aaa = 200
    local tween_s = game:service"TweenService"
    local info = TweenInfo.new((targetPos - pos).Magnitude/aaa, Enum.EasingStyle.Quad)
    if game.PlaceId == 4442272183 and (targetPos-game:GetService("Workspace").Map.GhostShipInterior.TeleportSpawn.Position).Magnitude > 3000 and  (game:GetService("Workspace").Map.GhostShipInterior.TeleportSpawn.Position-plr.Character.HumanoidRootPart.Position).Magnitude <= 3000 then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",game:GetService("Workspace").Map.GhostShipInterior.TeleportSpawn.Position)
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
    if (targetPos-pos).Magnitude >= 3000 and poscheckspawn(targetPos).Name ~= game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value  then
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
        until poscheckspawn(targetPos).Name == game:GetService("Players").LocalPlayer.Data.LastSpawnPoint.Value 
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
getgenv().GetBladeHits = function()
    local targets = {}
    local function GetDistance(v)
        return (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    end
    for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Head") and v:FindFirstChild("Humanoid") then
            if GetDistance(v.HumanoidRootPart.CFrame) < 60 then
                table.insert(targets, v)
            end
        end
    end
    return targets
end

getgenv().AttackAll = function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    
    if not character then return end
    
    local equippedWeapon = character:FindFirstChild("EquippedWeapon")
    if not equippedWeapon then return end
    
    local weaponData = require(game.ReplicatedStorage.Modules.CombatUtil):GetWeaponData(equippedWeapon:GetAttribute("WeaponName"))
    if not weaponData or weaponData.WeaponType ~= "Melee" then return end
    
    local enemies = GetBladeHits()
    if #enemies > 0 then
        local replicatedStorage = game:GetService("ReplicatedStorage")
        local netModule = replicatedStorage:WaitForChild("Modules"):WaitForChild("Net")
        
        netModule:WaitForChild("RE/RegisterAttack"):FireServer(-math.huge)
        
        local args = {nil, {}}
        for i, v in pairs(enemies) do
            if not args[1] then
                args[1] = v.Head
            end
            args[2][i] = {
                [1] = v,
                [2] = v.HumanoidRootPart
            }
        end
        
        netModule:WaitForChild("RE/RegisterHit"):FireServer(unpack(args))
        netModule:WaitForChild("RE/RegisterAttack"):FireServer(-math.huge)
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
            print("không có boss")
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
function checklocation()
    local teleportLocation = game:GetService("Workspace").Map.GhostShipInterior.TeleportSpawn.Position
    local teleportRadius = 1000 
    local function isPlayerNearLocation(playerPosition, targetPosition, radius)
        return (playerPosition - targetPosition).Magnitude <= radius
    end
    if not isPlayerNearLocation(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, teleportLocation, teleportRadius) then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", teleportLocation)
    end
end
function DetectMob(c)
    local dist = math.huge
    local name 
    for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
        local stringgsub = v.Name:gsub(" %pLv. %d+%p", "")
        if  ((typeof(c) == "table" and (table.find(c, v.Name) or table.find(c, stringgsub))) or (v.Name == c or c == stringgsub)) and v:IsA('Model') and v:FindFirstChild('Humanoid') and v.Humanoid.Health > 0 and v:FindFirstChild('HumanoidRootPart') then
            local magnitude = (v.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude
            if magnitude < dist then
                dist = magnitude
                name = v
            end
        end
    end
    return name
end
local Mob = {}
Mob = {
    "Ship Deckhand",
    "Ship Steward",
    "Ship Officer",
    "Ship Engineer",
    "Cursed Captain"
}
function GetGhoul()
    if game:GetService("Players").LocalPlayer.Data.Race.Value  ~= "Ghoul" then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "Change", 4)
        task.wait()
        if game:GetService("Players").LocalPlayer.Data.Race.Value  ~= "Ghoul" then
            checklocation()
            task.wait()
            if not checkcountitem("Ectoplasm", 100) then
                local boss = DetectMob(Mob)
                while boss do
                    task.wait()
                    EnableNoClip()
                    EquipWeapon(NameWeapon("Melee"))
                    toTarget(
                        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,
                        boss.HumanoidRootPart.Position,
                        boss.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0)
                    )
                    if (plr.Character.HumanoidRootPart.Position - boss.HumanoidRootPart.Position).Magnitude < 50 then
                        AttackAll()
                    end
                    if not boss or not boss.Parent or boss.Humanoid.Health == 0 then
                        boss = DetectMob(Mob)
                    end
                end      
            elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Hellfire Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Hellfire Torch") then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 4)
            else
                if CheckNameBoss("Cursed Captain") then
                    local boss  = CheckNameBoss("Cursed Captain") 
                    if boss then
                        repeat task.wait()
                            EnableNoClip()
                            EquipWeapon(NameWeapon("Melee"))
                            toTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,boss.HumanoidRootPart.Position,boss.HumanoidRootPart.CFrame*CFrame.new(7,20,0))
                            if (plr.Character.HumanoidRootPart.Position-boss.HumanoidRootPart.Position).Magnitude < 50 then
                                AttackAll()
                            end
                        until not boss  or not boss.Parent or boss.Humanoid.Health == 0 
                    end
                else
                    task.wait(5)
                    JoinRandomLowPlayerServer()
                end
            end
        end
    else
        print("Đã có tộc Ghoul")
        task.wait(300)
    end
end
spawn(function()
    while task.wait() do 
        pcall(function()
            GetGhoul()
        end)
    end
end)
