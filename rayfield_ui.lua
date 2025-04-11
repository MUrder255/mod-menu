-- Ensure Rayfield is loaded
local Rayfield = require(game.ReplicatedStorage:WaitForChild("Rayfield"))

-- Create the UI window
local Window = Rayfield:CreateWindow({
    Name = "Universal Mod Menu",
    LoadingTitle = "Loading Mod Menu...",
    LoadingSubtitle = "Please wait",
    ConfigurationSaving = { Enabled = true, FolderName = "ModMenuConfig", FileName = "Settings" },
    Discord = { Enabled = true, Invite = "discord.gg/yourlink", RememberJoins = true },
    Keybinds = { Enabled = true, Keybind = Enum.KeyCode.LeftControl },
})

-- Create tabs dynamically (Player, Combat, Movement, etc.)
local tabs = {}

-- Sample Features (you will have your own)
local features = {
    SuperStamina = {
        Category = "Player",
        Description = "Increases stamina and endurance",
        Callback = function()
            local player = game.Players.LocalPlayer
            local humanoid = player.Character:WaitForChild("Humanoid")
            humanoid.Stamina = math.huge  -- Infinite stamina
        end
    },
    HealOnKill = {
        Category = "Player",
        Description = "Restores health after a kill",
        Callback = function(killer, victim)
            if killer == game.Players.LocalPlayer then
                local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
                humanoid.Health = humanoid.Health + 50  -- Heal by 50 health after each kill
            end
        end
    },
    SpeedsterMode = {
        Category = "Movement",
        Description = "Increases player speed dramatically",
        Callback = function()
            local player = game.Players.LocalPlayer
            local humanoid = player.Character:WaitForChild("Humanoid")
            humanoid.WalkSpeed = 100  -- Increase speed to 100
        end
    }
}

-- Iterate over the feature list and create tabs and buttons dynamically
for featureName, featureData in pairs(features) do
    -- Create tab for category if it doesn't exist
    if not tabs[featureData.Category] then
        tabs[featureData.Category] = Window:CreateTab(featureData.Category)
    end

    -- Create section in the tab
    local section = tabs[featureData.Category]:CreateSection(featureData.Category)

    -- Create button for each feature
    section:CreateButton({
        Name = featureName,  -- Name of the feature button
        Description = featureData.Description,  -- Feature description
        Callback = function()
            featureData.Callback()  -- Execute the feature callback function
        end
    })
end

-- Additional UI handling or configuration logic can go here
