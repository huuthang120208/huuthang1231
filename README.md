repeat task.wait() until game:IsLoaded() and game:GetService("Players") and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui")
repeat task.wait() until game:IsLoaded()
if not game:IsLoaded() then game:IsLoaded():Wait() end
UserSettings():GetService('UserGameSettings').MasterVolume = 0;
settings().Rendering.QualityLevel = 1;
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat,false)
game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)
game:GetService("Lighting").GlobalShadows = false
for key, object in pairs(workspace:GetDescendants()) do
    if object:IsA("Part") or object:IsA("UnionOperation") or object:IsA("MeshPart") then
        object.Material = Enum.Material.SmoothPlastic
    elseif  (object:IsA("Texture") or object:IsA("Explosion") or object:IsA("ColorCorrectionEffect") or 
                object:IsA("Atmosphere") or object:IsA("SunRaysEffect") or object:IsA("BlurEffect") or 
                object:IsA("RainyStone") or object:IsA("Weather")  or object:IsA("BloomEffect")
                or object:IsA("Lighting") or object:IsA("FogEnd") or object:IsA("DepthOfFieldEffect")) then
        object:Destroy()
    end
end
repeat
    task.wait(1)
    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("SetTeam", "Marines") 
until game.Players.LocalPlayer.Team
local playerName = game.Players.LocalPlayer.Name
local function execute_acc_main()
    getgenv().Config = {
        ["Shoot Heart When Ice Spike Breaks"] = true,
        ["Drive Boat To Tiki"] = true,
        ["No Frog"] = true,
        ["Random Devil Fruit"] = true,
        ["Use skill fast dont hold"] = true,
        ["Webhook Shoot Heart Leviathan"] = true,
        ["Input Url Webhook"] = "https://discord.com/api/webhooks/1098320570543779890/sGy7hcOQu5yw_8s_KQiU2htd2ydPGau2EsfNv78H891C7G2xGBJslFdZvBExyJsGjl7E",
        ["Auto Farm Material Sanguine Art"] = false,
        ["Webhook Unlock Draco v4"] = true,
        ["Auto light the torch"] = false,
        ["Use Click M1 Fruit"] = false,
        ["Webhook Destroy IDK"] = true,
        ["Boost Fps"] = false,
        ["Auto Chest Hop"] = false,
        ["Ping Discord"] = true,
        ["Webhook Drive To Tiki/Hydra"] = true,
        ["Drive Boat To Hydra"] = false,
        ["Webhook Find Leviathan"] = true,
        ["Auto Craft Scroll"] = false,
        ["Account Buy Boat"] = true,
        ["Auto Store Fruit"] = true,
        ["Start Hunt Leviathan"] = true
    }
    
    getgenv().Key = "809d79ebbf3806842fac0343"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/obiiyeuem/vthangsitink/refs/heads/main/BananaCat-KaitunLevi.lua"))()
end

local function execute_acc_clone()
    getgenv().Key = "809d79ebbf3806842fac0343"
    getgenv().Config = {
        ["Shoot Heart When Ice Spike Breaks"] = false,
        ["Drive Boat To Tiki"] = false,
        ["No Frog"] = true,
        ["Random Devil Fruit"] = false,
        ["Use skill fast dont hold"] = true,
        ["Select Skills Blox Fruit"] = {},
        ["Webhook Shoot Heart Leviathan"] = false,
        ["Auto Farm Material Sanguine Art"] = false,
        ["Webhook Unlock Draco v4"] = false,
        ["Auto light the torch"] = false,
        ["Webhook Destroy IDK"] = false,
        ["Use Click M1 Fruit"] = false,
        ["Ping Discord"] = false,
        ["Drive Boat To Hydra"] = false,
        ["Select Owner Boat Beast Hunter"] = "BrthyianT132B8",
        ["Boost Fps"] = false,
        ["Webhook Drive To Tiki/Hydra"] = false,
        ["Auto Chest Hop"] = true,
        ["Webhook Find Leviathan"] = false,
        ["Auto Craft Scroll"] = false,
        ["Account Buy Boat"] = false,
        ["Auto Store Fruit"] = false,
        ["Start Hunt Leviathan"] = true
    }
    loadstring(game:HttpGet("https://raw.githubusercontent.com/obiiyeuem/vthangsitink/refs/heads/main/BananaCat-KaitunLevi.lua"))()
end

if playerName == "BrthyianT132B8" then 
    task.wait(150)
    execute_acc_main()
else
    execute_acc_clone()
end
while true do
    task.wait(5)
    if game.PlaceId == 7449423635 then
        break
    end
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
end
