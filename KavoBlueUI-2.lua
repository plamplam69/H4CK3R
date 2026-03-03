-- Kavo Blue UI (Mini) | LocalScript ใน StarterPlayerScripts
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local PGui = game:GetService("Players").LocalPlayer.PlayerGui

-- ScreenGui
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
    local g = make("ImageLabel", {Size=UDim2.new(1,50,1,50), Position=UDim2.new(0,-25,0,-25),
        BackgroundTransparency=1, Image="rbxassetid://5028857084",
        ImageColor3=color, ImageTransparency=0.6, ZIndex=-1}, parent)
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
    BorderSizePixel=0, ZIndex=30}, sg)
make("UICorner", {CornerRadius=UDim.new(0,14)}, keyFrame)
glow(keyFrame, blue)

-- Draggable key frame
local keyDrag, keyDs, keySp = false, nil, nil
local keyTitle = make("Frame", {Size=UDim2.new(1,0,0,38),
    BackgroundColor3=Color3.fromRGB(8,20,45), BorderSizePixel=0, ZIndex=31}, keyFrame)
make("UICorner", {CornerRadius=UDim.new(0,14)}, keyTitle)
make("Frame", {Size=UDim2.new(1,0,0,2), Position=UDim2.new(0,0,1,-2),
    BackgroundColor3=blue, BorderSizePixel=0, ZIndex=32}, keyTitle)
make("TextLabel", {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1,
    Text="🔐  ใส่ Key เพื่อใช้งาน", TextColor3=Color3.fromRGB(255,255,255),
    TextSize=14, Font=Enum.Font.GothamBold, ZIndex=32}, keyTitle)

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
    BorderSizePixel=0, ClearTextOnFocus=false, ZIndex=31}, keyFrame)
make("UICorner", {CornerRadius=UDim.new(0,8)}, keyBox)
make("UIStroke", {Color=Color3.fromRGB(0,100,200), Thickness=1.5}, keyBox)
make("UIPadding", {PaddingLeft=UDim.new(0,10)}, keyBox)

local keyStatus = make("TextLabel", {
    Size=UDim2.new(1,-24,0,20), Position=UDim2.new(0,12,0,90),
    BackgroundTransparency=1, Text="",
    TextColor3=Color3.fromRGB(255,80,80),
    TextSize=12, Font=Enum.Font.Gotham, ZIndex=31}, keyFrame)

local keyConfirm = make("TextButton", {
    Size=UDim2.new(1,-24,0,36), Position=UDim2.new(0,12,0,116),
    BackgroundColor3=Color3.fromRGB(0,80,200),
    Text="✅  Confirm Key", TextColor3=Color3.fromRGB(255,255,255),
    TextSize=13, Font=Enum.Font.GothamBold,
    BorderSizePixel=0, ZIndex=31}, keyFrame)
make("UICorner", {CornerRadius=UDim.new(0,8)}, keyConfirm)
make("UIStroke", {Color=blue, Thickness=1.5}, keyConfirm)

-- Toggle Button (ซ่อนก่อน)
local tb = make("TextButton", {Size=UDim2.new(0,110,0,34), Position=UDim2.new(0,15,0,15),
    BackgroundColor3=Color3.fromRGB(10,10,20), Text="🔵 เปิด Menu",
    TextColor3=blue, TextSize=13, Font=Enum.Font.GothamBold, ZIndex=10,
    Visible=false}, sg)
make("UICorner", {CornerRadius=UDim.new(0,8)}, tb)
glow(tb, blue)

-- Main Frame (ซ่อนก่อน)
local mf = make("Frame", {Size=UDim2.new(0,420,0,300), Position=UDim2.new(0.5,-210,0.5,-150),
    BackgroundColor3=Color3.fromRGB(10,12,22), BorderSizePixel=0,
    Visible=false}, sg)
make("UICorner", {CornerRadius=UDim.new(0,12)}, mf)
glow(mf, blue)

-- Title Bar (draggable)
local title = make("Frame", {Size=UDim2.new(1,0,0,42), BackgroundColor3=Color3.fromRGB(8,20,45), BorderSizePixel=0}, mf)
make("UICorner", {CornerRadius=UDim.new(0,12)}, title)
make("Frame", {Size=UDim2.new(1,0,0,2), Position=UDim2.new(0,0,1,-2), BackgroundColor3=blue, BorderSizePixel=0}, title)
make("TextLabel", {Size=UDim2.new(1,-50,1,0), Position=UDim2.new(0,12,0,0), BackgroundTransparency=1,
    Text="⚡ Kavo Blue UI", TextColor3=Color3.fromRGB(255,255,255), TextSize=15,
    Font=Enum.Font.GothamBold, TextXAlignment=Enum.TextXAlignment.Left}, title)

local closeBtn = make("TextButton", {Size=UDim2.new(0,28,0,28), Position=UDim2.new(1,-36,0,7),
    BackgroundColor3=Color3.fromRGB(180,30,30), Text="✕", TextColor3=Color3.fromRGB(255,255,255),
    TextSize=13, Font=Enum.Font.GothamBold}, title)
make("UICorner", {CornerRadius=UDim.new(0,6)}, closeBtn)

-- Content (ScrollingFrame)
local scroll = make("ScrollingFrame", {Size=UDim2.new(1,-10,1,-50), Position=UDim2.new(0,5,0,47),
    BackgroundTransparency=1, BorderSizePixel=0, ScrollBarThickness=3,
    ScrollBarImageColor3=blue, AutomaticCanvasSize=Enum.AutomaticSize.Y,
    CanvasSize=UDim2.new(0,0,0,0)}, mf)
local list = make("UIListLayout", {Padding=UDim.new(0,7), SortOrder=Enum.SortOrder.LayoutOrder}, scroll)
make("UIPadding", {PaddingTop=UDim.new(0,8), PaddingLeft=UDim.new(0,8), PaddingRight=UDim.new(0,8)}, scroll)

-- Helper: สร้างปุ่ม
local function Button(text, cb)
    local b = make("TextButton", {Size=UDim2.new(1,0,0,36), BackgroundColor3=Color3.fromRGB(0,75,190),
        Text=text, TextColor3=Color3.fromRGB(255,255,255), TextSize=13, Font=Enum.Font.GothamSemibold,
        BorderSizePixel=0}, scroll)
    make("UICorner", {CornerRadius=UDim.new(0,8)}, b)
    make("UIStroke", {Color=blue, Thickness=1.5}, b)
    b.MouseButton1Click:Connect(function() if cb then cb() end end)
end

-- Helper: Toggle Switch (TextButton แทน Frame เพื่อให้รับ click ใน ScrollingFrame ได้)
local function Toggle(label, default, cb)
    local btn = make("TextButton", {Size=UDim2.new(1,0,0,36), BackgroundColor3=Color3.fromRGB(12,20,42),
        BorderSizePixel=0, Text="", AutoButtonColor=false}, scroll)
    make("UICorner", {CornerRadius=UDim.new(0,8)}, btn)
    make("UIStroke", {Color=Color3.fromRGB(0,90,180), Thickness=1}, btn)
    make("TextLabel", {Size=UDim2.new(1,-58,1,0), Position=UDim2.new(0,10,0,0), BackgroundTransparency=1,
        Text=label, TextColor3=Color3.fromRGB(200,225,255), TextSize=13,
        Font=Enum.Font.Gotham, TextXAlignment=Enum.TextXAlignment.Left}, btn)
    local bg = make("Frame", {Size=UDim2.new(0,38,0,20), Position=UDim2.new(1,-48,0.5,-10),
        BackgroundColor3=default and blue or Color3.fromRGB(50,50,70), BorderSizePixel=0}, btn)
    make("UICorner", {CornerRadius=UDim.new(1,0)}, bg)
    local dot = make("Frame", {Size=UDim2.new(0,14,0,14),
        Position=default and UDim2.new(1,-17,0.5,-7) or UDim2.new(0,3,0.5,-7),
        BackgroundColor3=Color3.fromRGB(255,255,255), BorderSizePixel=0}, bg)
    make("UICorner", {CornerRadius=UDim.new(1,0)}, dot)
    local state = default or false
    btn.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(bg, TweenInfo.new(0.2), {BackgroundColor3=state and blue or Color3.fromRGB(50,50,70)}):Play()
        TweenService:Create(dot, TweenInfo.new(0.2), {Position=state and UDim2.new(1,-17,0.5,-7) or UDim2.new(0,3,0.5,-7)}):Play()
        if cb then cb(state) end
    end)
end

-- Helper: TextBox Input
local function InputBox(placeholder)
    local box = make("TextBox", {Size=UDim2.new(1,0,0,36), BackgroundColor3=Color3.fromRGB(8,16,35),
        PlaceholderText=placeholder, PlaceholderColor3=Color3.fromRGB(80,130,200),
        Text="", TextColor3=Color3.fromRGB(200,230,255), TextSize=13,
        Font=Enum.Font.Gotham, BorderSizePixel=0, ClearTextOnFocus=false}, scroll)
    make("UICorner", {CornerRadius=UDim.new(0,8)}, box)
    make("UIStroke", {Color=Color3.fromRGB(0,100,200), Thickness=1.5}, box)
    make("UIPadding", {PaddingLeft=UDim.new(0,10)}, box)
    return box
end


-- Helper: Slider row (label + - value +)
local function Slider(label, default, min, max, step, onChange)
    local val = default
    local h = make("Frame", {Size=UDim2.new(1,0,0,36), BackgroundColor3=Color3.fromRGB(12,20,42), BorderSizePixel=0}, scroll)
    make("UICorner", {CornerRadius=UDim.new(0,8)}, h)
    make("UIStroke", {Color=Color3.fromRGB(0,90,180), Thickness=1}, h)
    make("TextLabel", {Size=UDim2.new(0,100,1,0), Position=UDim2.new(0,10,0,0), BackgroundTransparency=1,
        Text=label, TextColor3=Color3.fromRGB(200,225,255), TextSize=12,
        Font=Enum.Font.Gotham, TextXAlignment=Enum.TextXAlignment.Left}, h)
    local valLbl = make("TextLabel", {Size=UDim2.new(0,36,1,0), Position=UDim2.new(0.5,-18,0,0),
        BackgroundTransparency=1, Text=tostring(val), TextColor3=Color3.fromRGB(0,200,255),
        TextSize=13, Font=Enum.Font.GothamBold}, h)
    local btnMinus = make("TextButton", {Size=UDim2.new(0,28,0,24), Position=UDim2.new(1,-64,0.5,-12),
        BackgroundColor3=Color3.fromRGB(0,60,160), Text="-", TextColor3=Color3.fromRGB(255,255,255),
        TextSize=16, Font=Enum.Font.GothamBold, BorderSizePixel=0}, h)
    make("UICorner", {CornerRadius=UDim.new(0,6)}, btnMinus)
    local btnPlus = make("TextButton", {Size=UDim2.new(0,28,0,24), Position=UDim2.new(1,-32,0.5,-12),
        BackgroundColor3=Color3.fromRGB(0,60,160), Text="+", TextColor3=Color3.fromRGB(255,255,255),
        TextSize=16, Font=Enum.Font.GothamBold, BorderSizePixel=0}, h)
    make("UICorner", {CornerRadius=UDim.new(0,6)}, btnPlus)
    local function update(delta)
        val = math.clamp(val + delta, min, max)
        valLbl.Text = tostring(val)
        if onChange then onChange(val) end
    end
    btnMinus.MouseButton1Click:Connect(function() update(-step) end)
    btnPlus.MouseButton1Click:Connect(function() update(step) end)
end

local player = game.Players.LocalPlayer

-- ── Player Section ──
make("TextLabel", {Size=UDim2.new(1,0,0,24), BackgroundTransparency=1,
    Text="  ── Player ──", TextColor3=Color3.fromRGB(0,200,255),
    TextSize=12, Font=Enum.Font.GothamBold, TextXAlignment=Enum.TextXAlignment.Left}, scroll)

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

-- NoClip สวิตช์จริง
local noclipOn = false
local noclipConn
Toggle("👻 NoClip", false, function(v)
    noclipOn = v
    if v then
        noclipConn = game:GetService("RunService").Stepped:Connect(function()
            local char = player.Character
            if not char then return end
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.CanCollide = false
                end
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

-- ── Spawn Part Section ──
make("Frame", {Size=UDim2.new(1,0,0,2), BackgroundColor3=blue, BorderSizePixel=0}, scroll)
make("TextLabel", {Size=UDim2.new(1,0,0,24), BackgroundTransparency=1,
    Text="  ── Spawn Part ──", TextColor3=Color3.fromRGB(0,200,255),
    TextSize=12, Font=Enum.Font.GothamBold, TextXAlignment=Enum.TextXAlignment.Left}, scroll)

local sizeBox = InputBox("ขนาด Part เช่น 2,2,2")
local nameBox = InputBox("ชื่อ Part เช่น บ้าน, จุดA")

-- Toggle ตำแหน่ง บน/ล่าง
local partAbove = false
Toggle("Part อยู่ข้างบนผู้เล่น", false, function(v) partAbove = v end)

-- Helper สร้าง Part ออร่าสีฟ้า/ดำ
local function spawnAuraPart(x, y, z, pos, partName)
    local part = Instance.new("Part")
    part.Size = Vector3.new(x, y, z)
    part.Position = pos
    part.Anchored = true
    part.BrickColor = BrickColor.new("Really black")
    part.Material = Enum.Material.SmoothPlastic
    part.CastShadow = false
    part.Name = (partName and partName ~= "") and partName or "AuraPart"
    part.Parent = workspace

    -- BillboardGui แสดงชื่อถ้ามีชื่อ
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
    light.Range = math.max(x,y,z) * 3
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

    local char = game.Players.LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    local dir = partAbove and 1 or -1
    spawnAuraPart(x, y, z, root.Position + Vector3.new(0, dir*(y/2 + 3), 0), nameBox.Text)
end)


-- ปุ่ม Aura Beam: ยืดขึ้นเร็วมาก เด้งผู้เล่นขึ้นฟ้า รอ 5 วิ แล้วหดกลับและลบ
Button("✨ Spawn Aura Beam", function()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    local hum = char:FindFirstChildOfClass("Humanoid")

    local footY = root.Position.Y - 3
    local part = spawnAuraPart(5, 5, 5, Vector3.new(root.Position.X, footY + 2.5, root.Position.Z))

    task.spawn(function()
        -- Phase 1: ยืดขึ้นเร็วมาก (0.4 วิ)
        local steps, dt = 40, 0.4/40
        for i = 1, steps do
            if not part.Parent then return end
            local newY = 5 + (90-5) * (i/steps)
            part.Size = Vector3.new(5, newY, 5)
            part.Position = Vector3.new(root.Position.X, footY + newY/2, root.Position.Z)
            task.wait(dt)
        end

        -- Phase 2: เด้งผู้เล่นขึ้นฟ้า
        if char and root and hum and hum.Health > 0 then
            local bp = Instance.new("BodyVelocity")
            bp.Velocity = Vector3.new(0, 200, 0)
            bp.MaxForce = Vector3.new(0, math.huge, 0)
            bp.P = math.huge
            bp.Parent = root
            task.wait(0.15)
            bp:Destroy()
        end

        -- Phase 3: รอ 5 วิ
        task.wait(5)

        -- Phase 4: หดกลับลงเร็วๆ (0.4 วิ)
        for i = 1, steps do
            if not part.Parent then return end
            local newY = 90 - (90-5) * (i/steps)
            part.Size = Vector3.new(5, newY, 5)
            part.Position = Vector3.new(root.Position.X, footY + newY/2, root.Position.Z)
            task.wait(dt)
        end

        -- Phase 5: ลบออก
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

-- ── Warp Section ──
make("Frame", {Size=UDim2.new(1,0,0,2), BackgroundColor3=blue, BorderSizePixel=0}, scroll)
make("TextLabel", {Size=UDim2.new(1,0,0,24), BackgroundTransparency=1,
    Text="  ── Warp to Part ──", TextColor3=Color3.fromRGB(0,200,255),
    TextSize=12, Font=Enum.Font.GothamBold, TextXAlignment=Enum.TextXAlignment.Left}, scroll)

local warpBox = InputBox("ชื่อ Part ที่จะวาร์ปไป")

-- เอฟเฟค Warp แบบ Cinematic
local Camera = workspace.CurrentCamera
local function playWarpEffect(root, onDone)
    -- Layer สีฟ้าเรืองแสง
    local overlay = make("Frame", {Size=UDim2.new(1,0,1,0), BackgroundColor3=Color3.fromRGB(0,140,255),
        BackgroundTransparency=1, BorderSizePixel=0, ZIndex=25}, sg)

    -- เอียงกล้องนิดนึง + zoom เข้าเร็วมาก
    local origFov = Camera.FieldOfView
    local origCFrame = Camera.CFrame
    Camera.CameraType = Enum.CameraType.Scriptable

    -- Phase 1: เอียง + zoom ฉับ (0.12 วิ)
    local tiltCF = origCFrame * CFrame.Angles(0, 0, math.rad(8))
    TweenService:Create(Camera, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        FieldOfView = 10,
        CFrame = tiltCF
    }):Play()

    -- Phase 2: แสงสีฟ้าค่อยๆ ขึ้น
    TweenService:Create(overlay, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 0.1
    }):Play()

    task.wait(0.18)

    -- warp ตัวละคร
    if onDone then onDone() end

    -- Phase 3: แสงค่อยๆ หาย + คืนกล้อง
    Camera.CameraType = Enum.CameraType.Custom
    TweenService:Create(overlay, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 1
    }):Play()
    TweenService:Create(Camera, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        FieldOfView = origFov
    }):Play()

    task.delay(0.6, function() overlay:Destroy() end)
end

Button("🌀 Warp", function()
    local name = warpBox.Text
    if name == "" then return end
    local target = workspace:FindFirstChild(name, true)
    if not target or not target:IsA("BasePart") then
        local err = make("TextLabel", {Size=UDim2.new(1,0,0,24), BackgroundTransparency=1,
            Text="❌ ไม่พบ Part ชื่อ: "..name, TextColor3=Color3.fromRGB(255,80,80),
            TextSize=12, Font=Enum.Font.Gotham}, scroll)
        task.delay(2, function() err:Destroy() end)
        return
    end
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    playWarpEffect(root, function()
        root.CFrame = CFrame.new(target.Position + Vector3.new(0, target.Size.Y/2 + 3, 0))
    end)
end)

-- ── ESP Section ──
make("Frame", {Size=UDim2.new(1,0,0,2), BackgroundColor3=blue, BorderSizePixel=0}, scroll)
make("TextLabel", {Size=UDim2.new(1,0,0,24), BackgroundTransparency=1,
    Text="  ── ESP ──", TextColor3=Color3.fromRGB(0,200,255),
    TextSize=12, Font=Enum.Font.GothamBold, TextXAlignment=Enum.TextXAlignment.Left}, scroll)

local espBoxes = {}

local function setESP(enabled)
    for _, v in pairs(espBoxes) do pcall(function() v:Destroy() end) end
    espBoxes = {}
    if not enabled then return end

    for _, p in ipairs(game.Players:GetPlayers()) do
        if p.Character then
            local isSelf = (p == player)
            local isEnemy = (p.Name == "Enemy")
            local fillColor = isSelf and Color3.fromRGB(0,180,255)
                or isEnemy and Color3.fromRGB(0,220,80)
                or Color3.fromRGB(255,50,50)

            local hl = Instance.new("Highlight")
            hl.Adornee = p.Character
            hl.FillColor = fillColor
            hl.FillTransparency = 0.4
            hl.OutlineColor = fillColor
            hl.OutlineTransparency = 0
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.Parent = p.Character
            table.insert(espBoxes, hl)
        end
    end
end

local espOn = false
local espConn

Toggle("👁️ ESP Players", false, function(v)
    espOn = v
    if v then
        setESP(true)
        espConn = game:GetService("RunService").Heartbeat:Connect(function()
            for _, box in pairs(espBoxes) do
                if not box.Parent then
                    setESP(true)
                    break
                end
            end
        end)
    else
        setESP(false)
        if espConn then espConn:Disconnect() espConn = nil end
    end
end)

-- ── Tools ESP Section ──
make("Frame", {Size=UDim2.new(1,0,0,2), BackgroundColor3=blue, BorderSizePixel=0}, scroll)
make("TextLabel", {Size=UDim2.new(1,0,0,24), BackgroundTransparency=1,
    Text="  ── Tools ESP ──", TextColor3=Color3.fromRGB(0,200,255),
    TextSize=12, Font=Enum.Font.GothamBold, TextXAlignment=Enum.TextXAlignment.Left}, scroll)

local toolHighlights = {}

local function clearToolESP()
    for _, v in pairs(toolHighlights) do pcall(function() v:Destroy() end) end
    toolHighlights = {}
end

local function applyToolESP()
    clearToolESP()
    local mapFolder = workspace:FindFirstChild("Map")
    if not mapFolder then return end
    local toolsFolder = mapFolder:FindFirstChild("Tools")
    if not toolsFolder then return end

    for _, item in ipairs(toolsFolder:GetChildren()) do
        -- Highlight สีเขียว
        local hl = Instance.new("Highlight")
        hl.Adornee = item
        hl.FillColor = Color3.fromRGB(0, 220, 80)
        hl.FillTransparency = 0.3
        hl.OutlineColor = Color3.fromRGB(0, 255, 100)
        hl.OutlineTransparency = 0
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.Parent = item
        table.insert(toolHighlights, hl)

        -- BillboardGui แสดงชื่อ
        local rootPart = item:IsA("BasePart") and item
            or item:FindFirstChildOfClass("BasePart")
            or item:FindFirstChild("Handle")
        if rootPart then
            local bb = Instance.new("BillboardGui")
            bb.Size = UDim2.new(0, 160, 0, 32)
            bb.StudsOffset = Vector3.new(0, 3, 0)
            bb.AlwaysOnTop = true
            bb.Parent = rootPart
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1,0,1,0)
            lbl.BackgroundTransparency = 1
            lbl.Text = "🟢 " .. item.Name
            lbl.TextColor3 = Color3.fromRGB(0, 255, 100)
            lbl.TextSize = 14
            lbl.Font = Enum.Font.GothamBold
            lbl.TextStrokeTransparency = 0.4
            lbl.Parent = bb
            table.insert(toolHighlights, bb)
        end
    end
end

local toolEspConn
Toggle("🟢 ESP Tools (Map/Tools)", false, function(v)
    if v then
        applyToolESP()
        -- อัปเดตถ้ามี tool ใหม่เพิ่มเข้ามา
        toolEspConn = game:GetService("RunService").Heartbeat:Connect(function()
            local mapFolder = workspace:FindFirstChild("Map")
            local toolsFolder = mapFolder and mapFolder:FindFirstChild("Tools")
            if not toolsFolder then return end
            if #toolsFolder:GetChildren() ~= #toolHighlights / 2 then
                applyToolESP()
            end
        end)
    else
        clearToolESP()
        if toolEspConn then toolEspConn:Disconnect() toolEspConn = nil end
    end
end)

-- Draggable
local drag, ds, sp = false, nil, nil
title.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        drag, ds, sp = true, i.Position, mf.Position
    end
end)
UIS.InputChanged:Connect(function(i)
    if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - ds
        mf.Position = UDim2.new(sp.X.Scale, sp.X.Offset+d.X, sp.Y.Scale, sp.Y.Offset+d.Y)
    end
end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag=false end end)

-- Open/Close
local open = true
local function setOpen(v)
    open = v
    mf.Visible = v
    tb.Text = v and "🔵 ปิด Menu" or "🔵 เปิด Menu"
end
tb.MouseButton1Click:Connect(function() setOpen(not open) end)
closeBtn.MouseButton1Click:Connect(function() setOpen(false) end)

-- ══════════════════════════════
-- KEY CONFIRM LOGIC
-- ══════════════════════════════
keyConfirm.MouseButton1Click:Connect(function()
    if keyBox.Text == VALID_KEY then
        -- ถูก: ปิด key UI แล้วเปิด main UI
        TweenService:Create(keyFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position=UDim2.new(0.5,-170,1.5,-80)}):Play()
        task.wait(0.35)
        keyFrame:Destroy()
        tb.Visible = true
        mf.Visible = true
        open = true
        tb.Text = "🔵 ปิด Menu"
    else
        -- ผิด: สั่น keyFrame
        keyStatus.Text = "❌ Key ไม่ถูกต้อง"
        keyStatus.TextColor3 = Color3.fromRGB(255,80,80)
        local origPos = keyFrame.Position
        for i = 1, 6 do
            local offset = (i % 2 == 0) and 8 or -8
            TweenService:Create(keyFrame, TweenInfo.new(0.04),
                {Position=UDim2.new(origPos.X.Scale, origPos.X.Offset+offset, origPos.Y.Scale, origPos.Y.Offset)}):Play()
            task.wait(0.05)
        end
        keyFrame.Position = origPos
        task.delay(2, function() keyStatus.Text = "" end)
    end
end)
