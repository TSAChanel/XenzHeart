-- [[ XENZ STORE: HEART TOPIA PREMIUM MOD ]]
-- [[ CRACKED LOGIC + INTEGRATED KEY SYSTEM ]]

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()

-- [[ ส่วนจัดการคีย์ - แก้ไขตรงนี้เพื่อเปลี่ยนคีย์ขายในแต่ละวัน ]]
local CorrectKey = "XENZ-WIN-2026" 

local Window = Fluent:CreateWindow({
    Title = "XENZ STORE | Heartopia Premium",
    SubTitle = "v2.5 Cracked Edition",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Home", Icon = "home" }),
    Key = Window:AddTab({ Title = "Key System", Icon = "key" }),
    AutoFarm = Window:AddTab({ Title = "Auto Farm", Icon = "shrub" }),
    Misc = Window:AddTab({ Title = "Misc & Speed", Icon = "zap" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options
local KeyVerified = false

-- [[ หน้าแรก Information ]]
Tabs.Main:AddParagraph({
    Title = "XENZ STORE - Official Release",
    Content = "ยินดีต้อนรับสู่ระบบ Heartopia Mod โดยค่าย Xenz Store\nสถานะ: ปลอดภัย (Undetected)\nกรุณาใส่คีย์เพื่อเปิดใช้งานฟังก์ชัน"
})

Tabs.Main:AddButton({
    Title = "Join Discord Shop",
    Callback = function()
        setclipboard("https://discord.gg/XenzStore")
        Fluent:Notify({Title = "Xenz Store", Content = "Discord Link Copied!", Duration = 3})
    end
})

-- [[ ระบบเช็คคีย์ ]]
Tabs.Key:AddInput("KeyInput", {
    Title = "ใส่คีย์เพื่อเริ่มใช้งาน",
    Default = "",
    Placeholder = "Enter Key...",
    Callback = function(Value)
        if Value == CorrectKey then
            KeyVerified = true
            Fluent:Notify({Title = "Success", Content = "ปลดล็อคเรียบร้อย! ยินดีด้วย", Duration = 5})
        else
            Fluent:Notify({Title = "Error", Content = "คีย์ไม่ถูกต้อง!", Duration = 5})
        end
    end
})

-- [[ ฟังก์ชันโกง (แครกจาก GitHub แหล่งข้อมูล) ]]
local ToggleFarm = Tabs.AutoFarm:AddToggle("FarmItems", {Title = "Auto Collect Everything", Default = false})

task.spawn(function()
    while true do
        if Options.FarmItems.Value then
            if KeyVerified then
                pcall(function()
                    -- Logic แครกพิเศษ: ดึง Object ที่มี TouchInterest ทั่วแมพ
                    for _, obj in pairs(game.Workspace:GetChildren()) do
                        if obj:IsA("Model") and obj:FindFirstChild("TouchInterest") then
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 0)
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, obj, 1)
                        end
                    end
                end)
            else
                Options.FarmItems:SetValue(false)
                Fluent:Notify({Title = "Locked", Content = "กรุณาใส่คีย์ก่อนใช้งาน", Duration = 3})
            end
        end
        task.wait(0.1)
    end
end)

-- [[ ปรับความเร็ว & แสงสว่าง ]]
Tabs.Misc:AddSlider("WalkSpeed", {
    Title = "Custom Speed",
    Min = 16, Max = 250, Default = 16,
    Callback = function(Value)
        if KeyVerified then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end
})

Tabs.Misc:AddButton({
    Title = "Full Bright (สว่างทั้งแมพ)",
    Callback = function()
        if KeyVerified then
            game.Lighting.FogEnd = 9e9
            game.Lighting.Brightness = 2
        end
    end
})

SaveManager:SetLibrary(Fluent)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)

Fluent:Notify({Title = "XENZ STORE", Content = "Premium Script Loaded!", Duration = 5})
