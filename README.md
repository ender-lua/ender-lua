local pl=game.Players.LocalPlayer
local char=pl.Character or pl.CharacterAdded:Wait()
local hum=char:WaitForChild("HumanoidRootPart")
local screen=Instance.new("ScreenGui")
local cframe=Instance.new("Frame")
cframe.Parent=screen
local UserInputService = game:GetService("UserInputService")
screen.ResetOnSpawn=false
local gui = cframe

local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

gui.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = gui.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

gui.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
cframe.Position=UDim2.new(0.111,0,0.246,0)
cframe.Size=UDim2.new(0.2,0,0.5,0)
cframe.BackgroundColor3=Color3.new(0,0,0)
cframe.BorderColor3=Color3.new(1, 1, 1)
cframe.BorderSizePixel=5
screen.Parent=pl.PlayerGui
Instance.new("UIListLayout").Parent=cframe


local function add(text,buttonname,typ)
    local b=Instance.new(typ)
    b.Parent=cframe
    b.TextColor3=Color3.new(1,1,1)
    b.Text=text
    b.Name=buttonname
    b.TextSize=20
    b.BackgroundColor3=Color3.new(0, 0, 0)
    b.BorderColor3=Color3.new(1, 1, 1)
    b.BorderSizePixel=2
    b.Size=UDim2.new(1,0,0.2,0)
end    
add("作者:dotoyn4","a_0","TextLabel")
add("在脚下生成方块","a_1","TextButton")
local button=cframe:WaitForChild("a_1")
local turn=true
button.MouseButton1Click:Connect(function()
    if turn then turn=false button.Text="在脚下生成方块(开)" else turn=true button.Text="在脚下生成方块(关)" end
    while true do
        if turn then break end
        wait(0.1)
        local a= Instance.new("Part")
        a.Transparency=1
        a.Parent=workspace
        a.CFrame=char.HumanoidRootPart.CFrame * CFrame.new(0,-5,0)
        a.Size=Vector3.new(10,2,10)
        a.Anchored=true
        game.Debris:AddItem(a,1)
    end    
    
end)
add("输入速度","a_2","TextBox")
local button_2=cframe:WaitForChild("a_2")
button_2.FocusLost:Connect(function(p)
    if not p then return end
    if not tonumber(button_2.Text) then return end
    local num=tonumber(button_2.Text)
    char.Humanoid.WalkSpeed=num
    button_2.Text=""
end)
add("跳跃高度","a_3","TextBox")
local button_3=cframe:WaitForChild("a_3")
button_3.FocusLost:Connect(function(p)
    if not p then return end
    if not tonumber(button_3.Text) then return end
    char.Humanoid.JumpPower=tonumber(button_3.Text)
    button_3.Text=""
end)
add("穿墙","a_4","TextButton")
local button_4=cframe:WaitForChild("a_4")
local turn=true
button_4.MouseButton1Click:Connect(function()
    if turn then turn=false button_4.Text="穿墙(开)" else turn=true button_4.Text="穿墙(关)" end
    while true do
        task.wait(0.1)
        if turn then 
            for i,v in pairs(pl.Character:GetChildren()) do
                if v.Name == "UpperTorso" or v.Name == "Torso"  then
                    v.CanCollide=true
                end    
            end
            break
        end
        task.wait(0.1)
        for i,v in pairs(pl.Character:GetChildren()) do
            if v:IsA("BasePart") or v:IsA("MeshPart") or v.Name == "UpperTorso" or v.Name == "Torso"  then
                v.CanCollide=false
            end    
        end
    end    
end)
