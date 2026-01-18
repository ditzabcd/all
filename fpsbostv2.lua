--[[
    Ditz shadow code - GOD MODE FPS (FIXED VERSION)
    Fix: No Blue Screen Portal, No Diamond Glow, No Lag
    Client: Bos-Tuan Besar
]]

-- 1. PEMBERSIHAN LANGIT & LIGHTING (AGAR FPS STABIL)
local Lighting = game:GetService("Lighting")
for _, v in pairs(Lighting:GetChildren()) do
    if v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("Clouds") then
        v:Destroy()
    end
end

Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
Lighting.Brightness = 2
Lighting.ClockTime = 12

-- 2. FUNGSI PEMBERSIH AGRESIF (MENCEGAH BUG LAYAR BIRU/CAHAYA)
local function ExtremeCleanup(v)
    -- Hapus Partikel & Trail (Penyebab Lag)
    if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false
    
    -- FIX LAYAR BIRU PORTAL & CAHAYA DIAMOND
    elseif v:IsA("SelectionBox") or v:IsA("SelectionHighlight") or v:IsA("Highlight") or v:IsA("PointLight") or v:IsA("SurfaceLight") or v:IsA("SpotLight") then
        v:Destroy() -- Langsung hapus agar tidak nyangkut di layar/kaki

    -- Hapus Efek Layar (Portal Screen Effect)
    elseif v:IsA("PostEffect") or v:IsA("Bloom") or v:IsA("Blur") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") then
        v.Enabled = false
        -- Jika efek layar maksa aktif, kita set ke normal
        if v:IsA("ColorCorrectionEffect") then
            v.Brightness = 0
            v.Contrast = 0
            v.Saturation = 0
            v.TintColor = Color3.fromRGB(255, 255, 255)
        end

    -- Optimasi Material (Paling Ringan)
    elseif v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
        v.Material = Enum.Material.SmoothPlastic
        v.CastShadow = false
    end
end

-- Jalankan di seluruh map
for _, obj in pairs(game:GetDescendants()) do
    ExtremeCleanup(obj)
end

-- Monitor Skill Baru (Mencegah Skill Portal/Diamond muncul lagi)
game.Workspace.DescendantAdded:Connect(ExtremeCleanup)
game.Lighting.ChildAdded:Connect(ExtremeCleanup) 
-- Cek di Lighting juga karena efek Portal sering ditaruh di sana
