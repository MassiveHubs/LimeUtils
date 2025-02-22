local util = {}


function util.username()
    local player = game.Players.LocalPlayer
    return player and player.Name or "Player not found"
end


function util.displayName()
    local player = game.Players.LocalPlayer
    return player and player.DisplayName or "DisplayName not found"
end


function util.userId()
    local player = game.Players.LocalPlayer
    return player and player.UserId or 0
end


function util.realUsername()
    local player = game.Players.LocalPlayer
    return player and (player.DisplayName ~= "" and player.DisplayName or player.Name) or "Player not found"
end


function util.getLocalPlayerThumbnail()
    local player = game.Players.LocalPlayer
    if player then
        return game.Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    else
        warn("Local player not found.")
        return nil
    end
end


function util.getTimeOfDay()
    return game:GetService("Lighting").ClockTime
end


function util.setTimeOfDay(time)
    if type(time) == "number" and time >= 0 and time <= 24 then
        game:GetService("Lighting").ClockTime = time
    else
        warn("Invalid time. Must be between 0 and 24.")
    end
end


function util.getPlayerPosition()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        return player.Character.HumanoidRootPart.Position
    else
        warn("Player or HumanoidRootPart not found.")
        return Vector3.new(0, 0, 0)
    end
end


function util.teleportPlayer(position)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    else
        warn("Player or HumanoidRootPart not found.")
    end
end


function util.getAllPlayers()
    return game.Players:GetPlayers()
end

return util
