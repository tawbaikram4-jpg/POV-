-- [[ ♛ SATAYA VIP - THE FINAL JUSTICE HUB ♛ ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- إعداد الواجهة الملكية مع زر OPEN دائم
if pgui:FindFirstChild("SatayaFinalHub") then pgui.SatayaFinalHub:Destroy() end
local sg = Instance.new("ScreenGui", pgui); sg.Name = "SatayaFinalHub"; sg.ResetOnSpawn = false

-- [ 1. البانل الرئيسي - شكل الفخامة والتعويض ]
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 320, 0, 300); Main.Position = UDim2.new(0.5, -160, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)

local Display = Instance.new("TextLabel", Main)
Display.Text = "المحرك جاهز للسيطرة..."; Display.Size = UDim2.new(1, 0, 0, 90)
Display.BackgroundColor3 = Color3.fromRGB(40, 0, 0); Display.TextColor3 = Color3.new(1, 1, 1); Display.TextScaled = true
Instance.new("UICorner", Display)

-- [ 2. زر الـ OPEN (الأثر الدائم) ]
local OpenBtn = Instance.new("TextButton", sg)
OpenBtn.Size = UDim2.new(0, 90, 0, 45); OpenBtn.Position = UDim2.new(0, 10, 0.5, 0)
OpenBtn.Text = "OPEN 🔓"; OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0); OpenBtn.TextColor3 = Color3.new(1, 1, 1)
OpenBtn.Visible = false; OpenBtn.TextScaled = true; Instance.new("UICorner", OpenBtn)

--- [[ محركات الاختراق الشاملة ]] ---

-- أ. قناص الأرقام والكوكيز (تجاوز الفخاخ 999 و 6)
local function StartUniversalScanner()
    Display.Text = "جاري قنص الحلول الحية..."
    spawn(function()
        while true do
            local found = false
            -- فحص أرقام التخمين (تجاهل الفخاخ)
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= player then
                    for _, v in pairs(p:GetDescendants()) do
                        if (v:IsA("ValueBase") or v:IsA("TextLabel")) then
                            local val = tonumber(v.Value or v.Text)
                            if val and val > 0 and val < 900 and val ~= 6 then
                                Display.Text = "الحل المكتشف: [" .. tostring(val) .. "]"
                                Display.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
                                found = true
                            end
                        end
                    end
                end
            end
            -- فحص الكوكيز (البحث عن القطعة الآمنة)
            if not found then
                for _, obj in pairs(game.Workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and (obj.Name:lower():find("safe") or obj.Name:lower():find("correct")) then
                        Display.Text = "امشِ على: " .. obj.Name
                        found = true
                    end
                end
            end
            task.wait(0.3)
        end
    end)
end

-- ب. أوتو كليكر البوب كورن (الضغط الذهبي)
local autoClick = false
local function TogglePopcorn()
    autoClick = not autoClick
    if autoClick then
        Display.Text = "أوتو كليكر بوب كورن: نـشـط 🔥"
        Display.BackgroundColor3 = Color3.fromRGB(150, 100, 0)
        spawn(function()
            while autoClick do
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 1)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 1)
                task.wait(0.01)
            end
        end)
    else
        Display.Text = "تم إيقاف الضغط."
        Display.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
    end
end

-- [[ إنشاء الأزرار ]]
local function AddBtn(txt, pos, func)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.9, 0, 0, 45); b.Position = UDim2.new(0.05, 0, 0, pos)
    b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(40, 40, 40); b.TextColor3 = Color3.new(1, 1, 1); b.TextScaled = true
    b.MouseButton1Click:Connect(func); Instance.new("UICorner", b)
end

AddBtn("قنص (الأرقام + الكوكيز) 👁️", 100, StartUniversalScanner)
AddBtn("أوتو كليكر بوب كورن ⚡", 155, TogglePopcorn)
AddBtn("إغلاق (أثر Open) 🛑", 210, function()
    Main.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenBtn.Visible = false
end)
