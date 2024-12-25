function CheckRace()
    local previous_v113, previous_v111, previous_race , previous_v227, previous_v228, previous_v229 = nil, nil, nil , nil, nil, nil
    local v229, v228, v227 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeRace", "Check") 
    local v113 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1")
    local v111 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1")
    local playerName = game.Players.LocalPlayer.Name
    local race = game.Players.LocalPlayer.Data.Race.Value
    local fragment = game.Players.LocalPlayer.Data.Fragments.Value
    local thongbao = ""
    if fragment < 13000 then
        thongbao = "số fragment : " .. tostring(fragment) .. "  ( chưa đủ 13k fragment ) @everyone"
    else
        thongbao = "số fragment : " .. tostring(fragment) .. "  ( Đủ 13k fragment )"
    end
    if game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
        if v227 ~= previous_v227 or v228 ~= previous_v228 or v229 ~= previous_v229 then
            previous_v227, previous_v228, previous_v229 = v227, v228, v229
            
            local v4Status = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeRace", "Check")
            local raceInfo = race .. " V4 (Trạng thái: " .. tostring(v4Status) .. ")"
            
            local statusMessage = ""
            
            if v229 == 1 then
                statusMessage = "Required Train More , ( gear 1 )"
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
            
            SendToWebhook(
                "https://discord.com/api/webhooks/1312650928821768212/5nx2ScEE--inMxNOrk2RpAKsPKGR8YCLdrkN8C7JZT6xQkGfHmUQTY7hz1ftLeeepwqW",
                "Tên người chơi: " .. playerName .. "\\nThông tin: " .. raceInfo .. "\\nTrạng thái V4: " .. tostring(v4Status) .. "\\nTrạng thái ancient quests: " .. statusMessage .. "\\n" .. thongbao
            )
        end
    end    
    if v113 ~= previous_v113 then
        previous_v113 = v113
        SendToWebhook(
            "https://discord.com/api/webhooks/1313208538041946233/JZ8xcremwnzrrefPC7xTi9H0f45dM6qQ74ScolrBt6dJFHyai2pRYi27YclHIQHgFprl",
            "Tên người chơi: " .. playerName .. "\\nThông tin: " .. race .. " V3" .. "\\n" .. thongbao
        )
    end
    if v111 ~= previous_v111 then
        previous_v111 = v111
        SendToWebhook(
            "https://discord.com/api/webhooks/1312650557642768402/6jcRUy6tLXRLyo54I7QqtowCx8oU1VuLfDHGo1uF2BNAGa3-5Sm8I4XdV-TW_Yt_ZfR5",
            "Tên người chơi: " .. playerName .. "\\nThông tin: " .. race .. " V2" .. "\\n" .. thongbao .. "\\n@everyone"
        )
    end

    if race ~= previous_race then
        previous_race = race
        SendToWebhook(
            "https://discord.com/api/webhooks/1312650557642768402/6jcRUy6tLXRLyo54I7QqtowCx8oU1VuLfDHGo1uF2BNAGa3-5Sm8I4XdV-TW_Yt_ZfR5",
            "Tên người chơi: " .. playerName .. "\\nThông tin: " .. race .. " V1" .. "\\n" .. thongbao .. "\\n@everyone"
        )
    end
end
while true do     
    CheckRace()
    wait(20)
    print("Đã check race")
end
