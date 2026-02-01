local pl=game.Players.LocalPlayer
local char=pl.Character or pl.CharacterAdded:Wait()
local hum=char:WaitForChild("HumanoidRootPart")
local screen=Instance.new("ScreenGui")
local cframe=Instance.new("ScrollingFrame")
cframe.Parent=screen
local UserInputService = game:GetService("UserInputService")
screen.ResetOnSpawn=false
local gui = cframe
local twwen=game:GetService("TweenService")
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
	b.Size=UDim2.new(1,0,0.055,0)
end	
add("作者:dotoyn4(白龙)","a_0","TextLabel")
add("QQ:3449813467","a_x","TextLabel")
local a_x=cframe:WaitForChild("a_x")
a_x.TextSize=15
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
	button_2.Text="done"
end)
add("跳跃高度","a_3","TextBox")
local button_3=cframe:WaitForChild("a_3")
button_3.FocusLost:Connect(function(p)
	if not p then return end
	if not tonumber(button_3.Text) then return end
	char.Humanoid.JumpPower=tonumber(button_3.Text)
	button_3.Text="done"
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

add("creazy math 脚本","a_5","TextButton")
local button_5=cframe:WaitForChild("a_5")
local b_n=true
local fram=Instance.new("ScrollingFrame") 
fram.Parent=screen
fram.ZIndex=0
fram.BackgroundColor3=Color3.new(0,0,0)
fram.BorderColor3=Color3.new(1, 1, 1)
fram.BorderSizePixel=5
fram.Position=UDim2.new(0.11,0,0.246,0)
fram.Size=UDim2.new(0.2,0,0.5,0)
Instance.new("UIListLayout").Parent=fram
add("ceazy math","d_0","TextLabel")
local a_2=cframe:WaitForChild("d_0")
a_2.Parent=fram
add("当前层级>","d","TextLabel")
local z=cframe:WaitForChild("d")
z.Parent=fram

add("开始破解","d_1","TextButton")
local z_1=cframe:WaitForChild("d_1")
z_1.Parent=fram


add("等待破解...","d_2","TextLabel")
local z_2=cframe:WaitForChild("d_2")
z_2.Parent=fram

add("停止","d_3","TextButton")
local z_3=cframe:WaitForChild("d_3")
z_3.Parent=fram

fram.Visible=false


local floor_num=-1





local b_z=true
local b_zz=true
local rep=-100
local b_zzz=true
local b_zzzz=0 --当前关卡(答对后显示层级)


local function creazy_math()
	game:GetService("ReplicatedStorage").ShowQuizUI.OnClientEvent:Connect(function(a,b)
		z.Text="当前层级:"..tostring(a)
		floor_num=a
	end)

	game:GetService("ReplicatedStorage").QuizResultEvent.OnClientEvent:Connect(function(a,b)
		if a then --a是否通关 --b当前关卡
			b_zzz=false
			b_zzzz=b
		end
	end)
end


z_1.MouseButton1Click:Connect(function()
	if b_z then
		b_z=false
		while task.wait() do
			game:GetService("ReplicatedStorage").QuizClearEvent:FireServer(floor_num,rep)
			rep+=1
			z_2.Text="尝试数字>"..rep
			creazy_math()
			if b_zz == false then
				z_2.Text="等待破解..."
				b_z=true
				b_zz=true
				rep=-100
				break
			elseif b_zzz == false and b_zzzz == floor_num then	
				z_2.Text="成功"
				b_z=true
				b_zz=true
				rep=-100
				task.wait(1)
				z_2.Text="等待破解..."
				
				break
			end
		end
		
			
		
	end	
end)





z_3.MouseButton1Click:Connect(function()
	b_zz=false
end)
for i,v in pairs(fram:GetChildren()) do
	if v:IsA("TextButton") or v:IsA("TextLabel") or v:IsA("TextBox") then
		v.ZIndex=0
	end	
end
button_5.MouseButton1Click:Connect(function()
	creazy_math()
	if b_n then
		button_5.Interactable=false
		fram.Visible=true
		
		twwen:Create(fram,TweenInfo.new(1),{Position=UDim2.new(0.32,0,0.246,0)}):Play()
		task.wait(1)
		b_n=false
		button_5.Interactable=true
	else
		b_n=true
		button_5.Interactable=false
		twwen:Create(fram,TweenInfo.new(1),{Position=UDim2.new(0.11,0,0.246,0)}):Play()
		task.wait(1)
		fram.Visible=false
		button_5.Interactable=true
	end

	
end)


add("IQ test(一键满级)200层密码-7895","a_6","TextButton")

local a_6=cframe:WaitForChild("a_6")
a_6.TextScaled=true
a_6.MouseButton1Click:Connect(function()
	for i=1,200 do
		game:GetService("ReplicatedStorage").RemoteEvents.ChangeIQ:FireServer(i)
	end		
end)

add("透视","a_7","TextButton")
local a_7=cframe:WaitForChild("a_7")
local a_7_0=true
a_7.MouseButton1Click:Connect(function()
	if a_7_0 then
		a_7.Text="透视(开)"
		a_7_0=false
		for i,name in pairs(game.Players:GetPlayers()) do
			for j,part in pairs(name.Character:GetChildren()) do
				if true then
			
					local highlight = Instance.new("Highlight")
					highlight.Adornee = part
					highlight.FillColor = Color3.new(1, 1, 1) 
					highlight.OutlineColor = Color3.new(1, 1, 1)   
					highlight.FillTransparency = 1                 
					highlight.OutlineTransparency = 0              

					highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

					highlight.Parent = part
					
				end
			end		
		end	
		
	else
		a_7_0=true
		a_7.Text="透视(关)"
		for i,name in pairs(game.Players:GetPlayers()) do
			for i,part in pairs(name.Character:GetChildren()) do
				if part:FindFirstChildOfClass("Highlight") then
					part:FindFirstChildOfClass("Highlight"):Destroy()
					

				end
			end		
		end	
	end	
end)


add("Dex","a_8","TextButton")
local a_8=cframe:WaitForChild("a_8")
a_8.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://gitee.com/cmbhbh/cmbh/raw/master/Bex.lua"))()
end)

add("spy","a_9","TextButton")
local a_9=cframe:WaitForChild("a_9")
a_9.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Ketamine-46055"))()
end)



local a_10_1=Instance.new("ScrollingFrame") 
a_10_1.Parent=screen
a_10_1.ZIndex=0
a_10_1.BackgroundColor3=Color3.new(0,0,0)
a_10_1.BorderColor3=Color3.new(1, 1, 1)
a_10_1.BorderSizePixel=5
a_10_1.Position=UDim2.new(0.11,0,0.246,0)
a_10_1.Size=UDim2.new(0.2,0,0.5,0)
a_10_1.CanvasSize=UDim2.new(0,0,10000,0)
Instance.new("UIGridLayout").Parent=a_10_1

a_10_1.Visible=false

for i,v in pairs(a_10_1:GetChildren()) do
	if v:IsA("TextButton") or v:IsA("TextLabel") or v:IsA("TextBox") then
		v.ZIndex=0
	end	
end


add("监视","a_10","TextButton")
local a_10=cframe:WaitForChild("a_10")
local a_10_0=true
a_10.MouseButton1Click:Connect(function()
	
	for i,pl in ipairs(game:GetService("Players"):GetPlayers()) do
		add(pl.Name,pl.Name,"TextButton")
		local a=cframe:WaitForChild(pl.Name)
		a.TextScaled=true
		a.Parent=a_10_1
		a.ZIndex=0
	end
	
	for i,v in pairs(a_10_1:GetChildren()) do
	
		if v:IsA("TextButton") then
			v.MouseButton1Click:Connect(function()
				game:GetService("Workspace").CurrentCamera.CameraSubject=game:GetService("Players"):FindFirstChild(v.Name).Character.HumanoidRootPart
					
			end)

		end
	end

	if a_10_0 then
		a_10.Interactable=false
		a_10_1.Visible=true

		twwen:Create(a_10_1,TweenInfo.new(1),{Position=UDim2.new(0.32,0,0.246,0)}):Play()
		task.wait(1)
		a_10_0=false
		a_10.Interactable=true
	else
		for i,v in ipairs(a_10_1:GetChildren()) do
			if v:IsA("TextButton") then
				v:Destroy()
			end
		end
		a_10_0=true
		a_10.Interactable=false
		twwen:Create(a_10_1,TweenInfo.new(1),{Position=UDim2.new(0.11,0,0.246,0)}):Play()
		task.wait(1)
		a_10_1.Visible=false
		a_10.Interactable=true
	end
end)

add("Tool复制","a_11","TextButton")
local a_11=cframe:WaitForChild("a_11")
a_11.MouseButton1Click:Connect(function()
    local tool=game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if tool then
        tool:Clone().Parent=pl.Backpack
    end
end)

