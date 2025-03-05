-- Delta Executor Script with MTF Alpha-1 Team Button

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Function to get a player by name
local function getPlayer(name)
    for _, player in ipairs(Players:GetPlayers()) do
        if string.lower(player.Name) == string.lower(name) then
            return player
        end
    end
    return nil
end

-- GUI for Teaming to MTF Alpha-1
local ScreenGui = Instance.new("ScreenGui")
local TeamButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
TeamButton.Parent = ScreenGui
TeamButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
TeamButton.Position = UDim2.new(0.4, 0, 0.8, 0)
TeamButton.Size = UDim2.new(0, 200, 0, 50)
TeamButton.Text = "Join MTF Alpha-1"
TeamButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeamButton.TextScaled = true

TeamButton.MouseButton1Click:Connect(function()
    for _, team in pairs(game.Teams:GetChildren()) do
        if string.match(team.Name, "MTF Alpha-1") then
            LocalPlayer.Team = team
            print("Successfully joined MTF Alpha-1!")
        end
    end
end)

-- Commands
local commands = {
    WATCH = function(target)
        local player = getPlayer(target)
        if player then
            LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
        end
    end,
    
    WHISPER = function(target, message)
        local player = getPlayer(target)
        if player then
            game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "Whisper")
        end
    end,

    INVENTO = function(target)
        local player = getPlayer(target)
        if player then
            print(player.Name .. "'s Inventory:")
            for _, item in ipairs(player.Backpack:GetChildren()) do
                print(item.Name)
            end
        end
    end,

    KICK = function(target)
        local player = getPlayer(target)
        if player then
            player:Kick("You have been removed from the game.")
        end
    end,

    BAN = function(target)
        local player = getPlayer(target)
        if player then
            player:Kick("You are permanently banned.")
            -- Implement ban saving system if needed
        end
    end,

    TELEPOR = function(target)
        local player = getPlayer(target)
        if player then
            LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
        end
    end,

    FREEZE = function(target)
        local player = getPlayer(target)
        if player then
            for _, part in ipairs(player.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Anchored = true
                end
            end
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

-- Execute Command Function
function executeCommand(command, target, message)
    if commands[command] then
        commands[command](target, message)
    else
        print("Invalid command!")
    end
end
