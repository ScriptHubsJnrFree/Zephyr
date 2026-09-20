local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Limpiar interfaz anterior
local oldGui = PlayerGui:FindFirstChild("ZephyrHubsGui")
if oldGui then oldGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZephyrHubsGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

--------------------------------------------------------------------------------
-- 1. OVERLAY DE INTRODUCCIÓN
--------------------------------------------------------------------------------
local IntroOverlay = Instance.new("Frame")
IntroOverlay.Name = "IntroOverlay"
IntroOverlay.Size = UDim2.fromScale(1, 1)
IntroOverlay.Position = UDim2.fromScale(0, 0)
IntroOverlay.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
IntroOverlay.ZIndex = 1000
IntroOverlay.Parent = ScreenGui

local TerminalLabel = Instance.new("TextLabel")
TerminalLabel.Size = UDim2.new(0.5, 0, 0.45, 0)
TerminalLabel.Position = UDim2.fromOffset(15, 30)
TerminalLabel.BackgroundTransparency = 1
TerminalLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
TerminalLabel.Font = Enum.Font.Code
TerminalLabel.TextSize = 10
TerminalLabel.TextXAlignment = Enum.TextXAlignment.Left
TerminalLabel.TextYAlignment = Enum.TextYAlignment.Top
TerminalLabel.RichText = true
TerminalLabel.Text = ""
TerminalLabel.ZIndex = 1001
TerminalLabel.Parent = IntroOverlay

local CenterIntro = Instance.new("Frame")
CenterIntro.Size = UDim2.fromOffset(350, 160)
CenterIntro.AnchorPoint = Vector2.new(0.5, 0.5)
CenterIntro.Position = UDim2.fromScale(0.5, 0.5)
CenterIntro.BackgroundTransparency = 1
CenterIntro.ZIndex = 1001
CenterIntro.Parent = IntroOverlay

local LogoCircle = Instance.new("Frame")
LogoCircle.Size = UDim2.fromOffset(54, 54)
LogoCircle.AnchorPoint = Vector2.new(0.5, 0)
LogoCircle.Position = UDim2.new(0.5, 0, 0, 0)
LogoCircle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LogoCircle.ZIndex = 1002
LogoCircle.Parent = CenterIntro

local CircleCorner = Instance.new("UICorner")
CircleCorner.CornerRadius = UDim.new(1, 0)
CircleCorner.Parent = LogoCircle

local CircleStroke = Instance.new("UIStroke")
CircleStroke.Thickness = 2
CircleStroke.Color = Color3.fromRGB(255, 255, 255)
CircleStroke.Parent = LogoCircle

local IntroLogo = Instance.new("ImageLabel")
IntroLogo.Size = UDim2.fromOffset(36, 36)
IntroLogo.AnchorPoint = Vector2.new(0.5, 0.5)
IntroLogo.Position = UDim2.fromScale(0.5, 0.5)
IntroLogo.BackgroundTransparency = 1
IntroLogo.Image = "rbxassetid://76026241322125"
IntroLogo.ZIndex = 1003
IntroLogo.Parent = LogoCircle

local IntroTitle = Instance.new("TextLabel")
IntroTitle.Position = UDim2.new(0, 0, 0, 62)
IntroTitle.Size = UDim2.new(1, 0, 0, 20)
IntroTitle.BackgroundTransparency = 1
IntroTitle.Text = "Zephyr Hubs Script Premium"
IntroTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
IntroTitle.Font = Enum.Font.GothamBold
IntroTitle.TextSize = 13
IntroTitle.ZIndex = 1001
IntroTitle.Parent = CenterIntro

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Position = UDim2.new(0, 0, 0, 95)
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "INITIALIZING SYSTEM..."
StatusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
StatusLabel.Font = Enum.Font.Code
StatusLabel.TextSize = 12
StatusLabel.ZIndex = 1001
StatusLabel.Parent = CenterIntro

local WarningLabel = Instance.new("TextLabel")
WarningLabel.AnchorPoint = Vector2.new(0.5, 1)
WarningLabel.Position = UDim2.new(0.5, 0, 0.95, 0)
WarningLabel.Size = UDim2.new(1, 0, 0, 30)
WarningLabel.BackgroundTransparency = 1
WarningLabel.Text = "⚠️ DONT USE BEE HUB ITS SKID ⚠️"
WarningLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
WarningLabel.Font = Enum.Font.GothamBlack
WarningLabel.TextSize = 12
WarningLabel.ZIndex = 1001
WarningLabel.Parent = IntroOverlay

task.spawn(function()
    while IntroOverlay and IntroOverlay.Parent do
        local p = Instance.new("Frame")
        p.Size = UDim2.fromOffset(math.random(3, 6), math.random(3, 6))
        p.Position = UDim2.new(math.random(), 0, -0.05, 0)
        p.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        p.BackgroundTransparency = 0.3
        p.ZIndex = 1000
        p.Parent = IntroOverlay
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = p

        local duration = math.random(25, 45) / 10
        TweenService:Create(p, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
            Position = UDim2.new(p.Position.X.Scale, 0, 1.05, 0),
            BackgroundTransparency = 1
        }):Play()

        task.delay(duration, function() p:Destroy() end)
        task.wait(0.15)
    end
end)

--------------------------------------------------------------------------------
-- 2. MARCO PRINCIPAL (MENÚ)
--------------------------------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.fromOffset(510, 290)
MainFrame.Position = UDim2.new(0.5, -255, 0.5, -145)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 10
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 4)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.Parent = MainFrame

-- Barra Superior
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 42)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TopBar.BorderSizePixel = 0
TopBar.ZIndex = 11
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 4)
TopBarCorner.Parent = TopBar

local MainLogoBtn = Instance.new("ImageButton")
MainLogoBtn.Size = UDim2.fromOffset(30, 30)
MainLogoBtn.Position = UDim2.fromOffset(8, 6)
MainLogoBtn.BackgroundTransparency = 1
MainLogoBtn.Image = "rbxassetid://76026241322125"
MainLogoBtn.ZIndex = 12
MainLogoBtn.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Position = UDim2.fromOffset(46, 5)
Title.Size = UDim2.new(0, 180, 0, 16)
Title.BackgroundTransparency = 1
Title.Text = "Zephyr Hubs"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 12
Title.Parent = TopBar

local SubTitle = Instance.new("TextLabel")
SubTitle.Position = UDim2.fromOffset(46, 20)
SubTitle.Size = UDim2.new(0, 180, 0, 14)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Script Premium"
SubTitle.TextColor3 = Color3.fromRGB(140, 140, 140)
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 10
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.ZIndex = 12
SubTitle.Parent = TopBar

local StatsLabel = Instance.new("TextLabel")
StatsLabel.Position = UDim2.new(1, -210, 0, 11)
StatsLabel.Size = UDim2.new(0, 170, 0, 20)
StatsLabel.BackgroundTransparency = 1
StatsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatsLabel.Font = Enum.Font.Code
StatsLabel.TextSize = 10
StatsLabel.TextXAlignment = Enum.TextXAlignment.Right
StatsLabel.Text = "⚪ 10 SCRIPTS   FPS: 0   0ms"
StatsLabel.ZIndex = 12
StatsLabel.Parent = TopBar

local SavePlusBtn = Instance.new("TextButton")
SavePlusBtn.Name = "SavePlusBtn"
SavePlusBtn.Size = UDim2.fromOffset(26, 26)
SavePlusBtn.Position = UDim2.new(1, -34, 0, 8)
SavePlusBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SavePlusBtn.Text = "+"
SavePlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SavePlusBtn.Font = Enum.Font.GothamBold
SavePlusBtn.TextSize = 16
SavePlusBtn.ZIndex = 13
SavePlusBtn.Parent = TopBar

local SavePlusCorner = Instance.new("UICorner")
SavePlusCorner.CornerRadius = UDim.new(0, 4)
SavePlusCorner.Parent = SavePlusBtn

--------------------------------------------------------------------------------
-- 3. BOTÓN FLOTANTE CÍRCULO (UBICADO EN ESQUINA INFERIOR DERECHA)
--------------------------------------------------------------------------------
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.fromOffset(45, 45)
ToggleBtn.Position = UDim2.new(1, -65, 1, -65)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleBtn.Image = "rbxassetid://76026241322125"
ToggleBtn.Visible = false
ToggleBtn.ZIndex = 500
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Thickness = 2
ToggleStroke.Color = Color3.fromRGB(255, 255, 255)
ToggleStroke.Parent = ToggleBtn

SavePlusBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    ToggleBtn.Visible = true
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

--------------------------------------------------------------------------------
-- 4. PESTAÑAS Y CONTENIDO
--------------------------------------------------------------------------------
local TabContainer = Instance.new("Frame")
TabContainer.Position = UDim2.fromOffset(0, 44)
TabContainer.Size = UDim2.new(1, 0, 0, 28)
TabContainer.BackgroundTransparency = 1
TabContainer.ZIndex = 11
TabContainer.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.FillDirection = Enum.FillDirection.Horizontal
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabListLayout.Padding = UDim.new(0, 10)
TabListLayout.Parent = TabContainer

local ScriptsPage = Instance.new("Frame")
ScriptsPage.Size = UDim2.new(1, 0, 1, -74)
ScriptsPage.Position = UDim2.fromOffset(0, 74)
ScriptsPage.BackgroundTransparency = 1
ScriptsPage.Visible = true
ScriptsPage.ZIndex = 11
ScriptsPage.Parent = MainFrame

local FpsBoostPage = Instance.new("Frame")
FpsBoostPage.Size = UDim2.new(1, 0, 1, -74)
FpsBoostPage.Position = UDim2.fromOffset(0, 74)
FpsBoostPage.BackgroundTransparency = 1
FpsBoostPage.Visible = false
FpsBoostPage.ZIndex = 11
FpsBoostPage.Parent = MainFrame

local tabs = {}
local function CreateTabButton(name, targetPage)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 1, 0)
    btn.BackgroundColor3 = (targetPage == ScriptsPage) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(30, 30, 30)
    btn.Text = name
    btn.TextColor3 = (targetPage == ScriptsPage) and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.AutoButtonColor = false
    btn.ZIndex = 12
    btn.Parent = TabContainer

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = btn

    tabs[name] = {Btn = btn, Page = targetPage}

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            t.Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            if t.Page then t.Page.Visible = false end
        end
        btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextColor3 = Color3.fromRGB(0, 0, 0)
        if targetPage then targetPage.Visible = true end
    end)
    return btn
end

CreateTabButton("SCRIPTS", ScriptsPage)
CreateTabButton("FPS BOOST", FpsBoostPage)

--------------------------------------------------------------------------------
-- PESTAÑA SCRIPTS (SCRIPTS CON KEY Y KEYLESS)
--------------------------------------------------------------------------------
local FilterContainer = Instance.new("Frame")
FilterContainer.Position = UDim2.fromOffset(0, 2)
FilterContainer.Size = UDim2.new(1, 0, 0, 20)
FilterContainer.BackgroundTransparency = 1
FilterContainer.ZIndex = 11
FilterContainer.Parent = ScriptsPage

local FilterLayout = Instance.new("UIListLayout")
FilterLayout.FillDirection = Enum.FillDirection.Horizontal
FilterLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
FilterLayout.Padding = UDim.new(0, 12)
FilterLayout.Parent = FilterContainer

local ScriptScroll = Instance.new("ScrollingFrame")
ScriptScroll.Position = UDim2.fromOffset(10, 26)
ScriptScroll.Size = UDim2.new(1, -20, 1, -30)
ScriptScroll.BackgroundTransparency = 1
ScriptScroll.BorderSizePixel = 0
ScriptScroll.ScrollBarThickness = 3
ScriptScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
ScriptScroll.ZIndex = 11
ScriptScroll.Parent = ScriptsPage

local ScrollLayout = Instance.new("UIListLayout")
ScrollLayout.Padding = UDim.new(0, 6)
ScrollLayout.Parent = ScriptScroll

local scriptRows = {}

local function AddScriptRow(titleText, isKey, codeUrl)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, -4, 0, 36)
    Row.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Row.BorderSizePixel = 0
    Row.ZIndex = 12
    Row.Parent = ScriptScroll

    local RowCorner = Instance.new("UICorner")
    RowCorner.CornerRadius = UDim.new(0, 4)
    RowCorner.Parent = Row

    local RowTitle = Instance.new("TextLabel")
    RowTitle.Position = UDim2.fromOffset(10, 0)
    RowTitle.Size = UDim2.new(0, 180, 1, 0)
    RowTitle.BackgroundTransparency = 1
    RowTitle.Text = titleText
    RowTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    RowTitle.Font = Enum.Font.GothamBold
    RowTitle.TextSize = 11
    RowTitle.TextXAlignment = Enum.TextXAlignment.Left
    RowTitle.ZIndex = 13
    RowTitle.Parent = Row

    local Tag = Instance.new("TextLabel")
    Tag.Position = UDim2.new(1, -155, 0.2, 0)
    Tag.Size = UDim2.new(0, 70, 0.6, 0)
    Tag.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Tag.Text = isKey and "KEY" or "KEYLESS"
    Tag.TextColor3 = isKey and Color3.fromRGB(200, 200, 200) or Color3.fromRGB(100, 255, 100)
    Tag.Font = Enum.Font.GothamBold
    Tag.TextSize = 9
    Tag.ZIndex = 13
    Tag.Parent = Row

    local TagCorner = Instance.new("UICorner")
    TagCorner.CornerRadius = UDim.new(0, 4)
    TagCorner.Parent = Tag

    local ExecBtn = Instance.new("TextButton")
    ExecBtn.Position = UDim2.new(1, -78, 0.2, 0)
    ExecBtn.Size = UDim2.new(0, 70, 0.6, 0)
    ExecBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ExecBtn.Text = "EXECUTE"
    ExecBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    ExecBtn.Font = Enum.Font.GothamBold
    ExecBtn.TextSize = 9
    ExecBtn.ZIndex = 13
    ExecBtn.Parent = Row

    local ExecCorner = Instance.new("UICorner")
    ExecCorner.CornerRadius = UDim.new(0, 4)
    ExecCorner.Parent = ExecBtn

    ExecBtn.MouseButton1Click:Connect(function()
        if codeUrl then
            task.spawn(function()
                loadstring(game:HttpGet(codeUrl, true))()
            end)
        end
    end)

    table.insert(scriptRows, {Frame = Row, IsKey = isKey})
end

-- Scripts con Key
AddScriptRow("SPEED HUB", true, "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua")
AddScriptRow("BF", true, "https://raw.githubusercontent.com/hanniii1/Loader/refs/heads/main/BFLoader.lua")
AddScriptRow("ON HUB", true, "https://api.luarmor.net/files/v4/loaders/36107afd3107e8d841f9d1a69e2465d4.lua")
AddScriptRow("FYY", true, "https://FyyCommunity.com")
AddScriptRow("AJJANS", true, "https://api.luarmor.net/files/v4/loaders/36107afd3107e8d841f9d1a69e2465d4.lua")

-- Scripts No Key (Keyless)
AddScriptRow("LENNON HUB", false, "https://raw.githubusercontent.com/lennonxscripts/lennonhubv3/refs/heads/main/stealanegg.lua")
AddScriptRow("MIRANDA HUB", false, "https://raw.githubusercontent.com/miirandahub/loader/refs/heads/main/stealaeggs")
AddScriptRow("CHILLI", false, "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua")
AddScriptRow("BLYXO HUB", false, "https://flowauth.net/v1/loaders/69d3463240384f3a73fbe32c178093a2.lua")
AddScriptRow("LKZ HUB", false, "https://raw.githubusercontent.com/LucasggkX/LKZ-Hub/refs/heads/main/Loader.lua")

local filterButtons = {}
local function FilterScripts(mode)
    for filterName, btn in pairs(filterButtons) do
        btn.TextColor3 = (filterName == mode) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(110, 110, 110)
    end

    for _, item in ipairs(scriptRows) do
        if mode == "ALL" then
            item.Frame.Visible = true
        elseif mode == "KEY" then
            item.Frame.Visible = item.IsKey
        elseif mode == "KEYLESS" then
            item.Frame.Visible = not item.IsKey
        end
    end
end

local function CreateFilterButton(name, mode, active)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 65, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = name
    btn.TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(110, 110, 110)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.ZIndex = 12
    btn.Parent = FilterContainer

    filterButtons[mode] = btn

    btn.MouseButton1Click:Connect(function()
        FilterScripts(mode)
    end)
    return btn
end

CreateFilterButton("ALL", "ALL", true)
CreateFilterButton("KEY", "KEY", false)
CreateFilterButton("KEYLESS", "KEYLESS", false)

--------------------------------------------------------------------------------
-- PESTAÑA FPS BOOST
--------------------------------------------------------------------------------
local ResetFpsBtn = Instance.new("TextButton")
ResetFpsBtn.Position = UDim2.new(0.5, -90, 0, 4)
ResetFpsBtn.Size = UDim2.new(0, 180, 0, 26)
ResetFpsBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ResetFpsBtn.Text = "RESET SETTINGS"
ResetFpsBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
ResetFpsBtn.Font = Enum.Font.GothamBold
ResetFpsBtn.TextSize = 10
ResetFpsBtn.ZIndex = 12
ResetFpsBtn.Parent = FpsBoostPage

local ResetFpsCorner = Instance.new("UICorner")
ResetFpsCorner.CornerRadius = UDim.new(0, 4)
ResetFpsCorner.Parent = ResetFpsBtn

ResetFpsBtn.MouseButton1Click:Connect(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
    Lighting.GlobalShadows = true
end)

local FpsScroll = Instance.new("ScrollingFrame")
FpsScroll.Position = UDim2.fromOffset(10, 36)
FpsScroll.Size = UDim2.new(1, -20, 1, -40)
FpsScroll.BackgroundTransparency = 1
FpsScroll.BorderSizePixel = 0
FpsScroll.ScrollBarThickness = 3
FpsScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
FpsScroll.ZIndex = 11
FpsScroll.Parent = FpsBoostPage

local FpsLayout = Instance.new("UIListLayout")
FpsLayout.Padding = UDim.new(0, 6)
FpsLayout.Parent = FpsScroll

local function AddFpsRow(optionName, applyCallback)
    local Row = Instance.new("Frame")
    Row.Size = UDim2.new(1, -4, 0, 36)
    Row.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Row.BorderSizePixel = 0
    Row.ZIndex = 12
    Row.Parent = FpsScroll

    local RowCorner = Instance.new("UICorner")
    RowCorner.CornerRadius = UDim.new(0, 4)
    RowCorner.Parent = Row

    local Title = Instance.new("TextLabel")
    Title.Position = UDim2.fromOffset(10, 0)
    Title.Size = UDim2.new(0, 180, 1, 0)
    Title.BackgroundTransparency = 1
    Title.Text = optionName
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 10
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.ZIndex = 13
    Title.Parent = Row

    local ApplyBtn = Instance.new("TextButton")
    ApplyBtn.Position = UDim2.new(1, -78, 0.2, 0)
    ApplyBtn.Size = UDim2.new(0, 70, 0.6, 0)
    ApplyBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ApplyBtn.Text = "APPLY"
    ApplyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    ApplyBtn.Font = Enum.Font.GothamBold
    ApplyBtn.TextSize = 9
    ApplyBtn.ZIndex = 13
    ApplyBtn.Parent = Row

    local ApplyCorner = Instance.new("UICorner")
    ApplyCorner.CornerRadius = UDim.new(0, 4)
    ApplyCorner.Parent = ApplyBtn

    ApplyBtn.MouseButton1Click:Connect(function()
        if applyCallback then applyCallback() end
        ApplyBtn.Text = "DONE"
        task.wait(1)
        ApplyBtn.Text = "APPLY"
    end)
end

AddFpsRow("REMOVE TEXTURES", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Texture") then v:Destroy() end
    end
end)

AddFpsRow("REMOVE DECALS", function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Decal") then v:Destroy() end
    end
end)

AddFpsRow("LOW GRAPHICS LEVEL", function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)

AddFpsRow("DISABLE SHADOWS", function()
    Lighting.GlobalShadows = false
end)

AddFpsRow("REMOVE POST EFFECTS", function()
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") then v.Enabled = false end
    end
end)

AddFpsRow("SUPER FPS BOOST (ALL)", function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    Lighting.GlobalShadows = false
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
        elseif v:IsA("Texture") or v:IsA("Decal") then
            v:Destroy()
        end
    end
end)

--------------------------------------------------------------------------------
-- 5. MEDIDOR DE FPS Y ARRASTRE
--------------------------------------------------------------------------------
local lastUpdate = os.clock()
local frameCount = 0

RunService.RenderStepped:Connect(function()
    frameCount = frameCount + 1
    local now = os.clock()
    if now - lastUpdate >= 0.5 then
        local fps = math.floor(frameCount / (now - lastUpdate))
        local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        StatsLabel.Text = string.format("⚪ 10 SCRIPTS   FPS: %d   %dms", fps, ping)
        frameCount = 0
        lastUpdate = now
    end
end)

local function EnableDrag(frameToDrag, dragHandle)
    local dragging, dragInput, dragStart, startPos
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frameToDrag.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frameToDrag.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

EnableDrag(MainFrame, TopBar)
EnableDrag(ToggleBtn, ToggleBtn)

--------------------------------------------------------------------------------
-- 6. SECUENCIA DE INICIO
--------------------------------------------------------------------------------
task.spawn(function()
    local logs = {
        "> Checking system...",
        "> Initializing...",
        "> Injecting...",
        "> Loading assets...",
        "> Establishing secure socket connection...",
        "> Loading player data for: " .. LocalPlayer.Name,
        "> Bypassing Client-Side Validation [OK]",
        "> Injecting ZephyrHubs_Engine.lua...",
        "> Compiled successfully in 0.04s",
        '<font color="rgb(50, 220, 100)">> Checking dependencies... [BEE HUB DETECTED - DISCARDED]</font>'
    }

    for _, log in ipairs(logs) do
        TerminalLabel.Text = TerminalLabel.Text .. log .. "\n"
        task.wait(0.25)
    end

    StatusLabel.Text = "BYPASSING SECURITY..."
    task.wait(0.8)

    StatusLabel.Text = "WELCOME, " .. string.upper(LocalPlayer.Name)
    task.wait(1.2)

    IntroOverlay:Destroy()
    MainFrame.Visible = true
end)
