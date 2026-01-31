local assetId = 17352290656
local effect = game:GetObjects("rbxassetid://" .. assetId)[1]
local soundId = "rbxassetid://6667923288"
local sound = Instance.new("Sound")
sound.SoundId = soundId
sound.Parent = game.Workspace
sound:Play()
if effect then
    local character = game.Players.LocalPlayer.Character
    local torso = character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso")
    if torso then
        effect.Parent = torso
        effect.CFrame = torso.CFrame * CFrame.new(0, 32, -1)
        wait(17)
        effect:Destroy()
    end
end
