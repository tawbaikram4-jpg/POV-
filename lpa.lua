-- [[ ♛ SATAYA VIP - THE ENEMY RADAR ♛ ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- إعداد القائمة الملكية الهادئة
if pgui:FindFirstChild("SatayaMenuV1") then pgui.SatayaMenuV1:Destroy() end
local sg = Instance.new("ScreenGui", pgui); sg.Name = "SatayaMenuV1"; sg.ResetOnSpawn = false

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 300, 0, 250); Main.Position = UDim2.new(0.5, -150, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)

local Title = Instance.new("TextLabel", Main)
Title.Text = "♛ SATAYA VIP MENU ♛"; Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(40, 0, 0); Title.TextColor3 = Color3.new(1, 1, 1); Title.TextScaled = true

local Display = Instance.new("TextLabel", Main)
Display.Text = "في انتظار رقم الخصم..."; Display.Position = UDim2.new(0, 0, 0, 45); Display.Size = UDim2.new(1, 0, 0, 70)
Display.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Display.TextColor3 = Color3.new(0, 1, 0); Display.TextScaled = true

-- [ محرك كشف رقم الخصم ]
local function StartEnemyHack()
    spawn(function()
        while true do
            local enemyNumber = "..."
            -- فحص جميع اللاعبين (الخصوم)
            for _, other in pairs(game.Players:GetPlayers()) do
                if other ~= player and other.Character then
                    -- البحث عن الرقم فوق رأس الخصم (الورقة/الفقاعة)
                    local billboard = other.Character:FindFirstChildWhichIsA("BillboardGui", true)
                    if billboard then
                        local label = billboard:FindFirstChildWhichIsA("TextLabel", true)
                        if label and label.Text ~= "" and tonumber(label.Text) then
                            enemyNumber = label.Text
                            break
                        end
                    end
                    -- فحص القيم المخفية داخل الخصم
                    if enemyNumber == "..." then
                        for _, v in pairs(other:GetDescendants()) do
                            if (v.Name:lower():find("target") or v.Name:lower():find("value")) and v:IsA("IntValue") then
                                enemyNumber = tostring(v.Value)
                                break
                            end
                        end
                    end
                end
            end
            
            -- تحديث القائمة فوراً
            if enemyNumber ~= "..." then
                Display.Text = "رقم الخصم هو: [" .. enemyNumber .. "]"
                Display.BackgroundColor3 = Color3.fromRGB(0, 80, 0) -- أخضر عند كشفه
            else
                Display.Text = "جاري اختراق الخصم..."
                Display.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
            end
            task.wait(0.3)
        end
    end)
end

-- [ إضافة الأزرار ]
local function AddBtn(txt, pos, func)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.9, 0, 0, 50); b.Position = UDim2.new(0.05, 0, 0, pos)
    b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(30, 30, 30); b.TextColor3 = Color3.new(1, 1, 1); b.TextScaled = true
    b.MouseButton1Click:Connect(func); Instance.new("UICorner", b)
end

AddBtn("تفعيل كاشف رقم الخصم 👁️", 120, StartEnemyHack)
AddBtn("إغلاق القائمة (X)", 185, function() sg:Destroy() end)
