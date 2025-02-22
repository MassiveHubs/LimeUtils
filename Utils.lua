local util = {}

--[[
    Player Utilities
]]
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
    end
    return nil
end

function util.getPlayerPosition()
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        return player.Character.HumanoidRootPart.Position
    end
    return Vector3.new(0, 0, 0)
end

function util.teleportPlayer(position)
    local player = game.Players.LocalPlayer
    if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(position)
    end
end

function util.getAllPlayers()
    return game.Players:GetPlayers()
end

--[[
    Physics Utilities
]]
function util.setGravity(gravity)
    workspace.Gravity = math.clamp(gravity, 0, 196.2)
end

function util.getGravity()
    return workspace.Gravity
end

--[[
    Audio Utilities
]]
function util.playSound(soundId, options)
    options = options or {volume = 1, looped = false, parent = workspace}
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://"..tostring(soundId)
    sound.Volume = options.volume
    sound.Looped = options.looped
    sound.Parent = options.parent
    sound:Play()
    return sound
end

function util.stopAllSounds(parent)
    for _, sound in ipairs((parent or workspace):GetDescendants()) do
        if sound:IsA("Sound") then
            sound:Stop()
        end
    end
end

--[[
    Debug Utilities
]]
function util.measurePerformance(func, ...)
    local start = os.clock()
    local results = {func(...)}
    return os.clock() - start, unpack(results)
end

function util.dumpObject(obj, maxDepth)
    maxDepth = maxDepth or 3
    local function recurse(o, depth)
        if depth > maxDepth then return "..." end
        local str = "{"
        for k,v in pairs(o) do
            str ..= tostring(k).." = "
            str ..= type(v) == "table" and recurse(v, depth + 1) or tostring(v)
            str ..= ", "
        end
        return str:sub(1, -3).."}"
    end
    return recurse(obj, 1)
end

--[[
    Advanced Utilities
]]
function util.raycast(origin, direction, params)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = params.filterType or Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = params.ignoreList or {game.Players.LocalPlayer.Character}
    raycastParams.IgnoreWater = params.ignoreWater or true
    return workspace:Raycast(origin, direction, raycastParams)
end

return util
