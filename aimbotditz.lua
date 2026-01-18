--[[
    Ditz shadow code - Blox Fruits Ultimate Script
    Project: Optimization + UI Aimbot
    Client: Bos-Tuan Besar
]]

-- 1. MODUL ANTI-LAG (OTOMATIS TANPA UI) 🚀
local function ActivateAntiLag()
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    
    -- Mematikan efek berat
    l.GlobalShadows = false
    l.FogEnd = 9e9
    settings().Rendering.QualityLevel = 1
    
    for i, v in pairs(g:GetDescendants()) do
        if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            v.CastShadow = false
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") then
            v.Enabled = false
        elseif v:IsA("PostEffect") or v:IsA("Bloom") or v:IsA("Blur") or v:IsA("SunRaysEffect") then
            v.Enabled = false
        end
    end
end

-- Jalankan Anti-Lag Segera
ActivateAntiLag()

-- 2. MODUL AIMBOT DENGAN MENU TOMBOL 🎯
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = game.Workspace.CurrentCamera
local AimbotEnabled = false

-- Membuat UI Sederhana (Elegant Design)
local ScreenGui = Instance.new("ScreenGui")
local MainButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Name = "DitzAimbotUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainButton.Name = "AimbotToggle"
MainButton.Parent = ScreenGui
MainButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainButton.Position = UDim2.new(0.05, 0, 0.4, 0)
MainButton.Size = UDim2.new(0, 120, 0, 45)
MainButton.Font = Enum.Font.GothamBold
MainButton.Text = "AIMBOT: OFF"
MainButton.TextColor3 = Color3.fromRGB(255, 0, 0)
MainButton.TextSize = 14.000
MainButton.Draggable = true

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainButton

-- Fungsi Toggle Aimbot
MainButton.MouseButton1Click:Connect(function()
    AimbotEnabled = not AimbotEnabled
    if AimbotEnabled then
        MainButton.Text = "AIMBOT: ON"
        MainButton.TextColor3 = Color3.fromRGB(0, 255, 127)
    else
        MainButton.Text = "AIMBOT: OFF"
        MainButton.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- Logika Aimbot
local function GetClosestPlayer()
    local target = nil
    local dist = math.huge
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
            local pos, onScreen = Camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
            if onScreen then
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                if magnitude < dist then
                    target = v
                    dist = magnitude
                end
            end
        end
    end
    return target
end

RunService.RenderStepped:Connect(function()
    if AimbotEnabled then
        local target = GetClosestPlayer()
        if target and target.Character then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
        end
    end
end)

print("Ditz shadow code: Script Siap Digunakan, Bos-Tuan Besar! 💰")
