local playerName = game.Players.LocalPlayer.Name
local fileName = playerName .. ".txt"
local requiredCount = 2 -- nhập số lượng đai cần change
local belts = {
    "Dojo Belt (White)",
    "Dojo Belt (Yellow)",
    "Dojo Belt (Orange)",
    "Dojo Belt (Green)",
    "Dojo Belt (Blue)",
    "Dojo Belt (Purple)",
    "Dojo Belt (Red)",
    "Dojo Belt (Black)"
}

function CheckItemInventory(itemName)
    for _, item in pairs(game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("getInventory")) do
        if item.Name == itemName then
            return true
        end
    end
    return false
end

while task.wait(10) do
    local beltCount = 0
    for _, beltName in ipairs(belts) do
        if CheckItemInventory(beltName) then
            beltCount = beltCount + 1 
        end
    end

    if beltCount >= requiredCount then
        writefile(fileName, "Completed-" .. requiredCount .. "_đai")
        break -- Dừng sau khi đủ
    else
        print("chưa đủ " .. requiredCount .. " Đai, hiện tại có: " .. beltCount)
    end
end
