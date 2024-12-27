function CheckRace()
    local v111 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1")
    local v113 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1")
    local playerName = game.Players.LocalPlayer.Name
    local race = game.Players.LocalPlayer.Data.Race.Value
    local fragment = game.Players.LocalPlayer.Data.Fragments.Value
    local thongbao = ""
    if fragment < 13000 then
        thongbao = "số fragment : " .. tostring(fragment) .. "  ( chưa đủ 13k fragment ) @everyone"
    else
        thongbao = "số fragment : " .. tostring(fragment) 
    end
    if game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
        local v229, v228, v227 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeRace", "Check")
            local statusMessage = ""
            if v229 == 1 then
                statusMessage = "Required Train More ( gear 1 )"
            elseif v229 == 0 then
                statusMessage = "Ready for Trial"
            elseif v229 == 2 then
                statusMessage = "Can Buy Gear With " .. v227 .. " Fragments ( gear 1 )"
            elseif v229 == 4 then
                statusMessage = "Can Buy Gear With " .. v227 .. " Fragments ( gear 2 )"
            elseif v229 == 7 then
                statusMessage = "Can Buy Gear With " .. v227 .. " Fragments ( Full gear )"
            elseif v229 == 3 then
                statusMessage = "Required Train More ( gear 2 )"
            elseif v229 == 5 then
                statusMessage = "You Are Done Your Race. ( full gear t10 )"
            elseif v229 == 6 then
                statusMessage = "Upgrades completed: " .. v228 - 2 .. "/3, Need Trains More ( gear 3 )"
            elseif v229 == 8 then
                statusMessage = "Remaining " .. 10 - v228 .. " training sessions. ( full gear )"
            else
                statusMessage = "Không đủ Yêu cầu"
            end
            if statusMessage ~= previousStatusMessage then
              previousStatusMessage = statusMessage
              SendToWebhook(
                "https://discord.com/api/webhooks/1312650928821768212/5nx2ScEE--inMxNOrk2RpAKsPKGR8YCLdrkN8C7JZT6xQkGfHmUQTY7hz1ftLeeepwqW",
                "Thông tin người chơi",
                "Dưới đây là thông tin chi tiết của người chơi:",
                16711680, -- Mã màu đỏ (RGB: #FF0000)
                    {
        { name = "Tên người chơi", value = playerName, inline = true },
        { name = "Chủng tộc", value = race, inline = true },
        { name = "Số fragment", value = tostring(fragment), inline = true },
        { name = "Thông báo", value = thongbao, inline = false }
                }
              )
            else
            print("Không có thay đổi trong statusMessage")
            end
    elseif v113 == -2 then
        SendToWebhook(
            "https://discord.com/api/webhooks/1313208538041946233/JZ8xcremwnzrrefPC7xTi9H0f45dM6qQ74ScolrBt6dJFHyai2pRYi27YclHIQHgFprl",
            "Tên người chơi: " .. playerName .. "\\nThông tin: " .. race .. " V3" .. "\\n" .. thongbao
        )
    elseif v111 == -2 then
        SendToWebhook(
            "https://discord.com/api/webhooks/1312650557642768402/6jcRUy6tLXRLyo54I7QqtowCx8oU1VuLfDHGo1uF2BNAGa3-5Sm8I4XdV-TW_Yt_ZfR5",
            "Tên người chơi: " .. playerName .. "\\nThông tin: " ..  race .. " V2" .. "\\n" .. thongbao .. "\\n@everyone"
        )
    else
        SendToWebhook(
            "https://discord.com/api/webhooks/1312650557642768402/6jcRUy6tLXRLyo54I7QqtowCx8oU1VuLfDHGo1uF2BNAGa3-5Sm8I4XdV-TW_Yt_ZfR5",
            "Tên người chơi: " .. playerName .. "\\nThông tin: " .. race .. " V1" .. "\\n" .. thongbao .. "\\n@everyone"
        )
    end
end
while true do
    wait(20)     
    CheckRace()
    print("Đã check race")
end
