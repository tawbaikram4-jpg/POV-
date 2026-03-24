-- [[ ♛ SATAYA VIP - PVP STEAL & HIDE ♛ ]] --
local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local run = game:GetService("RunService")

-- [ 1. إنشاء واجهة الـ PVP - تظهر بـ 3 أصابع ]
if player.PlayerGui:FindFirstChild("SatayaPVP") then player.PlayerGui.SatayaPVP:Destroy() end
local sg = Instance.new("ScreenGui", player.PlayerGui); sg.Name = "SatayaPVP"
sg.ResetOnSpawn = false

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 260, 0, 340); Main.Position = UDim2.new(0.5, -130, 0.4, -170)
Main.BackgroundColor3 = Color3.fromRGB(20, 0, 0); Main.BorderColor3 = Color3.fromRGB(255, 0, 0); Main.Draggable = true; Main.Active = true

-- إخفاء وإظهار بـ 3 أصابع
UIS.TouchStarted:Connect(function(_, p) if not p and #UIS:GetTouches() >= 3 then Main.Visible = not Main.Visible end end)

local Title = Instance.new("TextLabel", Main)
Title.Text = "♛ SATAYA PVP STEAL ♛"; Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(150, 0, 0); Title.TextColor3 = Color3.fromRGB(255, 255, 255)

local function AddCmd(name, pos, func)
    local b = Instance.new("TextButton", Main)
    b.Text = name; b.Size = UDim2.new(0.9,
