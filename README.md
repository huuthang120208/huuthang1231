local ReplicatedStorage = game:GetService("ReplicatedStorage")
local attackEvent = ReplicatedStorage:WaitForChild("PlayerAttack")
local autoAttackEvent = ReplicatedStorage:WaitForChild("AutoAttackEvent")

local function handleAttack(player)
    local character = player.Character
    if character then
        local equippedWeapon = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("EquippedWeapon")
        if equippedWeapon then
            local weaponData = require(game.ReplicatedStorage.Modules.CombatUtil):GetWeaponData(equippedWeapon:GetAttribute("WeaponName"))
            if weaponData and weaponData.WeaponType == "Melee" then
                pcall(function()
                    local enemies = workspace:FindFirstChild("Enemies")
                    if enemies then
                        local args = {
                            [1] = nil, -- Bộ phận của NPC chính
                            [2] = {}   -- Danh sách NPC phụ
                        }
    
                        for _, enemy in pairs(enemies:GetChildren()) do
                            local hitbox = enemy:FindFirstChild("Head")
                            if hitbox then
                                if not args[1] then
                                    -- Gán bộ phận của NPC chính (NPC đầu tiên)
                                    args[1] = hitbox
                                else
                                    -- Thêm các NPC phụ vào danh sách
                                    table.insert(args[2], {
                                        [1] = enemy,
                                        [2] = hitbox
                                    })
                                end
                            end
                        end 
                        if args[1] then
                            local replicatedStorage = game:GetService("ReplicatedStorage")
                            local modulesNet = replicatedStorage:WaitForChild("Modules"):WaitForChild("Net")
                            modulesNet:WaitForChild("RE/RegisterHit"):FireServer(unpack(args))
                            modulesNet:WaitForChild("RE/RegisterAttack"):FireServer("0")
                        end
                    end
                end)
            end
        end
        print(player.Name .. " has attacked!")
    end
end

attackEvent.OnServerEvent:Connect(handleAttack)
autoAttackEvent.OnServerEvent:Connect(handleAttack)
while true do
    handleAttack()
    wait(0.2)
end
