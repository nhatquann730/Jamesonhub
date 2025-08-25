-- Tải UI chính từ GitHub (phải chắc rằng link này hoạt động)
local uiScript = game:HttpGet("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/main/UiREDzV2.lua")
loadstring(uiScript)()

-- Tải sẵn các script bên ngoài
local h4dHubScript = game:HttpGet("https://raw.githubusercontent.com/H4xScripts/Loader/refs/heads/main/loader.lua", true)
local flyGuiScript = game:HttpGet("https://pastebin.com/raw/5Q95EK1n", true)
local speedHubScript = game:HttpGet("https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua", true)

-- Tạo cửa sổ UI
local Window = MakeWindow({
    Hub = {
        Title = "jameson_VN Roblox",
        Animation = "roblox jameson_VN"
    },
    Key = {
        KeySystem = true,
        Title = "Key System",
        Description = "",
        KeyLink = "https://link-hub.net/1385861/IfC0WpSq5He4",
        Keys = {"keybass09875687106"},
        Notifi = {
            Notifications = true,
            CorrectKey = "Running the Script...",
            Incorrectkey = "The key is incorrect",
            CopyKeyLink = "Copied to Clipboard"
        }
    }
})

-- Nút thu gọn
MinimizeButton({
    Image = "rbxassetid://100356723879773", 
    Size = {50, 50},
    Color = Color3.fromRGB(10, 10, 10),
    Corner = true,
    Stroke = true,
    StrokeColor = Color3.fromRGB(255, 0, 0)
})

-- Tabs chính
local Tab1o = MakeTab({Name = "99 night in the forest"})
local Tab3o = MakeTab({Name = "blox fruits"})
local TabUpdate = MakeTab({Name = "Sẽ cập nhật thêm"})

-- Buttons Tab1o
AddButton(Tab1o, {
    Name = "H4d Hub",
    Callback = function()
        loadstring(h4dHubScript)()
    end
})

AddButton(Tab1o, {
    Name = "Fly GUI v1 VN",
    Callback = function()
        loadstring(flyGuiScript)()
    end
})

AddButton(Tab1o, {
    Name = "Speed Hub",
    Callback = function()
        loadstring(speedHubScript)()
    end
})
 
AddButton(Tab1o, {
    Name = "ringta hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/wefwef127382/99daysloader.github.io/refs/heads/main/ringta.lua"))()
    end
})

AddButton(Tab1o, {
    Name = "soluna hub",
    Callback = function()
        loadstring(game:HttpGet("https://soluna-script.vercel.app/99-Nights-in-the-Forest.lua",true))()
    end
})

AddButton(Tab1o, {
    Name = "kaitun kc",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/MQPS7/99-Night-in-the-Forset/refs/heads/main/Gfarm'))()
    end
})

-- Buttons Tab3o
AddButton(Tab3o, {
    Name = "quanxtum",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))()
    end
})

AddButton(Tab3o, {
    Name = "dat thg",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/DatThg/refs/heads/main/DatThgV1"))()
    end
})

AddButton(Tab3o, {
    Name = "zis hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/Zis/refs/heads/main/ZisRb7"))()
    end
})

AddButton(Tab3o, {
    Name = "min gaming",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/Min/refs/heads/main/MinXt2Eng"))()
    end
})

AddButton(Tab3o, {
    Name = "rubu hub",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/RubuRoblox/refs/heads/main/RuBuRzVn"))()
    end
})

AddButton(Tab3o, {
    Name = "redz (đang update)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Scripts/refs/heads/main/main.luau"))()
    end
})

-- Buttons TabUpdate (chứa các placeholder)
AddButton(TabUpdate, {
    Name = "(Sẽ thêm script sau)",
    Callback = function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Thông báo",
            Text = "Script này sẽ được cập nhật sau!",
            Duration = 5
        })
    end
})

AddButton(TabUpdate, {
    Name = "(Chưa có gì mới)",
    Callback = function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Thông báo",
            Text = "Đang chờ cập nhật script mới...",
            Duration = 5
        })
    end
})
