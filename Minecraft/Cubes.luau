-- Minecraft Commands --
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local G = _G or {}
local _RBXScriptSignal_1 = false
G.Commands_Script_Language_Test = {}

local CmdbarFocused = false
local SettingsUIEnable = false
local RainbowEnable = false
local LabelTextColor = Color3.fromRGB(255, 255, 255)
local DefaultBGColor = Color3.fromRGB(0, 0, 0)
local CanvasHeight = 0
local ButtonHeight, ButtonPadding = 25, 2

local EndPoint = UDim2.new(0, 0, 0.1, 0)
local StartPoint = UDim2.new(-0.25, 0, 0.1, 0)

local ScreenGui = Instance.new("ScreenGui", CoreGui)
local CmdBox = Instance.new("TextBox", ScreenGui)
local ToggleButton = Instance.new("TextButton", CmdBox)
local SuggestionLabel = Instance.new("TextLabel", CmdBox)
local SettingsFrame = Instance.new("Frame", ScreenGui)
local SettingsScroll = Instance.new("ScrollingFrame", SettingsFrame)

local SlideOut = TweenService:Create(CmdBox, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = EndPoint})
local SlideIn = TweenService:Create(CmdBox, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Position = StartPoint})

CmdBox.BackgroundTransparency = 0.8
CmdBox.BackgroundColor3 = DefaultBGColor
CmdBox.Position = StartPoint
CmdBox.Size = UDim2.new(0.25, 0, 0.065, 0)
CmdBox.TextScaled = true
CmdBox.TextSize = 9
CmdBox.TextColor3 = Color3.fromRGB(0, 255, 0)
CmdBox.Font = Enum.Font.Code
CmdBox.Text = ""
CmdBox.ClearTextOnFocus = true
CmdBox.PlaceholderText = G.Commands_Script_Language_Test[1] or "Commands ?"
CmdBox.Visible = true

ToggleButton.BackgroundTransparency = 0.8
ToggleButton.BackgroundColor3 = DefaultBGColor
ToggleButton.Position = UDim2.new(1.02, 0, 0, 0)
ToggleButton.Size = UDim2.new(0.15, 0, 1, 0)
ToggleButton.TextScaled = true
ToggleButton.TextSize = 9
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.Code
ToggleButton.Text = G.Commands_Script_Language_Test[2] or ">"
ToggleButton.Visible = true

SuggestionLabel.BackgroundTransparency = 1
SuggestionLabel.Position = UDim2.new(0.02, 0, 1.02, 0)
SuggestionLabel.Size = UDim2.new(0.96, 0, 0.45, 0)
SuggestionLabel.TextScaled = true
SuggestionLabel.TextSize = 8.5
SuggestionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SuggestionLabel.Font = Enum.Font.Code
SuggestionLabel.Text = G.Commands_Script_Language_Test[4] or "</>"
SuggestionLabel.Visible = true

SettingsFrame.BackgroundTransparency = 0.8
SettingsFrame.BackgroundColor3 = DefaultBGColor
SettingsFrame.Position = UDim2.new(0.45, 0, 0.2, 0)
SettingsFrame.Size = UDim2.new(0.25, 0, 0.6, 0)
SettingsFrame.Active = true
SettingsFrame.Draggable = true
SettingsFrame.Visible = SettingsUIEnable

SettingsScroll.BackgroundTransparency = 0.9
SettingsScroll.BackgroundColor3 = DefaultBGColor
SettingsScroll.Position = UDim2.new(0.05, 0, 0.05, 0)
SettingsScroll.Size = UDim2.new(0.9, 0, 0.9, 0)
SettingsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SettingsScroll.ScrollBarThickness = 0.1
SettingsScroll.Visible = true

local function Notice(title, text, duration, core)
    if core == "SendNotification" or core == "DevConsoleVisible" then
        StarterGui:SetCore(core, core == "SendNotification" and {
            Title = title,
            Text = text,
            Duration = duration
        } or true)
    end
end

local function AddedCubeOrRemove(...)
    local a = {...}
    if not _RBXScriptSignal_1 then
        _RBXScriptSignal_1 = true
        loadstring(game:HttpGet("https://pastefy.app/IravR3Iu/raw"))()
        Notice("Commands", "Successfully loaded function!", 1, "SendNotification")
    end
    
    if a[1] == "yes" then
        if not LocalPlayer.Backpack:FindFirstChild("Grass") or not LocalPlayer.Backpack:FindFirstChild("Cỏ") then
            local clonedtools = Workspace._HHxScript_Storage._HHxScript_Tools_Storage:FindFirstChild("Grass") or Workspace._HHxScript_Storage._HHxScript_Tools_Storage:FindFirstChild("Cỏ")
            clonedtools:Destroy() --.Parent = LocalPlayer.Backpack
            task.wait()
            loadstring(game:HttpGet("https://pastefy.app/IravR3Iu/raw"))()
            Notice("Commands", "Added: Grass block to your backpack!", 1, "SendNotification")
        else
            Notice("Commands", "Already having a Grass block in your backpack!", 1, "SendNotification")
        end
    elseif a[1] == "no" then
        for i, v in pairs(Workspace._HHxScript_Storage:GetDescendants()) do
            if v:IsA("Part") and v:FindFirstChildOfClass("Decal") or v:FindFirstChild("Decal") then
                v:Destroy()
            end
        end
    end
end

local function AddCornerUI(obj, radius)
    local c = Instance.new("UICorner", obj)
    c.CornerRadius = UDim.new(radius, 0)
end

local function ThemeChanged(color)
    CmdBox.BackgroundColor3 = color
    SuggestionLabel.BackgroundColor3 = color
    ToggleButton.BackgroundColor3 = color
    SettingsFrame.BackgroundColor3 = color
    SettingsScroll.BackgroundColor3 = color
end

local function AddSettingButton(name, callback)
    local btn = Instance.new("TextButton", SettingsScroll)
    btn.BackgroundColor3 = DefaultBGColor
    btn.Position = UDim2.new(0.02, 0, 0, CanvasHeight + ButtonPadding)
    btn.Size = UDim2.new(0.96, 0, 0, ButtonHeight)
    btn.TextScaled = true
    btn.TextSize = 9
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Code
    btn.Text = name
    btn.Visible = true
    AddCornerUI(btn, 0.2)
    btn.MouseButton1Click:Connect(callback)
    CanvasHeight += ButtonHeight + ButtonPadding
    SettingsScroll.CanvasSize = UDim2.new(0, 0, 0, CanvasHeight)
end

local Aliases = {
    ["reset"] = {"reset", "re"},
    ["give"] = {"give", "get", "g"},
    ["removeblock"] = {"removeblock", "delcubes", "nocube", "rb"}
}

local function RunCommands()
    local input = CmdBox.Text
    local words = {}
    for word in input:gmatch("%S+") do
        table.insert(words, word)
    end
    if table.find(Aliases["reset"], words[1]) then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.Health = 0
        end
        Notice("Commands", "Character Reseted!", 1, "SendNotification")
    elseif table.find(Aliases["give"], words[1]) then
        if words[2] == "grass" then
            AddedCubeOrRemove("yes")
        else
            Notice("Commands", "Missing arguments 2!", 1, "SendNotification")
        end
    elseif table.find(Aliases["removeblock"], words[1]) then
        AddedCubeOrRemove("no")
        Notice("Commands", "Removed all cubes!", 1, "SendNotification")
    end
    CmdBox.Text = ""
end

local function UpdateSuggestion(show)
    local input = CmdBox.Text:lower()
    local found, display
    if input ~= "" then
        for cmd, list in pairs(Aliases) do
            for i, alias in ipairs(list) do
                if alias:find(input) then
                    found = cmd
                    display = cmd .. ", " .. table.concat(list, ", ", 2)
                    break
                end
            end
            if found then break end
        end
    end
    SuggestionLabel.Text = show and (display or G.Commands_Script_Language_Test[4] or "</>") or (found or "")
end

ToggleButton.MouseButton1Click:Connect(function()
    if ToggleButton.Text == "<" and CmdBox.Position == EndPoint then
        ToggleButton.Text = ">"
        SlideIn:Play()
    else
        CmdBox:CaptureFocus()
    end
end)

CmdBox.FocusLost:Connect(function(enter)
    if enter then
        CmdbarFocused = false
        SlideIn:Play()
        ToggleButton.Text = G.Commands_Script_Language_Test[2] or ">"
        pcall(RunCommands)
    end
end)

CmdBox.Focused:Connect(function()
    CmdbarFocused = true
    SlideOut:Play()
    ToggleButton.Text = G.Commands_Script_Language_Test[3] or "<"
end)

RunService.RenderStepped:Connect(function()
    if CmdbarFocused then
        UpdateSuggestion(true)
    end
end)

AddCornerUI(CmdBox, 0.2)
AddCornerUI(ToggleButton, 0.2)
AddCornerUI(SuggestionLabel, 0.2)
AddCornerUI(SettingsFrame, 0.05)
AddCornerUI(SettingsScroll, 0.2)

AddSettingButton("Theme: Default", function()
    ThemeChanged(DefaultBGColor)
    Notice("Theme", "Default color set!", 1, "SendNotification")
end)

AddSettingButton("Theme: Skyblue", function()
    ThemeChanged(Color3.fromRGB(0, 200, 200))
    Notice("Theme", "Skyblue color set!", 1, "SendNotification")
end)

AddSettingButton("Theme: Crimson", function()
    ThemeChanged(Color3.fromRGB(255, 0, 0))
    Notice("Theme", "Crimson color set!", 1, "SendNotification")
end)

AddSettingButton("TextColor: Rainbow", function()
    if not RainbowEnable then
        RainbowEnable = true
        Notice("Theme", "Rainbow text color!", 1, "SendNotification")
    else
        RainbowEnable = false
        task.delay(0.2, function()
            SuggestionLabel.TextColor3 = LabelTextColor
            Notice("Theme", "Default text color!", 1, "SendNotification")
        end)
    end
    while RainbowEnable do
        SuggestionLabel.TextColor3 = Color3.fromRGB(math.random(255), math.random(255), math.random(255))
        wait(0.24)
    end
end)

Notice("Commands Scripts", "Completely Loaded!", 1, "SendNotification")
