-- [[ ♛ SATAYA VIP - TRUE VALUE SNIPER ♛ ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- إعداد الواجهة (ScreenGui) بنفس شكل السكربت الأول
if pgui:FindFirstChild("SatayaBypassV1") then pgui.SatayaBypassV1:Destroy() end
local sg = Instance.new("ScreenGui", pgui); sg.Name = "SatayaBypassV1"; sg.ResetOnSpawn = false

-- [ 1. البانل الكبير ]
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 320, 0, 240); Main.Position = UDim2.new(0.5, -160, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(10, 0, 0); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)

local Display = Instance.new("TextLabel", Main)
Display.Text = "تجاوز حماية 'جاري البحث'..."; Display.Size = UDim2.new(1, 0, 0, 100)
Display.BackgroundColor3 = Color3.fromRGB(30, 0, 0); Display.TextColor3 = Color3.new(1, 1, 0); Display.TextScaled = true
Instance.new("UICorner", Display)

-- [ 2. زر الـ OPEN (الأثر الدائم) ]
local OpenBtn = Instance.new("TextButton", sg)
OpenBtn.Size = UDim2.new(0, 80, 0, 40); OpenBtn.Position = UDim2.new(0, 5, 0.5, 0)
OpenBtn.Text = "OPEN 🔓"; OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0); OpenBtn.TextColor3 = Color3.new(1, 1, 1)
OpenBtn.Visible = false; OpenBtn.TextScaled = true; Instance.new("UICorner", OpenBtn)

-- [ محرك الاختراق: سحب الرقم الحقيقي من السيرفر ]
local function GrabTrueNumber()
    Display.Text = "جاري اختراق 'جاري البحث'..."
    spawn(function()
        while true do
            local foundVal = nil
            -- البحث عن الرقم في "القيم المخفية" وليس في النصوص الظاهرة
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= player then
                    -- فحص مجلدات البيانات التي يرسلها السيرفر
                    for _, v in pairs(p:GetDescendants()) do
                        if (v:IsA("IntValue") or v:IsA("StringValue")) and tonumber(v.Value) and v.Value ~= 0 then
                            -- استبعاد الأرقام الطويلة (مثل ID اللاعب) والتركيز على أرقام التخمين (1-100)
                            local num = tonumber(v.Value)
                            if num > 0 and num <= 1000 then
                                foundVal = tostring(num)
                                break
                            end
                        end
                    end
                end
            end
            
            if foundVal then
                Display.Text = "رقم العدو الحقيقي: [" .. foundVal .. "]"
                Display.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
                Display.TextColor3 = Color3.new(1, 1, 1)
            else
                Display.Text = "في انتظار وضع العدو للرقم..."
            end
            task.wait(0.1) -- فحص سريع جداً لمنع التعليق
        end
    end)
end

-- [ أزرار التحكم ]
local function AddBtn(txt, pos, func)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.9, 0, 0, 50); b.Position = UDim2.new(0.05, 0, 0, pos)
    b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(40, 40, 40); b.TextColor3 = Color3.new(1, 1, 1); b.TextScaled = true
    b.MouseButton1Click:Connect(func); Instance.new("UICorner", b)
end

AddBtn("تفعيل كاشف الأرقام الحقيقية 👁️", 110, GrabTrueNumber)

-- زر الإغلاق (يترك أثر OPEN)
AddBtn("إغلاق (تحويل لـ Open) 🛑", 165, function()
    Main.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenBtn.Visible = false
end)
