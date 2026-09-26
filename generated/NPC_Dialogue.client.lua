-- Village Guardian Demo
-- Paste into a Script under the NPC Model.
-- IMPORTANT: set Script.RunContext = Client in Studio Properties.

local CONFIG = {
  ObjectText = "Village Guard",
  ActionText = "Talk",
  MaxActivationDistance = 10,
  HoldDuration = 0,
  TextSpeed = 0.03,
  AutoAdvanceDelay = 2,
  NPCName = "VillageGuard",
  UITitle = "Conversation",
  NPCColor = Color3.fromHex("#ffffff"),
  ButtonColor = Color3.fromHex("#2a3150"),
  BackgroundColor = Color3.fromHex("#11151e"),
  ShowNPCBubble = true,
  ShowPlayerBubble = true,
}

local DIALOGUE = {
  [1] = {
    text = "Berhenti sebentar. Kamu mencari jalan ke hutan?",
    autoAdvance = false,
    autoNext = 0,
    options = {
      { text = "Ya, ada apa?", displayText = "Ya, ada apa?", next = 2 },
      { text = "Bukan urusanmu.", displayText = "Bukan urusanmu.", next = 0 },
    },
  },
  [2] = {
    text = "Jangan lewat sungai saat malam. Ada sesuatu yang muncul di sana.",
    autoAdvance = false,
    autoNext = 0,
    options = {
      { text = "Sesuatu seperti apa?", displayText = "Sesuatu seperti apa?", next = 3 },
      { text = "Terima kasih atas peringatannya.", displayText = "Terima kasih.", next = 0 },
    },
  },
  [3] = {
    text = "Cahaya biru. Kalau melihatnya, segera kembali ke desa.",
    autoAdvance = true,
    autoNext = 0,
    options = {},
  },
}

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local npc = script.Parent
assert(npc and npc:IsA("Model"), "Dialogue Script must be parented to the NPC Model")
local promptParent = npc:FindFirstChild("Head") or npc.PrimaryPart or npc:FindFirstChildWhichIsA("BasePart")
assert(promptParent and promptParent:IsA("BasePart"), "NPC needs a Head, PrimaryPart, or BasePart")

local prompt = Instance.new("ProximityPrompt")
prompt.Name = "DialoguePrompt"
prompt.ObjectText = CONFIG.ObjectText
prompt.ActionText = CONFIG.ActionText
prompt.MaxActivationDistance = CONFIG.MaxActivationDistance
prompt.HoldDuration = CONFIG.HoldDuration
prompt.Parent = promptParent

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SimpleDialogueUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.AnchorPoint = Vector2.new(.5, 1)
panel.Position = UDim2.fromScale(.5, .95)
panel.Size = UDim2.fromScale(.62, .28)
panel.BackgroundColor3 = CONFIG.BackgroundColor
panel.Visible = false
panel.Parent = screenGui
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(18, 10)
title.Size = UDim2.new(1, -36, 0, 22)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextColor3 = CONFIG.NPCColor
title.Text = CONFIG.UITitle
title.Parent = panel

local npcLabel = title:Clone()
npcLabel.Position = UDim2.fromOffset(18, 34)
npcLabel.Text = CONFIG.NPCName
npcLabel.Parent = panel

autoLayout = Instance.new("UIListLayout")
autoLayout.Padding = UDim.new(0, 7)
local optionsFrame = Instance.new("Frame")
optionsFrame.BackgroundTransparency = 1
optionsFrame.Position = UDim2.fromOffset(18, 64)
optionsFrame.Size = UDim2.new(1, -36, 1, -78)
optionsFrame.Parent = panel
autoLayout.Parent = optionsFrame

local line = Instance.new("TextLabel")
line.BackgroundTransparency = 1
line.Position = UDim2.fromOffset(18, 60)
line.Size = UDim2.new(1, -36, 0, 52)
line.Font = Enum.Font.Gotham
line.TextSize = 17
line.TextWrapped = true
line.TextXAlignment = Enum.TextXAlignment.Left
line.TextYAlignment = Enum.TextYAlignment.Top
line.TextColor3 = Color3.fromRGB(245,247,250)
line.Parent = panel

local active = false
local typingToken = 0
local currentNode

local function clearOptions()
  for _, child in ipairs(optionsFrame:GetChildren()) do
    if child:IsA("TextButton") then child:Destroy() end
  end
end

local function endDialogue()
  active = false
  currentNode = nil
  typingToken += 1
  clearOptions()
  panel.Visible = false
end

local function typeText(text, done)
  typingToken += 1
  local token = typingToken
  line.Text = ""
  for i = 1, #text do
    if token ~= typingToken then return end
    line.Text = string.sub(text, 1, i)
    task.wait(CONFIG.TextSpeed)
  end
  if done then done() end
end

local function displayNode(id)
  if not active or id == 0 or not DIALOGUE[id] then
    endDialogue()
    return
  end
  currentNode = DIALOGUE[id]
  panel.Visible = true
  clearOptions()
  typeText(currentNode.text or "", function()
    if currentNode.autoAdvance then
      task.delay(CONFIG.AutoAdvanceDelay, function()
        if active and currentNode == DIALOGUE[id] then displayNode(currentNode.autoNext or 0) end
      end)
      return
    end

    for _, option in ipairs(currentNode.options or {}) do
      local button = Instance.new("TextButton")
      button.BackgroundColor3 = CONFIG.ButtonColor
      button.Size = UDim2.new(1, 0, 0, 34)
      button.Text = option.text or "Continue"
      button.Font = Enum.Font.GothamMedium
      button.TextSize = 14
      button.TextColor3 = Color3.new(1,1,1)
      button.Parent = optionsFrame
      Instance.new("UICorner", button).CornerRadius = UDim.new(0, 9)
      button.Activated:Connect(function()
        if not active then return end
        clearOptions()
        if option.next and option.next ~= 0 then
          displayNode(option.next)
        else
          endDialogue()
        end
      end)
    end
  end)
end

prompt.Triggered:Connect(function(triggeringPlayer)
  if triggeringPlayer and triggeringPlayer ~= player then return end
  if active then return end
  active = true
  displayNode(1)
end)
