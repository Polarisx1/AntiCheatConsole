-- AntiCheatConsole All-in-One Loader
loadstring([[
-- == AntiCheatConsole v1.0 - Apocalypse Mode ==
-- Everything self-contained for testing & debugging your AntiCheatSwords

local Console = {}
Console.Settings = {
    EnableSwordTouch = false,
    LogHits = true,
    DisableAgeCheck = false,
    TrackPals = true,
    DisableAll = false,
}

-- Create GUI
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AntiCheatConsoleGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 220)
Frame.Position = UDim2.new(0.05,0,0.05,0)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0,5)
UIListLayout.FillDirection = Enum.FillDirection.Vertical
UIListLayout.Parent = Frame

local function createToggle(name, default)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1,0,0,30)
    Btn.Text = name..": "..tostring(default)
    Btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    Btn.TextColor3 = Color3.fromRGB(255,255,255)
    Btn.Parent = Frame
    Btn.MouseButton1Click:Connect(function()
        Console.Settings[name] = not Console.Settings[name]
        Btn.Text = name..": "..tostring(Console.Settings[name])
    end)
end

for setting,_ in pairs(Console.Settings) do
    createToggle(setting, Console.Settings[setting])
end

-- Keybind toggle for GUI visibility
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input,gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        Frame.Visible = not Frame.Visible
    end
end)

-- Hooking AntiCheatSwords
local AntiScript = LocalPlayer.PlayerGui:FindFirstChild("AntiCheatSwords")
if AntiScript then
    AntiScript.Enabled = false -- disable original script
end

-- Overriding Functions
function Console:TrackMySword(tool, handle)
    if not handle then return end
    handle.Touched:Connect(function(hit)
        if Console.Settings.DisableAll then return end
        if Console.Settings.LogHits then
            print("Hit Detected! Tool:", tool.Name, "Hit:", hit.Name)
        end
        if Console.Settings.EnableSwordTouch then
            local isTouched = tool:FindFirstChild("IsTouched")
            if isTouched and hit.Parent:FindFirstChild("HumanoidRootPart") then
                isTouched:FireServer(hit.Parent, hit.Parent.HumanoidRootPart.Position)
            end
        end
    end)
end

function Console:TrackCharacter(char)
    char.ChildAdded:Connect(function(child)
        if child:IsA("Tool") and child:FindFirstChild("Handle") and child:FindFirstChild("IsTouched") then
            Console:TrackMySword(child, child.Handle)
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(function(char)
    Console:TrackCharacter(char)
end)
if LocalPlayer.Character then
    Console:TrackCharacter(LocalPlayer.Character)
end

-- Auto-apply to existing tools
for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
    if tool:IsA("Tool") and tool:FindFirstChild("Handle") and tool:FindFirstChild("IsTouched") then
        Console:TrackMySword(tool, tool.Handle)
    end
end

-- Debug helper
function Console:Log(msg)
    print("[AntiCheatConsole] "..tostring(msg))
end

Console:Log("AntiCheatConsole loaded successfully.")
return Console
]])()
