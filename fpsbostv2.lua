--[[
    Ditz shadow code - Super FixLag Extreme
    Fokus: Performa Maksimal, Tanpa Print, Tanpa Langit
    Client: Bos-Tuan Besar / Nona Besar
]]

-- KONFIGURASI NOTIFIKASI (Silakan Bos-Tuan Besar ubah teks di dalam tanda kutip)
local Judul = "Ditz Shadow Code"
local Pesan = "Super FixLag Berhasil Diaktifkan! 💼💰"

-- 1. NOTIFIKASI SISTEM
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = FIXLAG BYDITZZ;
    Text = fixlag v2 byditz btw jngn aimbot lah sampah;
    Duration = 5;
})

-- 2. EXTREME PERFORMANCE (HAPUS LANGIT, AWAN & BAYANGAN)
local Lighting = game:GetService("Lighting")
for _, v in pairs(Lighting:GetChildren()) do
    v:Destroy() -- Menghapus Skybox, Atmosphere, dan Clouds agar langit polos
end

Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
Lighting.Brightness = 2 -- Menjaga visibilitas meski langit dihapus
settings().Rendering.QualityLevel = 1

-- 3. PEMBERSIHAN EFEK & PARTIKEL SECARA TOTAL
local function Clean(v)
    if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false
    elseif v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
        v.Material = Enum.Material.SmoothPlastic
        v.CastShadow = false
    elseif v:IsA("Decal") or v:IsA("Texture") then
        v.Transparency = 1
    elseif v:IsA("PostEffect") or v:IsA("Bloom") or v:IsA("Blur") or v:IsA("SunRaysEffect") then
        v.Enabled = false
    end
end

-- Eksekusi ke seluruh objek yang sudah ada
for _, obj in pairs(game:GetDescendants()) do
    Clean(obj)
end

-- Membersihkan objek baru yang muncul (saat skill dikeluarkan)
game.Workspace.DescendantAdded:Connect(Clean)
