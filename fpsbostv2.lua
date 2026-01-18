--[[
    Ditz shadow code - GOD MODE FPS (EXTREME)
    Fokus: No Sky, No Clouds, No Particles, No Shadows, No Effects
    Client: Bos-Tuan Besar
]]

-- 1. HAPUS LANGIT DAN JADIKAN HITAM (MAKSIMAL FPS)
local Lighting = game:GetService("Lighting")
for _, v in pairs(Lighting:GetChildren()) do
    v:Destroy()
end

Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
Lighting.Brightness = 2 -- Tetap terang agar musuh kelihatan
Lighting.OutdoorAmbient = Color3.fromRGB(150, 150, 150) -- Membuat lingkungan abu-abu/terang

-- 2. SUPER CLEANING (HAPUS SEMUA PARTIKEL & EFEK)
local function UltraClean(v)
    -- Hapus Efek Visual & Partikel
    if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") or v:IsA("Explosion") then
        v.Enabled = false
        v:Destroy() -- Langsung hapus agar memori lega
    -- Ubah Material ke Plastik Polos (Paling Ringan)
    elseif v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
        v.Material = Enum.Material.SmoothPlastic
        v.CastShadow = false
        v.Reflectance = 0
    -- Hapus Awan
    elseif v:IsA("Clouds") then
        v:Destroy()
    -- Hapus Efek Layar (Blur, Bloom, dsb)
    elseif v:IsA("PostEffect") or v:IsA("Bloom") or v:IsA("Blur") or v:IsA("SunRaysEffect") then
        v.Enabled = false
    end
end

-- Eksekusi awal untuk semua objek di map
for _, obj in pairs(game:GetDescendants()) do
    UltraClean(obj)
end

-- Pantau objek baru (Skill musuh/efek baru yang muncul)
game.Workspace.DescendantAdded:Connect(UltraClean)
