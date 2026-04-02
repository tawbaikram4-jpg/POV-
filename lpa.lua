-- [[ ♛ SATAYA VIP - HIDDEN PASSCODE SNIPER ♛ ]] --
local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")

-- إعداد القائمة الملكية السرية
if pgui:FindFirstChild("SatayaVault") then pgui.SatayaVault:Destroy() end
local sg = Instance.new("ScreenGui", pgui); sg.Name = "SatayaVault"; sg.ResetOnSpawn = false

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 300, 0, 260); Main.Position = UDim2.new(0.5, -150, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main)

local Title = Instance.new("TextLabel", Main)
Title.Text = "♛ SATAYA PRIVATE VAULT ♛"; Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30); Title.TextColor3 = Color3.new(1, 0.8, 0); Title.TextScaled = true

-- مربع عرض الباسورد (سيكون مخفياً في البداية)
local Display = Instance.new("TextLabel", Main)
Display.Text = "رقم العدو: [ **** ]"; Display.Position = UDim2.new(0, 0, 0, 45); Display.Size = UDim2.new(1, 0, 0, 70)
Display.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Display.TextColor3 = Color3.new(1, 1, 1); Display.TextScaled = true

local RealNumber = "" -- المتغير الذي سيحفظ الرقم الحقيقي بعيداً عن الأعين

-- [ محرك سحب رقم العدو وتخزينه سرياً ]
local function StartSecretHack()
    spawn(function()
        while true do
            local foundNumber = ""
            for _, other in pairs(game.Players:GetPlayers()) do
                if other ~= player and other.Character then
                    -- فحص "الورقة" أو "القيم" المخفية
                    local bb = other.Character:FindFirstChildWhichIsA("BillboardGui", true)
                    if bb then
                        local txt = bb:FindFirstChildWhichIsA("TextLabel", true)
                        if txt and txt.Text ~= "" and tonumber(txt.Text) then
                            foundNumber = txt.Text
                            break
                        end
                    end
                end
            end
            
            if foundNumber ~= "" then
                RealNumber = foundNumber
                if Display.Text:find("*") then
                    Display.Text = "رقم العدو: [ تم الالتقاط ]"
                    Display.BackgroundColor3 = Color3.fromRGB(0, 50, 0)
                end
            else
                Display.Text = "رقم العدو: [ يبحث... ]"
                Display.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
            end
            task.wait(0.5)
        end
    end)
end

-- [ أزرار التحكم ]
local function AddBtn(txt, pos, func)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.9, 0, 0, 45); b.Position = UDim2.new(0.05, 0, 0, pos)
    b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(40, 40, 40); b.TextColor3 = Color3.new(1, 1, 1); b.TextScaled = true
    b.MouseButton1Click:Connect(func); Instance.new("UICorner", b)
end

AddBtn("تفعيل القناص السري 👁️", 120, StartSecretHack)

-- زر "إظهار / إخفاء" الباسورد
AddBtn("إظهار الرقم الحقيقي 🔓", 170, function(btn)
    if RealNumber ~= "" then
        if Display.Text:find("*") or Display.Text:find("تم") then
            Display.Text = "رقم العدو هو: [" .. RealNumber .. "]"
            Display.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
            btn.Text = "إخفاء الرقم 🔒"
        else
            Display.Text = "رقم العدو: [ **** ]"
            Display.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            btn.Text = "إظهار الرقم الحقيقي 🔓"
        end
    end
end)

AddBtn("إغلاق (X)", 220, function() sg:Destroy() end)
