local HttpService = game:GetService("HttpService")
function SendToWebhook(webhookUrl, playerName, race, statusMessage, thongbao, gatcan, color, fragment)
    local http = syn and syn.request or http_request or request or nil
    local currentTime = os.date("%Y-%m-%d %H:%M:%S")
    local embed = {
        title = "Thông tin người chơi",
        description = "Tên người chơi: **" .. playerName .. "**\n" ..
                      "Tộc: **" .. race .. "**\n" ..
                      "Trạng thái ancient quests: **" .. statusMessage .. "**\n" ..
                      "số fragment : **" .. thongbao .. "**\n" ..
                      "Gạt cần : **" .. gatcan .. "**\n",  
        color = color,  
        footer = {
            text = "Time : " .. currentTime,
        }
    }

    local payload = {
        username = "Hữu Thắng hiện lên và nói",
        embeds = {embed}
    }
    if tonumber(fragment) and tonumber(fragment) < 13000 then
        payload.content = "@everyone"  
    end

    local success, response = pcall(function()
        return http({
            Url = webhookUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(payload)
        })
    end)
end

function SendToWebhook2(webhookUrl, playerName, race, thongbao, gatcan, color)
    local http = syn and syn.request or http_request or request or nil
    local currentTime = os.date("%Y-%m-%d %H:%M:%S")
    local embed = {
        title = "Thông tin người chơi",
        description = "Tên người chơi: **" .. playerName .. "**\n" ..
                      "Tộc: **" .. race .. "**\n" ..
                      "số fragment : **" .. thongbao .. "**\n" ..
                      "Gạt cần : **" .. gatcan .. "**\n",  
        color = color,  
        footer = {
            text = "Time : " .. currentTime,
        }
    }

    local payload = {
        username = "Hữu Thắng hiện lên và nói",
        embeds = {embed}
    }
    local success, response = pcall(function()
        return http({
            Url = webhookUrl,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = HttpService:JSONEncode(payload)
        })
    end)
end

local previousStatusMessage = ""
function CheckRace()
    local v111 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1")
    local v113 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1")
    local playerName = game.Players.LocalPlayer.Name
    local race = game.Players.LocalPlayer.Data.Race.Value
    local thongbao = ""
    local gatcan = ""

    local fragment = game.Players.LocalPlayer.Data.Fragments.Value
    if fragment < 13000 then
        thongbao = tostring(fragment) .. "  ( chưa đủ 13k fragment ) @everyone"
    else
        thongbao = tostring(fragment) 
    end

    if game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("CheckTempleDoor") == true then
      gatcan = "Đã Gạt cần "
    else
      gatcan = "Chưa Gạt cần "
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
                statusMessage = "You Are Done Your Race. ( full gear tier 10 )"
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
                playerName,
                race .. " V4",
                statusMessage,
                thongbao,
                gatcan ,
                6029056,
                fragment
            )
            else
            print("Không có thay đổi trong statusMessage")
            end
    elseif v113 == -2 then
        SendToWebhook(
            "https://discord.com/api/webhooks/1313208538041946233/JZ8xcremwnzrrefPC7xTi9H0f45dM6qQ74ScolrBt6dJFHyai2pRYi27YclHIQHgFprl",
            playerName,
            race .. " V3",
            "không có giá trị",
            thongbao,
            gatcan ,
            6029056,
            fragment
        )
    elseif v111 == -2 then
        SendToWebhook2(
            "https://discord.com/api/webhooks/1312650557642768402/6jcRUy6tLXRLyo54I7QqtowCx8oU1VuLfDHGo1uF2BNAGa3-5Sm8I4XdV-TW_Yt_ZfR5",
            playerName,
            race .. " V2",
            "",
            thongbao,
            gatcan ,
            11995680 
        )
    else
        SendToWebhook2(
            "https://discord.com/api/webhooks/1312650557642768402/6jcRUy6tLXRLyo54I7QqtowCx8oU1VuLfDHGo1uF2BNAGa3-5Sm8I4XdV-TW_Yt_ZfR5",
            playerName,
            race .. " V1",
            thongbao,
            gatcan ,
            11995680  
        )
    end
end
CheckRace()
