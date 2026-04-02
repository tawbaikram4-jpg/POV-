-- [[ ♛ SATAYA VIP - INFINITY FARM LOOP ♛ ]] --
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local TS = game:GetService("TweenService")
local pgui = player:WaitForChild("PlayerGui")

if pgui:FindFirstChild("SatayaHurricane") then pgui.SatayaHurricane:Destroy() end
local sg = Instance.new("ScreenGui", pgui); sg.Name = "SatayaHurricane"; sg.ResetOnSpawn = false

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 350, 0, 320); Main.Position = UDim2.new(0.5, -175, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(0, 20, 40); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)

local Display = Instance.new("TextLabel", Main)
Display.Text = "نظام الإعصار جاهز للربح... 🌀"; Display.Size = UDim2.new(1, 0, 0, 110)
Display.BackgroundColor3 = Color3.fromRGB(0, 40, 80); Display.TextColor3 = Color3.new(1, 1, 1); Display.TextScaled = true
Instance.new("UICorner", Display)

-- [ وظيفة الطيران الفائق (Tween TP) ]
local function TeleportTo(targetPos)
    local distance = (targetPos - root.Position).Magnitude
    local info = TweenInfo.new(distance / 200, Enum.EasingStyle.Linear) -- سرعة 200 (خارقة)
    local tween = TS:Create(root, info, {CFrame = CFrame.new(targetPos)})
    tween:Play()
    tween.Completed:Wait()
end

-- [[ محرك الدورة التلقائية: طيران -> أخذ -> ربح ]] --
local hurricaneActive = false
local function StartHurricane()
    hurricaneActive = not hurricaneActive
    if hurricaneActive then
        Display.Text = "الإعصار نشط: جاري سحق الماب! ⚡"; Display.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
        spawn(function()
            while hurricaneActive do
                local targetFound = false
                
                -- 1. البحث عن الـ Infinity أو القطع النادرة
                for _, item in pairs(game.Workspace:GetDescendants()) do
                    if item:IsA("BasePart") and item.Transparency < 1 then
                        if item.Name:lower():find("infinity") or item.Name:lower():find("point") then
                            Display.Text = "تم رصد الهدف.. طيران! 🚀"
                            TeleportTo(item.Position)
                            firetouchinterest(root, item, 0) -- تأكيد الأخذ
                            firetouchinterest(root, item, 1)
                            targetFound = true
                            task.wait(0.5) -- انتظار بسيط للتأكد من الأخذ
                        end
                    end
                end
                
                -- 2. الطيران لمكان الأمان أو الربح (إذا لم يجد قطع)
                if not targetFound then
                    -- هنا نضع إحداثيات منطقة "الفوز" أو "الأمان" في الماب
                    -- السكربت سيبحث عن أي منطقة تسمى "Safe" أو "Win"
                    for _, zone in pairs(game.Workspace:GetDescendants()) do
                        if zone.Name:lower():find("safe") or zone.Name:lower():find("win") then
                            TeleportTo(zone.Position)
                            Display.Text = "في منطقة الأمان.. تم الربح! ✅"
                        end
                    end
                end
                task.wait(0.2)
            end
        end)
    else
        Display.Text = "تم إيقاف الإعصار."; Display.BackgroundColor3 = Color3.fromRGB(0, 40, 80)
    end
end

-- أزرار التحكم
local function AddBtn(txt, pos, func)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.9, 0, 0, 55); b.Position = UDim2.new(0.05, 0, 0, pos)
    b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(30, 30, 50); b.TextColor3 = Color3.new(1, 1, 1); b.TextScaled = true
    b.MouseButton1Click:Connect(func); Instance.new("UICorner", b)
end

AddBtn("تفعيل إعصار الربح التلقائي 🌀", 130, StartHurricane)
AddBtn("إخفاء البانل (OPEN) 🛑", 200, function() Main.Visible = false; sg.OpenBtn.Visible = true end)

local OpenBtn = Instance.new("TextButton", sg)
OpenBtn.Name = "OpenBtn"; OpenBtn.Size = UDim2.new(0, 90, 0, 45); OpenBtn.Position = UDim2.new(0, 10, 0.5, 0); OpenBtn.Text = "OPEN 🔓"
OpenBtn.Visible = false; OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0); OpenBtn.TextColor3 = Color3.new(1, 1, 1); OpenBtn.TextScaled = true; Instance.new("UICorner", OpenBtn)
OpenBtn.MouseButton1Click:Connect(function() Main.Visible = true; OpenBtn.Visible = false end)
