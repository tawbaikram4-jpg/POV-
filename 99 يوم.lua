-- [[ ♛ SATAYA VIP - THE ULTIMATE ALL-IN-ONE ♛ ]] --
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local camera = game.Workspace.CurrentCamera
local pgui = player:WaitForChild("PlayerGui")

-- تنظيف النسخ السابقة
if pgui:FindFirstChild("SatayaFinalMenu") then pgui.SatayaFinalMenu:Destroy() end
local sg = Instance.new("ScreenGui", pgui); sg.Name = "SatayaFinalMenu"; sg.ResetOnSpawn = false

-- [ 1. الهيكل الرئيسي المطور ]
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 500, 0, 350); Main.Position = UDim2.new(0.5, -250, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Main.BorderSizePixel = 0; Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)

local Side = Instance.new("Frame", Main)
Side.Size = UDim2.new(0, 130, 1, 0); Side.BackgroundColor3 = Color3.fromRGB(45, 0, 0)
Instance.new("UICorner", Side)

local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0, 140, 0, 10); Content.Size = UDim2.new(1, -150, 1, -20); Content.BackgroundTransparency = 1
local layout = Instance.new("UIListLayout", Content); layout.Padding = UDim.new(0, 8)

-- [ 2. الوظائف التقنية (ESP, Tracer, Aimbot) ]
_G.TracerOn = false; _G.AimbotOn = false

local function CreateVisuals(obj, name, color)
    if not obj:FindFirstChild("SatayaVisual") then
        local box = Instance.new("BoxHandleAdornment", obj); box.Name = "SatayaVisual"; box.Adornee = obj
        box.AlwaysOnTop = true; box.ZIndex = 10; box.Size = obj.Size; box.Color3 = color; box.Transparency = 0.6
    end
end

-- [ 3. محرك الأقسام ]
local function Clear() for _, v in pairs(Content:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end end

local function AddToggle(name, func_on, func_off)
    local btn = Instance.new("TextButton", Content)
    btn.Size = UDim2.new(1, 0, 0, 45); btn.Text = name .. " [OFF]"; btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1,1,1); btn.TextScaled = true; Instance.new("UICorner", btn)
    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = active and name .. " [ON]" or name .. " [OFF]"
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
        if active then spawn(function() while active do pcall(func_on) task.wait(1) end end) else pcall(func_off) end
    end)
end

-- [ 4. محتوى الأقسام ]

-- قسم النار والموارد
local function TabFire()
    Clear()
    AddToggle("مطر الخشب للنار 🔥", function()
        local fire = game.Workspace:FindFirstChild("Fire", true) or game.Workspace:FindFirstChild("Campfire", true)
        if fire then for _, v in pairs(game.Workspace:GetChildren()) do if v:IsA("BasePart") and not v.Anchored then v.CFrame = fire.CFrame + Vector3.new(0, 10, 0) end end end
    end, function() end)
end

-- قسم البيض (حل مشكلة السقوط والبرق)
local function TabEggs()
    Clear()
    AddToggle("البيض للسلة (آمن) 🥚", function()
        local basket = game.Workspace:FindFirstChild("Basket", true) or char:FindFirstChild("Basket", true)
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v.Name:lower():find("egg") and v:IsA("BasePart") then
                v.CanCollide = false; v.Massless = true
                if basket then v.CFrame = basket.CFrame + Vector3.new(0, 2, 0) else v.CFrame = root.CFrame * CFrame.new(0, 0, -5) end
            end
        end
    end, function() end)
    
    AddToggle("جلب بيضة البرق النادرة ⚡", function()
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if (v.Name:lower():find("light") or v.Name:lower():find("rare")) and v:IsA("BasePart") then
                v.CFrame = root.CFrame * CFrame.new(0, 0, -5)
            end
        end
    end, function() end)
end

-- قسم الكشف والأيم بوت (الأنبوب + الرأس)
local function TabCombat()
    Clear()
    AddToggle("كشف الأنبوب + ESP 📍", function()
        _G.TracerOn = true
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if (v.Name:lower():find("animal") or v.Name:lower():find("bear") or v.Name:lower():find("kid")) and v:IsA("BasePart") then
                CreateVisuals(v, v.Name, Color3.new(1, 0, 0))
            end
        end
    end, function() _G.TracerOn = false end)

    AddToggle("أيم بوت (قفل على الرأس) 🎯", function()
        _G.AimbotOn = true
        local target = nil
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if (v.Name:lower():find("animal") or v.Name:lower():find("bear")) and v:IsA("Model") then
                local head = v:FindFirstChild("Head")
                if head then camera.CFrame = CFrame.new(camera.CFrame.Position, head.Position) break end
            end
        end
    end, function() _G.AimbotOn = false end)
end

-- قسم السرعة والصبية
local function TabExtra()
    Clear()
    AddToggle("سرعة الملك الأسطورية ⚡", function() char.Humanoid.WalkSpeed = 150 end, function() char.Humanoid.WalkSpeed = 16 end)
    AddToggle("جلب الصبية بالترتيب 👶", function()
        local count = 0
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if (v.Name:lower():find("boy") or v.Name:lower():find("kid")) and v:IsA("Model") then
                local r = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChildWhichIsA("BasePart")
                if r then r.CFrame = root.CFrame * CFrame.new((count%4)*5, 0, -10); count = count + 1 end
            end
        end
    end, function() end)
end

-- [ 5. أزرار القائمة الجانبية ]
local function SideBtn(txt, pos, func)
    local b = Instance.new("TextButton", Side); b.Size = UDim2.new(0.9, 0, 0, 45); b.Position = UDim2.new(0.05, 0, 0, pos)
    b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(150, 0, 0); b.TextColor3 = Color3.new(1, 1, 1); b.MouseButton1Click:Connect(func); Instance.new("UICorner", b)
end

SideBtn("النار 🔥", 10, TabFire)
SideBtn("البيض 🥚", 65, TabEggs)
SideBtn("القتال 🎯", 120, TabCombat)
SideBtn("إضافات ✨", 175, TabExtra)

-- زر الإغلاق والفتح (X و ♛)
local Close = Instance.new("TextButton", Main); Close.Text = "X"; Close.Size = UDim2.new(0, 35, 0, 35); Close.Position = UDim2.new(1, -40, 0, 5); Close.BackgroundColor3 = Color3.new(1,0,0)
local Open = Instance.new("TextButton", sg); Open.Text = "♛"; Open.Size = UDim2.new(0, 60, 0, 60); Open.Position = UDim2.new(0, 10, 0.5, 0); Open.Visible = false; Open.BackgroundColor3 = Color3.new(0.6, 0, 0); Instance.new("UICorner", Open).CornerRadius = UDim.new(1,0)
Close.MouseButton1Click:Connect(function() Main.Visible = false; Open.Visible = true end)
Open.MouseButton1Click:Connect(function() Main.Visible = true; Open.Visible = false end)

TabFire() -- البدء بقسم النار
