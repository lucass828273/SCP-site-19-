-- SCP Site-19 Roleplay Admin Script for Delta Executor

local Players = game:GetService("Players")

-- Function to get a player by partial name
function getPlayer(name)
    for _, player in ipairs(Players:GetPlayers()) do
        if string.lower(player.Name):find(string.lower(name)) then
            return player
        end
    end
    return nil
end

-- Commands
local commands = {
    WATCH = function(target)
        local player = getPlayer(target)
        if player then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
        end
    end,

    WHISPER = function(target, message)
        local player = getPlayer(target)
        if player then
            game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("[WHISPER] "..message, "All")
        end
    end,

    INVENTO = function(target)
        local player = getPlayer(target)
        if player then
            print("Checking inventory for:", player.Name)
            -- Add inventory check logic here
        end
    end,

    KICK = function(target)
        local player = getPlayer(target)
        if player then
            player:Kick("You have been removed from SCP Site-19 by an admin.")
        end
    end,

    BAN = function(target)
        local player = getPlayer(target)
        if player then
            -- Ban system would require DataStore, but for temp bans:
            player:Kick("You have been permanently banned from SCP Site-19.")
        end
    end,

    TELEPOR = function(target, location)
        local player = getPlayer(target)
        if player then
            local scpArea = workspace:FindFirstChild(location)
            if scpArea then
                player.Character.HumanoidRootPart.CFrame = scpArea.CFrame
            end
        end
    end,

    FREEZE = function(target)
        local player = getPlayer(target)
        if player then
            player.Character.Humanoid.WalkSpeed = 0
            player.Character.Humanoid.JumpPower = 0
        end
    end,

    RESPAW = function(target)
        local player = getPlayer(target)
        if player then
            player:LoadCharacter()
        end
    end,

    MISC = function()
        print("Miscellaneous command executed.")
    end
}

-- UI Button Functionality
function onButtonClick(command, target, extra)
    if commands[command] then
        commands[command](target, extra)
    else
        warn("Invalid command: " .. command)
    end
end

-- Example usage:
onButtonClick("WATCH", "PlayerName") -- Watches a player
onButtonClick("WHISPER", "PlayerName", "Hello") -- Whispers to a player
onButtonClick("KICK", "PlayerName") -- Kicks a player
onButtonClick("TELEPOR", "PlayerName", "SCP-173 Chamber") -- Teleports a player
