-- Kavo Blue UI (Full) | LocalScript ใน StarterPlayerScripts
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local PGui = game:GetService("Players").LocalPlayer.PlayerGui
local player = game:GetService("Players").LocalPlayer

local sg = Instance.new("ScreenGui", PGui)
sg.ResetOnSpawn = false

local function make(cls, props, parent)
    local o = Instance.new(cls)
    for k,v in pairs(props) do o[k] = v end
    o.Parent = parent
    return o
end

local function glow(parent, color)
    make("UIStroke", {Color=color, Thickness=2}, parent)
    local g = make("ImageLabel", {
        Size=UDim2.new(1,50,1,50), Position=UDim2.new(0,-25,0,-25),
        BackgroundTransparency=1, Image="rbxassetid://5028857084",
        ImageColor3=color, ImageTransparency=0.6, ZIndex=-1
    }, parent)
    TweenService:Create(g, TweenInfo.new(1.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1,true),
        {ImageTransparency=0.8}):Play()
end

local blue = Color3.fromRGB(0,170,255)
local VALID_KEY = "Hach_1140"

-- ══════════════════════════════
-- KEY UI
-- ══════════════════════════════
local keyFrame = make("Frame", {
    Size=UDim2.new(0,340,0,160),
    Position=UDim2.new(0.5,-170,0.5,-80),
    BackgroundColor3=Color3.fromRGB(10,12,22),
    BorderSizePixel=0, ZIndex=30
}, sg)
make("UICorner", {CornerRadius=UDim.new(0,14)}, keyFrame)
glow(keyFrame, blue)

local keyDrag, keyDs, keySp = false, nil, nil
local keyTitle = make("Frame", {
    Size=UDim2.new(1,0,0,38),
    BackgroundColor3=Color3.fromRGB(8,20,45),
    BorderSizePixel=0, ZIndex=31
}, keyFrame)
make("UICorner", {CornerRadius=UDim.new(0,14)}, keyTitle)
make("Frame", {
    Size=UDim2.new(1,0,0,2), Position=UDim2.new(0,0,1,-2),
    BackgroundColor3=blue, BorderSizePixel=0, ZIndex=32
}, keyTitle)
make("TextLabel", {
    Size=UDim2.new(1,0,1,0), BackgroundTransparency=1,
    Text="🔐  ใส่ Key เพื่อใช้งาน",
    TextColor3=Color3.fromRGB(255,255,255),
    TextSize=14, Font=Enum.Font.GothamBold, ZIndex=32
}, keyTitle)

keyTitle.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        keyDrag, keyDs, keySp = true, i.Position, keyFrame.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if keyDrag and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - keyDs
        keyFrame.Position = UDim2.new(keySp.X.Scale, keySp.X.Offset+d.X, keySp.Y.Scale, keySp.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then keyDrag = false end
end)

local keyBox = make("TextBox", {
    Size=UDim2.new(1,-24,0,36), Position=UDim2.new(0,12,0,48),
    BackgroundColor3=Color3.fromRGB(8,16,35),
    PlaceholderText="กรอก Key ที่นี่...",
    PlaceholderColor3=Color3.fromRGB(80,130,200),
    Text="", TextColor3=Color3.fromRGB(200,230,255),
    TextSize=13, Font=Enum.Font.Gotham,
    BorderSizePixel=0, ClearTextOnFocus=false, ZIndex=31
}, keyFrame)
make("UICorner", {CornerRadius=UDim.new(0,8)}, keyBox)
make("UIStroke", {Color=Color3.fromRGB(0,100,200), Thickness=1.5}, keyBox)
make("UIPadding", {PaddingLeft=UDim.new(0,10)}, keyBox)

local keyStatus = make("TextLabel", {
    Size=UDim2.new(1,-24,0,20), Position=UDim2.new(0,12,0,90),
    BackgroundTransparency=1, Text="",
    TextColor3=Color3.fromRGB(255,80,80),
    TextSize=12, Font=Enum.Font.Gotham, ZIndex=31
}, keyFrame)

local keyConfirm = make("TextButton", {
    Size=UDim2.new(1,-24,0,36), Position=UDim2.new(0,12,0,116),
    BackgroundColor3=Color3.fromRGB(0,80,200),
    Text="✅  Confirm Key",
    TextColor3=Color3.fromRGB(255,255,255),
    TextSize=13, Font=Enum.Font.GothamBold,
    BorderSizePixel=0, ZIndex=31
}, keyFrame)
make("UICorner", {CornerRadius=UDim.new(0,8)}, keyConfirm)
make("UIStroke", {Color=blue, Thickness=1.5}, keyConfirm)

-- Toggle Button (ซ่อนก่อน)
local tb = make("TextButton", {
    Size=UDim2.new(0,110,0,34), Position=UDim2.new(0,15,0,15),
    BackgroundColor3=Color3.fromRGB(10,10,20),
    Text="🔵 เปิด Menu",
    TextColor3=blue, TextSize=13, Font=Enum.Font.GothamBold,
    ZIndex=10, Visible=false
}, sg)
make("UICorner", {CornerRadius=UDim.new(0,8)}, tb)
glow(tb, blue)

-- Main Frame (ซ่อนก่อน)
local mf = make("Frame", {
    Size=UDim2.new(0,420,0,300),
    Position=UDim2.new(0.5,-210,0.5,-150),
    BackgroundColor3=Color3.fromRGB(10,12,22),
    BorderSizePixel=0, Visible=false
}, sg)
make("UICorner", {CornerRadius=UDim.new(0,12)}, mf)
glow(mf, blue)

-- Title Bar (draggable)
local title = make("Frame", {
    Size=UDim2.new(1,0,0,42),
    BackgroundColor3=Color3.fromRGB(8,20,45),
    BorderSizePixel=0
}, mf)
make("UICorner", {CornerRadius=UDim.new(0,12)}, title)
make("Frame", {
    Size=UDim2.new(1,0,0,2), Position=UDim2.new(0,0,1,-2),
    BackgroundColor3=blue, BorderSizePixel=0
}, title)
make("TextLabel", {
    Size=UDim2.new(1,-50,1,0), Position=UDim2.new(0,12,0,0),
    BackgroundTransparency=1,
    Text="⚡ Kavo Blue UI",
    TextColor3=Color3.fromRGB(255,255,255),
    TextSize=15, Font=Enum.Font.GothamBold,
    TextXAlignment=Enum.TextXAlignment.Left
}, title)

local closeBtn = make("TextButton", {
    Size=UDim2.new(0,28,0,28), Position=UDim2.new(1,-36,0,7),
    BackgroundColor3=Color3.fromRGB(180,30,30),
    Text="✕", TextColor3=Color3.fromRGB(255,255,255),
    TextSize=13, Font=Enum.Font.GothamBold
}, title)
make("UICorner", {CornerRadius=UDim.new(0,6)}, closeBtn)

-- Drag Main Frame
local mfDrag, mfDs, mfSp = false, nil, nil
title.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        mfDrag, mfDs, mfSp = true, i.Position, mf.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if mfDrag and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - mfDs
        mf.Position = UDim2.new(mfSp.X.Scale, mfSp.X.Offset+d.X, mfSp.Y.Scale, mfSp.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then mfDrag = false end
end)

-- ScrollingFrame
local scroll = make("ScrollingFrame", {
    Size=UDim2.new(1,-10,1,-50), Position=UDim2.new(0,5,0,47),
    BackgroundTransparency=1, BorderSizePixel=0,
    ScrollBarThickness=3, ScrollBarImageColor3=blue,
    AutomaticCanvasSize=Enum.AutomaticSize.Y,
    CanvasSize=UDim2.new(0,0,0,0)
}, mf)
make("UIListLayout", {Padding=UDim.new(0,7), SortOrder=Enum.SortOrder.LayoutOrder}, scroll)
make("UIPadding", {PaddingTop=UDim.new(0,8), PaddingLeft=UDim.new(0,8), PaddingRight=UDim.new(0,8)}, scroll)

-- ── Helpers ──
local function Button(text, cb)
    local b = make("TextButton", {
        Size=UDim2.new(1,0,0,36),
        BackgroundColor3=Color3.fromRGB(0,75,190),
        Text=text, TextColor3=Color3.fromRGB(255,255,255),
        TextSize=13, Font=Enum.Font.GothamSemibold,
        BorderSizePixel=0
    }, scroll)
    make("UICorner", {CornerRadius=UDim.new(0,8)}, b)
    make("UIStroke", {Color=blue, Thickness=1.5}, b)
    b.MouseButton1Click:Connect(function() if cb then cb() end end)
    return b
end

local function Toggle(label, default, cb)
    local btn = make("TextButton", {
        Size=UDim2.new(1,0,0,36),
        BackgroundColor3=Color3.fromRGB(12,20,42),
        BorderSizePixel=0, Text="", AutoButtonColor=false
    }, scroll)
    make("UICorner", {CornerRadius=UDim.new(0,8)}, btn)
    make("UIStroke", {Color=Color3.fromRGB(0,90,180), Thickness=1}, btn)
    make("TextLabel", {
        Size=UDim2.new(1,-58,1,0), Position=UDim2.new(0,10,0,0),
        BackgroundTransparency=1, Text=label,
        TextColor3=Color3.fromRGB(200,225,255),
        TextSize=13, Font=Enum.Font.Gotham,
        TextXAlignment=Enum.TextXAlignment.Left
    }, btn)
    local bg = make("Frame", {
        Size=UDim2.new(0,38,0,20), Position=UDim2.new(1,-48,0.5,-10),
        BackgroundColor3=default and blue or Color3.fromRGB(50,50,70),
        BorderSizePixel=0
    }, btn)
    make("UICorner", {CornerRadius=UDim.new(1,0)}, bg)
    local dot = make("Frame", {
        Size=UDim2.new(0,14,0,14),
        Position=default and UDim2.new(1,-17,0.5,-7) or UDim2.new(0,3,0.5,-7),
        BackgroundColor3=Color3.fromRGB(255,255,255),
        BorderSizePixel=0
    }, bg)
    make("UICorner", {CornerRadius=UDim.new(1,0)}, dot)
    local state = default or false
    btn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(bg, TweenInfo.new(0.2), {BackgroundColor3=state and blue or Color3.fromRGB(50,50,70)}):Play()
        TweenService:Create(dot, TweenInfo.new(0.2), {Position=state and UDim2.new(1,-17,0.5,-7) or UDim2.new(0,3,0.5,-7)}):Play()
        if cb then cb(state) end
    end)
end

local function InputBox(placeholder)
    local box = make("TextBox", {
        Size=UDim2.new(1,0,0,36),
        BackgroundColor3=Color3.fromRGB(8,16,35),
        PlaceholderText=placeholder,
        PlaceholderColor3=Color3.fromRGB(80,130,200),
        Text="", TextColor3=Color3.fromRGB(200,230,255),
        TextSize=13, Font=Enum.Font.Gotham,
        BorderSizePixel=0, ClearTextOnFocus=false
    }, scroll)
    make("UICorner", {CornerRadius=UDim.new(0,8)}, box)
    make("UIStroke", {Color=Color3.fromRGB(0,100,200), Thickness=1.5}, box)
    make("UIPadding", {PaddingLeft=UDim.new(0,10)}, box)
    return box
end

local function Slider(label, default, min, max, step, onChange)
    local val = default
    local h = make("Frame", {
        Size=UDim2.new(1,0,0,36),
        BackgroundColor3=Color3.fromRGB(12,20,42),
        BorderSizePixel=0
    }, scroll)
    make("UICorner", {CornerRadius=UDim.new(0,8)}, h)
    make("UIStroke", {Color=Color3.fromRGB(0,90,180), Thickness=1}, h)
    make("TextLabel", {
        Size=UDim2.new(0,100,1,0), Position=UDim2.new(0,10,0,0),
        BackgroundTransparency=1, Text=label,
        TextColor3=Color3.fromRGB(200,225,255),
        TextSize=12, Font=Enum.Font.Gotham,
        TextXAlignment=Enum.TextXAlignment.Left
    }, h)
    local valLbl = make("TextLabel", {
        Size=UDim2.new(0,36,1,0), Position=UDim2.new(0.5,-18,0,0),
        BackgroundTransparency=1, Text=tostring(val),
        TextColor3=Color3.fromRGB(0,200,255),
        TextSize=13, Font=Enum.Font.GothamBold
    }, h)
    local btnMinus = make("TextButton", {
        Size=UDim2.new(0,28,0,24), Position=UDim2.new(1,-64,0.5,-12),
        BackgroundColor3=Color3.fromRGB(0,60,160),
        Text="-", TextColor3=Color3.fromRGB(255,255,255),
        TextSize=16, Font=Enum.Font.GothamBold, BorderSizePixel=0
    }, h)
    make("UICorner", {CornerRadius=UDim.new(0,6)}, btnMinus)
    local btnPlus = make("TextButton", {
        Size=UDim2.new(0,28,0,24), Position=UDim2.new(1,-32,0.5,-12),
        BackgroundColor3=Color3.fromRGB(0,60,160),
        Text="+", TextColor3=Color3.fromRGB(255,255,255),
        TextSize=16, Font=Enum.Font.GothamBold, BorderSizePixel=0
    }, h)
    make("UICorner", {CornerRadius=UDim.new(0,6)}, btnPlus)
    local function update(delta)
        val = math.clamp(val+delta, min, max)
        valLbl.Text = tostring(val)
        if onChange then onChange(val) end
    end
    btnMinus.MouseButton1Click:Connect(function() update(-step) end)
    btnPlus.MouseButton1Click:Connect(function() update(step) end)
end

local function SectionDivider(label)
    make("Frame", {Size=UDim2.new(1,0,0,2), BackgroundColor3=blue, BorderSizePixel=0}, scroll)
    make("TextLabel", {
        Size=UDim2.new(1,0,0,24), BackgroundTransparency=1,
        Text="  ── "..label.." ──",
        TextColor3=Color3.fromRGB(0,200,255),
        TextSize=12, Font=Enum.Font.GothamBold,
        TextXAlignment=Enum.TextXAlignment.Left
    }, scroll)
end

-- ══════════════════════════════
-- KEY CONFIRM LOGIC
-- ══════════════════════════════
keyConfirm.MouseButton1Click:Connect(function()
    if keyBox.Text == VALID_KEY then
        keyFrame:Destroy()
        tb.Visible = true
        TweenService:Create(tb, TweenInfo.new(0.3), {BackgroundColor3=Color3.fromRGB(0,60,180)}):Play()
        task.wait(0.3)
        TweenService:Create(tb, TweenInfo.new(0.3), {BackgroundColor3=Color3.fromRGB(10,10,20)}):Play()
    else
        keyStatus.Text = "❌ Key ไม่ถูกต้อง"
        keyStatus.TextColor3 = Color3.fromRGB(255,60,60)
        TweenService:Create(keyFrame, TweenInfo.new(0.05,Enum.EasingStyle.Bounce,Enum.EasingDirection.Out,4,true),
            {Position=UDim2.new(0.5,-165,0.5,-80)}):Play()
        task.delay(2, function() keyStatus.Text = "" end)
    end
end)

tb.MouseButton1Click:Connect(function()
    mf.Visible = not mf.Visible
    tb.Text = mf.Visible and "🔵 ปิด Menu" or "🔵 เปิด Menu"
end)
closeBtn.MouseButton1Click:Connect(function()
    mf.Visible = false
    tb.Text = "🔵 เปิด Menu"
end)

-- ══════════════════════════════
-- PLAYER SECTION
-- ══════════════════════════════
SectionDivider("Player")

Slider("🏃 Speed", 16, 16, 200, 4, function(v)
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = v end
end)

Slider("🦘 Jump Power", 50, 50, 300, 10, function(v)
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = v end
end)

local noclipOn = false
local noclipConn
Toggle("👻 NoClip", false, function(v)
    noclipOn = v
    if v then
        noclipConn = RunService.Stepped:Connect(function()
            local char = player.Character
            if not char then return end
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end)
    else
        if noclipConn then noclipConn:Disconnect() noclipConn = nil end
        local char = player.Character
        if char then
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = true end
            end
        end
    end
end)

-- ══════════════════════════════
-- SPAWN PART SECTION
-- ══════════════════════════════
SectionDivider("Spawn Part")

local sizeBox = InputBox("ขนาด Part เช่น 2,2,2")
local nameBox = InputBox("ชื่อ Part เช่น บ้าน, จุดA")
local partAbove = false
Toggle("Part อยู่ข้างบนผู้เล่น", false, function(v) partAbove = v end)

local function spawnAuraPart(x, y, z, pos, partName)
    local part = Instance.new("Part")
    part.Size = Vector3.new(x,y,z)
    part.Position = pos
    part.Anchored = true
    part.BrickColor = BrickColor.new("Really black")
    part.Material = Enum.Material.SmoothPlastic
    part.CastShadow = false
    part.Name = (partName and partName ~= "") and partName or "AuraPart"
    part.Parent = workspace

    if partName and partName ~= "" then
        local bb = Instance.new("BillboardGui")
        bb.Size = UDim2.new(0,160,0,30)
        bb.StudsOffset = Vector3.new(0, y/2+1.5, 0)
        bb.AlwaysOnTop = true
        bb.Parent = part
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1,0,1,0)
        lbl.BackgroundTransparency = 1
        lbl.Text = "📍 "..partName
        lbl.TextColor3 = Color3.fromRGB(0,220,255)
        lbl.TextSize = 14
        lbl.Font = Enum.Font.GothamBold
        lbl.Parent = bb
    end

    local sel = Instance.new("SelectionBox")
    sel.Adornee = part
    sel.Color3 = Color3.fromRGB(0,180,255)
    sel.LineThickness = 0.06
    sel.SurfaceTransparency = 0.7
    sel.SurfaceColor3 = Color3.fromRGB(0,100,255)
    sel.Parent = workspace

    local light = Instance.new("PointLight")
    light.Color = Color3.fromRGB(0,180,255)
    light.Brightness = 5
    light.Range = math.max(x,y,z)*3
    light.Parent = part

    task.spawn(function()
        while part.Parent do
            TweenService:Create(light, TweenInfo.new(1,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut), {Brightness=1}):Play()
            task.wait(1)
            TweenService:Create(light, TweenInfo.new(1,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut), {Brightness=5}):Play()
            task.wait(1)
        end
    end)
    return part
end

Button("⬛ Spawn Part", function()
    local txt = sizeBox.Text
    local x,y,z = txt:match("([%d%.]+),([%d%.]+),([%d%.]+)")
    x,y,z = tonumber(x) or 4, tonumber(y) or 4, tonumber(z) or 4
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    local dir = partAbove and 1 or -1
    spawnAuraPart(x, y, z, root.Position + Vector3.new(0, dir*(y/2+3), 0), nameBox.Text)
end)

Button("✨ Spawn Aura Beam", function()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    local hum = char:FindFirstChildOfClass("Humanoid")
    local footY = root.Position.Y - 3
    local part = spawnAuraPart(5, 5, 5, Vector3.new(root.Position.X, footY+2.5, root.Position.Z))

    task.spawn(function()
        local steps, dt = 40, 0.4/40
        for i = 1, steps do
            if not part.Parent then return end
            local newY = 5 + (90-5)*(i/steps)
            part.Size = Vector3.new(5, newY, 5)
            part.Position = Vector3.new(root.Position.X, footY+newY/2, root.Position.Z)
            task.wait(dt)
        end
        if char and root and hum and hum.Health > 0 then
            local bp = Instance.new("BodyVelocity")
            bp.Velocity = Vector3.new(0,200,0)
            bp.MaxForce = Vector3.new(0,math.huge,0)
            bp.P = math.huge
            bp.Parent = root
            task.wait(0.15)
            bp:Destroy()
        end
        task.wait(5)
        for i = 1, steps do
            if not part.Parent then return end
            local newY = 90 - (90-5)*(i/steps)
            part.Size = Vector3.new(5, newY, 5)
            part.Position = Vector3.new(root.Position.X, footY+newY/2, root.Position.Z)
            task.wait(dt)
        end
        if part.Parent then part:Destroy() end
    end)
end)

Button("🗑️ Remove Last Part", function()
    for _,v in ipairs(workspace:GetChildren()) do
        if v:IsA("Part") and v.BrickColor == BrickColor.new("Really black") and v.Anchored then
            v:Destroy()
            break
        end
    end
end)

-- ══════════════════════════════
-- WARP SECTION
-- ══════════════════════════════
SectionDivider("Warp to Part")

local warpBox = InputBox("ชื่อ Part ที่จะวาร์ปไป")
local Camera = workspace.CurrentCamera

-- Animation วาร์ป
local WARP_ANIM_ID = "rbxassetid://98594861359881"

local function playWarpEffect(onDone)
    local char = player.Character
    local hum  = char and char:FindFirstChildOfClass("Humanoid")
    local animTrack

    -- โหลด + เล่น Animation
    if hum then
        local animator = hum:FindFirstChildOfClass("Animator")
        if animator then
            local anim = Instance.new("Animation")
            anim.AnimationId = WARP_ANIM_ID
            local ok, track = pcall(function()
                return animator:LoadAnimation(anim)
            end)
            if ok and track then
                animTrack = track
                animTrack.Priority = Enum.AnimationPriority.Action
                animTrack:Play(0.05)
            end
        end
    end

    -- Overlay สีฟ้า
    local overlay = make("Frame", {
        Size=UDim2.new(1,0,1,0),
        BackgroundColor3=Color3.fromRGB(0,140,255),
        BackgroundTransparency=1,
        BorderSizePixel=0, ZIndex=25
    }, sg)

    -- Zoom กล้อง
    local origFov = Camera.FieldOfView
    Camera.CameraType = Enum.CameraType.Scriptable
    local tiltCF = Camera.CFrame * CFrame.Angles(0,0,math.rad(8))
    TweenService:Create(Camera, TweenInfo.new(0.12,Enum.EasingStyle.Quad,Enum.EasingDirection.In), {
        FieldOfView=10, CFrame=tiltCF
    }):Play()
    TweenService:Create(overlay, TweenInfo.new(0.12,Enum.EasingStyle.Quad,Enum.EasingDirection.In), {
        BackgroundTransparency=0.1
    }):Play()

    task.wait(0.18)

    -- วาร์ปตัวละคร
    if onDone then onDone() end

    -- คืนกล้อง
    Camera.CameraType = Enum.CameraType.Custom
    TweenService:Create(overlay, TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {
        BackgroundTransparency=1
    }):Play()
    TweenService:Create(Camera, TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {
        FieldOfView=origFov
    }):Play()
    task.delay(0.6, function() overlay:Destroy() end)

    -- หยุด animation หลัง 1.5 วิ
    if animTrack then
        task.delay(1.5, function()
            if animTrack.IsPlaying then animTrack:Stop(0.2) end
        end)
    end
end

Button("🌀 Warp", function()
    local name = warpBox.Text
    if name == "" then return end
    local target = workspace:FindFirstChild(name, true)
    if not target or not target:IsA("BasePart") then
        local err = make("TextLabel", {
            Size=UDim2.new(1,0,0,24), BackgroundTransparency=1,
            Text="❌ ไม่พบ Part ชื่อ: "..name,
            TextColor3=Color3.fromRGB(255,80,80),
            TextSize=12, Font=Enum.Font.Gotham
        }, scroll)
        task.delay(2, function() err:Destroy() end)
        return
    end
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    playWarpEffect(function()
        root.CFrame = CFrame.new(target.Position + Vector3.new(0, target.Size.Y/2+3, 0))
    end)
end)

-- ══════════════════════════════
-- ESP SECTION
-- ══════════════════════════════
SectionDivider("ESP")

local espBoxes = {}

local function setESP(enabled)
    for _, v in pairs(espBoxes) do pcall(function() v:Destroy() end) end
    espBoxes = {}
    if not enabled then return end
    for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
        if p == player then continue end
        local char = p.Character
        if not char then continue end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then continue end
        local bb = Instance.new("BillboardGui")
        bb.Size = UDim2.new(0,100,0,40)
        bb.StudsOffset = Vector3.new(0,3,0)
        bb.AlwaysOnTop = true
        bb.Parent = root
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1,0,1,0)
        lbl.BackgroundTransparency = 1
        lbl.Text = "👁 "..p.Name
        lbl.TextColor3 = Color3.fromRGB(255,50,50)
        lbl.TextSize = 14
        lbl.Font = Enum.Font.GothamBold
        lbl.Parent = bb
        table.insert(espBoxes, bb)
    end
end

Toggle("👁️ Player ESP", false, function(v) setESP(v) end)

-- ══════════════════════════════
-- EMOTE SECTION
-- ══════════════════════════════
SectionDivider("Emote")

local EMOTES = {
    { label = "🕺 เต้น",  id = "rbxassetid://102383284459535", looped = true  },
    { label = "🧘 กลาง",  id = "rbxassetid://98180501003180",  looped = true  },
}

local currentEmoteTrack = nil

local function stopEmote()
    if currentEmoteTrack and currentEmoteTrack.IsPlaying then
        currentEmoteTrack:Stop(0.2)
        currentEmoteTrack = nil
    end
end

local function playEmote(animId, looped)
    local char = player.Character
    local hum  = char and char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then return end

    stopEmote()

    local anim = Instance.new("Animation")
    anim.AnimationId = animId
    local ok, track = pcall(function()
        return animator:LoadAnimation(anim)
    end)
    if ok and track then
        track.Priority = Enum.AnimationPriority.Action
        track.Looped   = looped or false
        track:Play(0.15)
        currentEmoteTrack = track
    end
end

-- ปุ่มแต่ละ Emote
for _, emote in ipairs(EMOTES) do
    local animId = emote.id
    local looped = emote.looped
    local label  = emote.label

    local row = make("Frame", {
        Size=UDim2.new(1,0,0,36),
        BackgroundColor3=Color3.fromRGB(12,20,42),
        BorderSizePixel=0
    }, scroll)
    make("UICorner", {CornerRadius=UDim.new(0,8)}, row)
    make("UIStroke", {Color=Color3.fromRGB(0,90,180), Thickness=1}, row)

    make("TextLabel", {
        Size=UDim2.new(0.55,0,1,0), Position=UDim2.new(0,10,0,0),
        BackgroundTransparency=1, Text=label,
        TextColor3=Color3.fromRGB(200,225,255),
        TextSize=13, Font=Enum.Font.GothamSemibold,
        TextXAlignment=Enum.TextXAlignment.Left
    }, row)

    -- ปุ่ม ▶ เล่น
    local playBtn = make("TextButton", {
        Size=UDim2.new(0,60,0,24), Position=UDim2.new(1,-130,0.5,-12),
        BackgroundColor3=Color3.fromRGB(0,130,60),
        Text="▶ เล่น", TextColor3=Color3.fromRGB(255,255,255),
        TextSize=11, Font=Enum.Font.GothamBold, BorderSizePixel=0
    }, row)
    make("UICorner", {CornerRadius=UDim.new(0,6)}, playBtn)

    -- ปุ่ม ■ หยุด
    local stopBtn = make("TextButton", {
        Size=UDim2.new(0,60,0,24), Position=UDim2.new(1,-65,0.5,-12),
        BackgroundColor3=Color3.fromRGB(160,30,30),
        Text="■ หยุด", TextColor3=Color3.fromRGB(255,255,255),
        TextSize=11, Font=Enum.Font.GothamBold, BorderSizePixel=0
    }, row)
    make("UICorner", {CornerRadius=UDim.new(0,6)}, stopBtn)

    playBtn.MouseButton1Click:Connect(function()
        playEmote(animId, looped)
        TweenService:Create(playBtn, TweenInfo.new(0.1), {BackgroundColor3=Color3.fromRGB(0,200,80)}):Play()
        task.delay(0.3, function()
            TweenService:Create(playBtn, TweenInfo.new(0.15), {BackgroundColor3=Color3.fromRGB(0,130,60)}):Play()
        end)
    end)

    stopBtn.MouseButton1Click:Connect(function()
        stopEmote()
        TweenService:Create(stopBtn, TweenInfo.new(0.1), {BackgroundColor3=Color3.fromRGB(220,60,60)}):Play()
        task.delay(0.3, function()
            TweenService:Create(stopBtn, TweenInfo.new(0.15), {BackgroundColor3=Color3.fromRGB(160,30,30)}):Play()
        end)
    end)
end

-- ปุ่มหยุด Emote ทั้งหมด
Button("⏹️ หยุด Emote ทั้งหมด", function()
    stopEmote()
end)

print("✅ Kavo Blue UI โหลดแล้ว | Key: " .. VALID_KEY)
