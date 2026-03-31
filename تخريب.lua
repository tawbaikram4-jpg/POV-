-- [[ ♛ SATAYA VIP - THE LEGENDARY KING ♛ ]] --
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local UIS = game:GetService("UserInputService")

-- [ 1. واجهة التحكم - 3 أصابع ]
if player.PlayerGui:FindFirstChild("SatayaLegend") then player.PlayerGui.SatayaLegend:Destroy() end
local sg = Instance.new("ScreenGui", player.PlayerGui); sg.Name = "SatayaLegend"; sg.ResetOnSpawn = false

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 260, 0, 220); Main.Position = UDim2.new(0.5, -130, 0.4, -110)
Main.BackgroundColor3 = Color3.fromRGB(20, 0, 0); Main.BorderSizePixel = 2; Main.Draggable = true

-- إظهار وإخفاء بـ 3 أصابع
UIS.TouchStarted:Connect(function(_, p) if not p and #UIS:GetTouches() >= 3 then Main.Visible = not Main.Visible end end)

-- [ 2. وظيفة اللقب الملكي المتحرك (يراه الجميع) ]
local function CreateLegendaryTag()
    if char.Head:FindFirstChild("LegendTag") then char.Head.LegendTag:Destroy() end
    local bill = Instance.new("BillboardGui", char.Head); bill.Name = "LegendTag"
    bill.Size = UDim2.new(0, 250, 0, 70); bill.AlwaysOnTop = true; bill.ExtentsOffset = Vector3.new(0, 4, 0)
    
    local lab = Instance.new("TextLabel", bill)
    lab.Size = UDim2.new(1, 0, 1, 0); lab.BackgroundTransparency = 1; lab.TextScaled = true
    lab.Font = Enum.Font.VCRMono; lab.TextColor3 = Color3.fromRGB(255, 0, 0)
    
    -- قائمة الألقاب التي ستظهر فوق رأسك
    local titles = {"♛ SATAYA VIP ♛", "🔥 الملك الأسطوري 🔥", "⚡ وحش السيرفر ⚡", "💀 هيبة ملك 💀"}
    
    task.spawn(function()
        while true do
            for _, t in pairs(titles) do
                lab.Text = t
                -- تأثير وميض أحمر
                for i = 1, 5 do
                    lab.Visible = not lab.Visible
                    task.wait(0.2)
                end
                lab.Visible = true
                task.wait(2)
            end
        end
    end)
end

-- [ 3. أزرار التحكم ]
local function AddBtn(name, pos, func)
    local b = Instance.new("TextButton", Main)
    b.Text = name; b.Size = UDim2.new(0.9, 0, 0, 55); b.Position = UDim2.new(0.05, 0, 0, pos)
    b.BackgroundColor3 = Color3.fromRGB(60, 0, 0); b.TextColor3 = Color3.fromRGB(255, 255, 255); b.TextScaled = true
    b.MouseButton1Click:Connect(func)
end

-- الزر الأول: تفعيل السكن واللقب (يراه الجميع في ماب البيوت)
AddBtn("تفعيل اللقب الأسطوري", 20, function()
    -- وضع التاج والسكن الأسود (Server-Side محاولة)
    local crownID = 11504958641
    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("CatalogRemote")
    if remote then remote:FireServer("WearItem", crownID) end
    
    -- تشغيل اللقب المتحرك
    CreateLegendaryTag()
    
    -- جعل الجسم أسود
    for _, v in pairs(char:GetChildren()) do if v:IsA("BasePart") then v.Color = Color3.fromRGB(0,0,0) end end
end)

-- الزر الثاني: نار تخرج من الجميع 🔥
AddBtn("إشعال النار في الكل", 85, function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local f = Instance.new("Fire", p.Character.HumanoidRootPart)
            f.Color = Color3.fromRGB(255, 0, 0); f.Size = 12
        end
    end
end)

-- الزر الثالث: اختفاء تحت الأرض
AddBtn("اختفاء تحت الأرض", 150, function()
    char.HumanoidRootPart.CFrame *= CFrame.new(0, -25, 0)
end)
