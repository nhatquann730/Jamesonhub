--------------------------------------------------------------------------------
-- GUI SETUP
--------------------------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Button = Instance.new("TextButton")
local BrightButton = Instance.new("TextButton") -- Nút Full Bright
local ProgressBarBG = Instance.new("Frame")
local ProgressBarFill = Instance.new("Frame")
local ProgressText = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local OpenButton = Instance.new("TextButton")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "FoodGui"

-- Frame chính
MainFrame.Size = UDim2.new(0, 220, 0, 180)
MainFrame.Position = UDim2.new(0.4, 0, 0.6, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Nút Get Food
Button.Size = UDim2.new(0, 200, 0, 40)
Button.Position = UDim2.new(0, 10, 0, 30)
Button.Text = "Get Food"
Button.BackgroundColor3 = Color3.fromRGB(0, 200, 0) -- xanh
Button.TextColor3 = Color3.new(1,1,1)
Button.Parent = MainFrame

-- Nút Full Bright
BrightButton.Size = UDim2.new(0, 200, 0, 30)
BrightButton.Position = UDim2.new(0, 10, 0, 75)
BrightButton.Text = "Full Bright: OFF"
BrightButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200) -- xanh dương
BrightButton.TextColor3 = Color3.new(1,1,1)
BrightButton.Parent = MainFrame

-- Khung progress
ProgressBarBG.Size = UDim2.new(0, 200, 0, 20)
ProgressBarBG.Position = UDim2.new(0, 10, 0, 115)
ProgressBarBG.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ProgressBarBG.BorderSizePixel = 0
ProgressBarBG.Parent = MainFrame

-- Thanh chạy
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
ProgressBarFill.Position = UDim2.new(0, 0, 0, 0)
ProgressBarFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
ProgressBarFill.BorderSizePixel = 0
ProgressBarFill.Parent = ProgressBarBG

-- Text %
ProgressText.Size = UDim2.new(0, 200, 0, 20)
ProgressText.Position = UDim2.new(0, 10, 0, 145)
ProgressText.Text = "Progress: 0%"
ProgressText.TextColor3 = Color3.new(1,1,1)
ProgressText.BackgroundTransparency = 1
ProgressText.Parent = MainFrame

-- Nút X (ẩn GUI)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.Parent = MainFrame

-- Nút O (hiện GUI lại) - mặc định ẩn
OpenButton.Size = UDim2.new(0, 25, 0, 25)
OpenButton.Position = UDim2.new(0, 10, 0.9, 0)
OpenButton.Text = "O"
OpenButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
OpenButton.TextColor3 = Color3.new(1,1,1)
OpenButton.Visible = false
OpenButton.Parent = ScreenGui

-- Logic ẩn/hiện
CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenButton.Visible = true
end)
OpenButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenButton.Visible = false
end)

--------------------------------------------------------------------------------
-- FULL BRIGHT SCRIPT
--------------------------------------------------------------------------------
local Lighting = game:GetService("Lighting")
local BrightEnabled = false

local function FullBright()
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.FogEnd = 1000000
    Lighting.GlobalShadows = false
    Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
end

local function ResetBright()
    Lighting.Brightness = 1
    Lighting.ClockTime = 0
    Lighting.FogEnd = 1000
    Lighting.GlobalShadows = true
    Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
end

BrightButton.MouseButton1Click:Connect(function()
    BrightEnabled = not BrightEnabled
    if BrightEnabled then
        BrightButton.Text = "Full Bright: ON"
        FullBright()
        Lighting.Changed:Connect(function()
            if BrightEnabled then
                FullBright()
            end
        end)
    else
        BrightButton.Text = "Full Bright: OFF"
        ResetBright()
    end
end)

--------------------------------------------------------------------------------
-- SCRIPT LẤY FOOD
--------------------------------------------------------------------------------
-- Settings
local TimesToTeleport = 50
local Radius = 100

-- Variables
local PS = game:GetService("Players")
local WS = game:GetService("Workspace")
local Player = PS.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Character = PS.LocalPlayer.Character or PS.LocalPlayer.CharacterAdded:Wait()
local Backpack = Player:WaitForChild("Backpack")
local HumanoidRoot = Character:WaitForChild("HumanoidRootPart")
local Storage = PlayerGui:WaitForChild("MainGui").Menus.Inventory

-- Remotes
local Pickup  = Character.System.Action

local OldCFrame = HumanoidRoot.CFrame 
local OldPosition = HumanoidRoot.Position 

function Check(Object)
    if Object.Name == "Crowbar" then
        return false
    end
    if Object:FindFirstChildOfClass("Part") or Object:FindFirstChildOfClass("MeshPart") then
        local Part = Object:FindFirstChildOfClass("Part") or Object:FindFirstChildOfClass("MeshPart")
        local Distance = (OldPosition - Part.Position).magnitude
        if Distance < Radius then
            return false
        end
        return true, Part
    end
    return false
end

function InvetoryCheck()
    local StorageAmount = Storage.UpperLine.Storage
    if StorageAmount.Text == "16/16 items" or StorageAmount.Text == "17/16 items" then
        HumanoidRoot.CFrame = OldCFrame
        wait()
        for i,v in pairs(Backpack:GetChildren()) do
            local A_1 = "Inventory_DropAll"
            local A_2 = {["Tool"] = v.Name}
            Pickup:InvokeServer(A_1, A_2)
        end
        repeat task.wait() until StorageAmount.Text == "0/16 items"
    end
    return "Done"
end

-- Function chạy script khi bấm nút
local Running = false

local function StartScript()
    if Running then return end
    Running = true
    Button.Text = "Running..."
    Button.BackgroundColor3 = Color3.fromRGB(150,150,150)

    local Amount = 0
    for i,v in pairs(WS:GetDescendants()) do
        if v.Name == "Apple" or v.Name == "Banana" or v.Name == "Bloxy Soda" or v.Name == "Burger" 
        or v.Name == "Cookie" or v.Name == "Dr. Bob Soda" or v.Name == "Hotdog" 
        or v.Name == "Ice Cream" or v.Name == "Lemon" or v.Name == "Lemon Slice" 
        or v.Name == "Medkit" or v.Name == "Pizza" or v.Name == "Water" or v.Name == "2 Litre Dr. Bob" then
            if v:FindFirstChild(v.Name) or v:FindFirstChild("Root") then
                local Bool, Part = Check(v)
                if Bool then
                    Amount = Amount + 1
                    
                    -- Cập nhật progress
                    local progress = math.min(Amount / TimesToTeleport, 1)
                    ProgressBarFill.Size = UDim2.new(progress, 0, 1, 0)
                    ProgressText.Text = "Progress: " .. math.floor(progress*100) .. "%"

                    if Amount >= TimesToTeleport then
                        HumanoidRoot.CFrame = OldCFrame
                        break
                    else
                        repeat task.wait()
                            repeat task.wait() until InvetoryCheck() == "Done"
                            Bool, Part = Check(v)
                            if Part ~= nil then
                                HumanoidRoot.CFrame = Part.CFrame 
                                local A_1 = "Store"
                                local A_2 = {["Model"] = v}
                                Pickup:InvokeServer(A_1, A_2)
                            end
                        until Part == nil
                    end
                end
            end
        end
    end

    -- Reset nút khi xong
    Button.Text = "Get Food"
    Button.BackgroundColor3 = Color3.fromRGB(0,200,0)
    Running = false
end

-- Gán function cho nút
Button.MouseButton1Click:Connect(StartScript)
