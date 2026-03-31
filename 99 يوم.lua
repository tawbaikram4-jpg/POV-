-- [[ ♛ SATAYA VIP - THE ULTIMATE SURVIVOR ♛ ]] --
-- [[ سكربت جلب الأغراض، فتح الصناديق، وتطوير النار تلقائياً ]] --

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local UIS = game:GetService("UserInputService")

-- [ 1. الواجهة الاحترافية - تظهر بـ 3 أصابع ]
if player.PlayerGui:FindFirstChild("SatayaUltimate") then player.PlayerGui.SatayaUltimate:Destroy() end
local sg = Instance.new("ScreenGui", player.PlayerGui); sg.Name = "SatayaUltimate"; sg.ResetOnSpawn = false

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 280, 0, 250); Main.Position = UDim2.new(0.5, -140, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 0, 0); Main.BorderSizePixel = 2; Main.Draggable = true

UIS.TouchStarted:Connect(function(_, p) if not p and #UIS:GetTouches() >= 3 then Main.Visible = not Main.Visible end end)

local function AddToggle(name, pos, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Text = name; btn.Size = UDim2.new(0.9, 0, 0, 45); btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.BackgroundColor3 = Color3.fromRGB(40, 0, 0); btn.TextColor3 = Color3.fromRGB(255, 255, 255); btn.TextScaled = true
    
    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.BackgroundColor3 = enabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 0, 0)
        callback(enabled)
    end)
end

-- [ 2. تفعيل الميزات القوية ]

-- أ. جلب الأغراض والبيض تلقائياً
AddToggle("جلب الأغراض والبيض 🔥", 20, function(state)
    _G.AutoGrab = state
    while _G.AutoGrab do
        for _, item in pairs(game:GetService("Workspace"):GetDescendants()) do
            if (item.Name:lower():find("egg") or item.Name:lower():find("item") or item.Name:lower():find("drop")) and item:IsA("BasePart") then
                item.CFrame = char.HumanoidRootPart.CFrame
            end
        end
        task.wait(0.5)
    end
end)

-- ب. فتح الصناديق تلقائياً
AddToggle("فتح الصناديق تلقائياً 📦", 75, function(state)
    _G.AutoChest = state
    while _G.AutoChest do
        for _, chest in pairs(game:GetService("Workspace"):GetDescendants()) do
            if chest.Name:lower():find("chest") and chest:FindFirstChild("TouchInterest") then
                firetouchinterest(char.HumanoidRootPart, chest, 0) -- لمس الصندوق لفتحه
                firetouchinterest(char.HumanoidRootPart, chest, 1)
            end
        end
        task.wait(1)
    end
end)

-- ج. تطوير النار تلقائياً (تطوير القوة)
AddToggle("تطوير النار (Auto Upgrade) ⚡", 130, function(state)
    _G.AutoFire = state
    while _G.AutoFire do
        -- محاولة استخدام الريموت الخاص بالتطوير في الماب
        local remote = game:GetService("ReplicatedStorage"):FindFirstChild("UpgradeRemote") or game:GetService("ReplicatedStorage"):FindFirstChild("FireRemote")
        if remote then
            remote:FireServer("Upgrade", "Fire") -- هذا الأمر يختلف حسب الماب، لكنه يحاول التطوير
        end
        task.wait(2)
    end
end)

-- د. سرعة الملك الأسطورية
AddToggle("سرعة الملك SATAYA ♛", 185, function(state)
    char.Humanoid.WalkSpeed = state and 120 or 16
end)

print("♛ تم تشغيل سكربت SATAYA المطور في الغابة ♛")
