-- Pet Spawner for Garden (Non-visual, for KRNL use)
-- Replace 'Dog', 'Cat', 'Bee' with actual pet model names in ReplicatedStorage

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- List of pets you want to be able to spawn
local availablePets = {
    "Dog",
    "Cat",
    "Bee"
}

-- 🔧 CHANGE THIS to spawn a different pet from the list
local selectedPetName = "Dog" -- options: Dog, Cat, Bee

-- Get the pet model from ReplicatedStorage
local petModel = ReplicatedStorage:FindFirstChild(selectedPetName)
if not petModel then
    warn("Pet model '" .. selectedPetName .. "' not found in ReplicatedStorage.")
    return
end

-- Clone and place the pet in the garden (near player)
local petClone = petModel:Clone()
petClone.Name = player.Name .. "_" .. selectedPetName
petClone.Parent = Workspace

-- Set position (5 studs to the right of the player)
local position = hrp.Position + Vector3.new(5, 0, 0)
if petClone:IsA("Model") and petClone.PrimaryPart then
    petClone:SetPrimaryPartCFrame(CFrame.new(position))
else
    petClone:MoveTo(position)
end

print("Spawned pet:", selectedPetName)
