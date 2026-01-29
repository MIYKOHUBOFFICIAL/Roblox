--[Open source bro]
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

_G.M1SoundsEnabled = true
_G.M1ParticlesEnabled = true
_G.BlackFlashEnabled = true
_G.GojoCursedEnabled = true
_G.SukunaCursedEnabled = false
_G.GojoPSEnabled = true

local function PlaySound(assetId, volume)
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://" .. assetId
    sound.Volume = volume
    sound.Parent = LocalPlayer:WaitForChild("PlayerGui")
    sound:Play()
    sound.Ended:Wait()
    sound:Destroy()
end

local soundData = {
    [2] = {{id = "13064223399", volume = 2}},
    [3] = {{id = "13064223291", volume = 2}},
    [4] = {{id = "13064223483", volume = 2}},
    [5] = {
        {id = "13064442279", volume = 2},
        {id = "12244488581", volume = 2},
        {id = "17173355584", volume = 0.5},
        {id = "17173354974", volume = 0.5}
    }
}

local function GetVictimModel(hitAttr)
    if not hitAttr then return nil end
    local name = hitAttr:match("([^;]+)")
    if not name then return nil end
    local player = Players:FindFirstChild(name)
    if player and player.Character then return player.Character end
    local live = Workspace:FindFirstChild("Live")
    if live then
        local dummy = live:FindFirstChild(name)
        if dummy then return dummy end
    end
    return Workspace:FindFirstChild(name)
end

local function setupEffects()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    
    character:GetAttributeChangedSignal("LastM1Hitted"):Connect(function()
        local hitAttr = character:GetAttribute("LastM1Hitted")
        local comboValue = character:GetAttribute("Combo")

        if _G.M1SoundsEnabled then
            if soundData[comboValue] then
                for _, soundInfo in ipairs(soundData[comboValue]) do
                    task.spawn(function()
                        PlaySound(soundInfo.id, soundInfo.volume)
                        task.wait(0.05)
                    end)
                end
            end
        end

        if _G.M1ParticlesEnabled then
            local victim = GetVictimModel(hitAttr)
            if victim then
                local targetRoot = victim:FindFirstChild("HumanoidRootPart") or victim:FindFirstChild("Torso") or victim:FindFirstChild("UpperTorso")
                local hrp = character:WaitForChild("HumanoidRootPart")
                if targetRoot then
                    local direction = (hrp.Position - targetRoot.Position).Unit
                    local attachment = Instance.new("Attachment", targetRoot)
                    local rotX = math.atan2(direction.Y, math.sqrt(direction.X^2 + direction.Z^2))
                    local rotY = math.atan2(direction.X, direction.Z)
                    attachment.Rotation = Vector3.new(math.deg(rotX), math.deg(rotY), 0)
                    
                    local function createEmitter(name, properties)
                        local emitter = Instance.new("ParticleEmitter")
                        emitter.Name = name
                        for prop, value in pairs(properties) do emitter[prop] = value end
                        emitter.Parent = attachment
                        return emitter
                    end

                    local shockwave1 = createEmitter("Shockwaves2", {Color = ColorSequence.new(Color3.fromRGB(255, 252, 252), Color3.fromRGB(255, 255, 255)), Drag = 5, ZOffset = 0, LightInfluence = 0, Lifetime = NumberRange.new(0.5, 0.5), Speed = NumberRange.new(0.0146053, 0.0146053), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.1, 5.11184), NumberSequenceKeypoint.new(0.2, 8.93842), NumberSequenceKeypoint.new(0.3, 11.1292), NumberSequenceKeypoint.new(0.517, 15.7153), NumberSequenceKeypoint.new(1, 20.4474)}), Enabled = false, Acceleration = Vector3.new(0, 0, 0), LockedToPart = false, Rate = 50, EmissionDirection = Enum.NormalId.Back, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.2, 0.8), NumberSequenceKeypoint.new(1, 1)}), VelocityInheritance = 0, LightEmission = 1, SpreadAngle = Vector2.new(2, 2), Texture = "http://www.roblox.com/asset/?id=11703233149", Rotation = NumberRange.new(0, 360)})
                    local shockwave2 = createEmitter("Shockwaves3", {Color = ColorSequence.new(Color3.fromRGB(255, 252, 252), Color3.fromRGB(255, 255, 255)), Drag = 5, ZOffset = 0, LightInfluence = 0, Lifetime = NumberRange.new(0.5, 0.5), Speed = NumberRange.new(0.0146053, 0.0146053), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.1, 10.2237), NumberSequenceKeypoint.new(0.2, 17.8768), NumberSequenceKeypoint.new(0.3, 22.2584), NumberSequenceKeypoint.new(0.517, 31.4305), NumberSequenceKeypoint.new(1, 40.8947)}), Enabled = false, Acceleration = Vector3.new(0, 0, 0), LockedToPart = false, Rate = 75, EmissionDirection = Enum.NormalId.Back, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.2, 0.8), NumberSequenceKeypoint.new(1, 1)}), VelocityInheritance = 0, LightEmission = 1, SpreadAngle = Vector2.new(0, 0), Texture = "http://www.roblox.com/asset/?id=11703233149", Rotation = NumberRange.new(0, 360)})
                    local dustShockwave = createEmitter("DustShockwaves", {Color = ColorSequence.new(Color3.fromRGB(255, 252, 252), Color3.fromRGB(255, 255, 255)), Drag = 5, ZOffset = 0, LightInfluence = 0, Lifetime = NumberRange.new(0.2, 1.05), Speed = NumberRange.new(0.0146053, 0.0146053), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 58.421)}), Enabled = false, Acceleration = Vector3.new(0, 0, 0), LockedToPart = false, Rate = 35, EmissionDirection = Enum.NormalId.Back, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.04, 0.96), NumberSequenceKeypoint.new(1, 1)}), VelocityInheritance = 0, LightEmission = 0, SpreadAngle = Vector2.new(10, 10), Texture = "http://www.roblox.com/asset/?id=11703216487", Rotation = NumberRange.new(0, 360)})
                    local redDust = createEmitter("RedDust2", {Color = ColorSequence.new(Color3.fromRGB(252, 252, 252), Color3.fromRGB(255, 255, 255)), Drag = 4, ZOffset = 0, LightInfluence = 0, Lifetime = NumberRange.new(0.1, 1), Speed = NumberRange.new(18.75, 90), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.281, 2.91889), NumberSequenceKeypoint.new(1, 7.30263)}), Enabled = false, Acceleration = Vector3.new(0, 0, 0), LockedToPart = false, Rate = 50, EmissionDirection = Enum.NormalId.Back, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.339323, 0), NumberSequenceKeypoint.new(0.80798, 0.3625), NumberSequenceKeypoint.new(1, 1)}), VelocityInheritance = 0, LightEmission = 0.8, SpreadAngle = Vector2.new(25, 25), Texture = "rbxassetid://7216854921", Rotation = NumberRange.new(0, 0)})
                    local pushEffect = createEmitter("Push", {Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255)), Drag = 10, ZOffset = 1, LightInfluence = 0, Lifetime = NumberRange.new(0.1, 0.5), Speed = NumberRange.new(0, 375), Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 2.36514), NumberSequenceKeypoint.new(0.8125, 0.632135), NumberSequenceKeypoint.new(1, 12.9375)}), Enabled = false, Acceleration = Vector3.new(0, 0, 0), LockedToPart = false, Rate = 155, EmissionDirection = Enum.NormalId.Back, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.0625, 0.9375), NumberSequenceKeypoint.new(1, 1)}), VelocityInheritance = 0, LightEmission = 0, SpreadAngle = Vector2.new(-15, 15), Texture = "http://www.roblox.com/asset/?id=9160490836", Rotation = NumberRange.new(-25, 25)})

                    shockwave1:Emit(1)
                    shockwave2:Emit(1)
                    dustShockwave:Emit(30)
                    redDust:Emit(10)
                    pushEffect:Emit(30)
                    task.delay(1, function() if attachment then attachment:Destroy() end end)
                end
            end
        end

        if _G.BlackFlashEnabled and comboValue == 5 then
            local victim = GetVictimModel(hitAttr)
            if victim then
                local effectsFolder = ReplicatedStorage:FindFirstChild("Resources"):FindFirstChild("KJEffects")
                local targetTorso = victim:FindFirstChild("Torso") or victim:FindFirstChild("UpperTorso")
                if effectsFolder and targetTorso then
                    local effectTemplate = effectsFolder:FindFirstChild("DropkickExtra"):FindFirstChild("firstHit"):FindFirstChild("Attachment")
                    if effectTemplate then
                        local effect = effectTemplate:Clone()
                        effect.Parent = targetTorso
                        for _, p in ipairs(effect:GetChildren()) do if p:IsA("ParticleEmitter") then p:Emit(5) end end
                        task.delay(1, function() if effect then effect:Destroy() end end)
                    end
                end
            end
        end
    end)
end

task.spawn(setupEffects)
LocalPlayer.CharacterAdded:Connect(setupEffects)
