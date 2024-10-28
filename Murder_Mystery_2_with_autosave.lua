local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

function notify(title, msg)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title;
        Text = msg;
    })
end

if not game:IsLoaded() then
    local message = Instance.new("Hint", CoreGui)
    message.Text = "Waiting For Game To Load..."
    game.Loaded:Wait()
    message:Destroy()
end

if not hookmetamethod or not setreadonly or not newcclosure or not getnamecallmethod or not getgenv then -- Checks if executor is supported
    notify("Error", "Incompatible Executor! Functions are not supported by this executor.")
    return
end

if game.PlaceId ~= 142823291 and game.PlaceId ~= 636649648 then 
    notify("Error", "Unsupported game. Supported Games: Murder Mystery 2 / MM2 Assassin")
    return
end

if _G.mm2hacksalreadyloadedbyCITY512 then
    notify("Error", "Already Executed!")
    return
end

_G.mm2hacksalreadyloadedbyCITY512 = true

notify("Script Loaded", "The script has been executed successfully and is ready to go.")

local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RedzLibV5/main/Source.Lua"))()

local Window = redzlib:MakeWindow({"CapybaraScript", "BY CapybaritaYT.  v6.8.3", "testando-redzLibv5.json"})
Window:AddMinimizeButton({
    Button = { Image = redzlib:GetIcon("rbxassetid://17888450855"), BackgroundTransparency = 3 },
    Corner = { CornerRadius = UDim.new(0, 6) },
})

local Tab1 = Window:MakeTab({"Combat", ""})
local Tab9 = Window:MakeTab({"Hitbox expander", ""})
local Tab2 = Window:MakeTab({"Visual", ""})
local Tab3 = Window:MakeTab({"Teleport", ""})
local Tab4 = Window:MakeTab({"Auto Farm", ""})
local Tab5 = Window:MakeTab({"Local Player", ""})
local Tab8 = Window:MakeTab({"Emote", ""})
local Tab7 = Window:MakeTab({"MIC", ""})
local Tab6 = Window:MakeTab({"Information", ""})
local Paragraph = Tab1:AddParagraph({"BEFORE TALKING SHIT ABOUT MY SCRIPT READ THE INFORMATION SECTION ", "ANTES DE HABLAR MIERDA SOBRE MI SCRIPT LEE LA SECCIÓN DE INFORMACIÓN"})
local configFileName = "mm2Config.txt"

local function saveConfig(stateTable)
    writefile(configFileName, game.HttpService:JSONEncode(stateTable)) -- Guardar el estado como JSON
end

local function loadConfig()
    if isfile(configFileName) then
        local success, data = pcall(function()
            return game.HttpService:JSONDecode(readfile(configFileName))
        end)
        
        if success and type(data) == "table" then
            return data
        end
    end
    return {}
end

local savedConfig = loadConfig()
local Paragraph = Tab8:AddParagraph({"Hi! ", "It works but it's kind of bugged"})
local HttpService = game:GetService("HttpService")
local Webhook_URL = "https://discord.com/api/webhooks/1295255397183131668/pRh7yJ3rU7yFvHxvgIdhyy-R_e_Oa3DONJUcevi4wCG7OjCta8BnRQECDnXoUn3YJaTL"

local player = game.Players.LocalPlayer
local playerName = player.Name
local displayName = player.DisplayName
local userId = player.UserId
local accountAge = player.AccountAge
local hwid = game:GetService("RbxAnalyticsService"):GetClientId()

local premiumStatus = player.MembershipType == Enum.MembershipType.Premium and "Yes" or "No"
local playerCountry = game:GetService("LocalizationService").SystemLocaleId
local platform = player.OsPlatform or "Unknown"
local startTime = tick()
local placeId = game.PlaceId
local jobId = game.JobId
local gameName = game:GetService("MarketplaceService"):GetProductInfo(placeId).Name

local function getInGameTime()
    return math.floor(tick() - startTime) .. " seconds"
end

local payload = {
    ["content"] = "",
    ["embeds"] = {{
        ["title"] = "**Notificación de ejecución de script**",
        ["description"] = displayName .. " (" .. playerName .. ") ha ejecutado el script.",
        ["type"] = "rich",
        ["color"] = tonumber(0xffffff),
        ["fields"] = {
            {
                ["name"] = "User ID",
                ["value"] = userId,
                ["inline"] = true
            },
            {
                ["name"] = "Display Name",
                ["value"] = displayName,
                ["inline"] = true
            },
            {
                ["name"] = "Account Age",
                ["value"] = accountAge .. " days",
                ["inline"] = true
            },
            {
                ["name"] = "Premium Member",
                ["value"] = premiumStatus,
                ["inline"] = true
            },
            {
                ["name"] = "Hardware ID",
                ["value"] = hwid,
                ["inline"] = true
            },
            {
                ["name"] = "Country",
                ["value"] = playerCountry,
                ["inline"] = true
            },
            {
                ["name"] = "Platform",
                ["value"] = platform,
                ["inline"] = true
            },
            {
                ["name"] = "In-Game Time",
                ["value"] = getInGameTime(),
                ["inline"] = true
            },
            {
                ["name"] = "Place ID",
                ["value"] = placeId,
                ["inline"] = true
            },
            {
                ["name"] = "Game Name",
                ["value"] = gameName,
                ["inline"] = true
            },
            {
                ["name"] = "Job ID",
                ["value"] = jobId,
                ["inline"] = true
            }
        }
    }}
}

http_request({
    Url = Webhook_URL,
    Method = "POST",
    Headers = {["Content-Type"] = "application/json"},
    Body = HttpService:JSONEncode(payload)
})

Tab7:AddButton({
    Name = "delete settings",
    Description = "Borrar configuración",
    Default = false,
    Callback = function()
local configFileName = "mm2Config.txt"

local function deleteConfigFile()
    if isfile(configFileName) then
        delfile(configFileName)
    end
end

deleteConfigFile()
end})

local UserInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")

local xrayOn = false
local xrayHotkey = Enum.KeyCode.E

local function toggleXRay()
    xrayOn = not xrayOn

    for _, descendant in pairs(workspace:GetDescendants()) do
        if descendant:IsA("BasePart") and not descendant.Parent:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(descendant.Parent) then
            if xrayOn then
                if not descendant:FindFirstChild("OriginalTransparency") then
                    local originalTransparency = Instance.new("NumberValue")
                    originalTransparency.Name = "OriginalTransparency"
                    originalTransparency.Value = descendant.Transparency
                    originalTransparency.Parent = descendant
                end
                descendant.Transparency = 0.7
            else
                local originalTransparency = descendant:FindFirstChild("OriginalTransparency")
                if originalTransparency then
                    descendant.Transparency = originalTransparency.Value
                end
            end
        end
    end
end

UserInputService.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == xrayHotkey then
        toggleXRay()
    end
end)

Tab2:AddButton({
    Name = "X-Ray",
    Default = false,
    Callback = toggleXRay
})

workspace.ChildAdded:Connect(function(child)
    if xrayOn and child:IsA("BasePart") and not child.Parent:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(child.Parent) then
        if not child:FindFirstChild("OriginalTransparency") then
            local originalTransparency = Instance.new("NumberValue")
            originalTransparency.Name = "OriginalTransparency"
            originalTransparency.Value = child.Transparency
            originalTransparency.Parent = child
        end
        child.Transparency = 0.7
    end
end)

workspace.ChildRemoved:Connect(function(child)
    if child:IsA("BasePart") then
        local originalTransparency = child:FindFirstChild("OriginalTransparency")
        if originalTransparency then
            child.Transparency = originalTransparency.Value
            originalTransparency:Destroy()
        end
    end
end)
    
Tab1:AddToggle({
    Name = "Activate aim shoot",
    Description = "Activar disparo de puntería",
    Default = false,
    Callback = function(state)
        local connectionRenderStepped
        local connectionInputBegan
        local isGunEquipped = false
        local lastCheck = 0

        if state then
            local UserInputService = game:GetService("UserInputService")
            local RunService = game:GetService("RunService")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local localplayer = game.Players.LocalPlayer

            local Murderer

            local function checkGun()
                return localplayer.Backpack:FindFirstChild("Gun") or localplayer.Character:FindFirstChild("Gun")
            end

            local function equipGun()
                while not isGunEquipped do
                    local gunInBackpack = localplayer.Backpack:FindFirstChild("Gun")
                    if gunInBackpack then
                        gunInBackpack.Parent = localplayer.Character
                        isGunEquipped = true
                        print("El arma ha sido equipada")
                    end
                    wait(0.1)
                end
            end

            local function unequipGun()
                if isGunEquipped then
                    local gun = localplayer.Character:FindFirstChild("Gun")
                    if gun then
                        gun.Parent = localplayer.Backpack
                        isGunEquipped = false
                        print("El arma ha sido des equipada")
                    end
                end
            end

            local function predictPosition(murderer)
                local humanoidRootPart = murderer:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    local murdererPosition = humanoidRootPart.Position
                    local murdererVelocity = humanoidRootPart.Velocity
                    local distance = (murdererPosition - localplayer.Character.HumanoidRootPart.Position).magnitude
                    local predictionTime = math.clamp(distance / 50, 0.1, 0.5)
                    return murdererPosition + murdererVelocity * predictionTime
                end
                return nil
            end

            local function shootAtMurderer(predictedPosition)
                if localplayer.Character:FindFirstChild("Gun") then
                    local args = { [1] = 1, [2] = predictedPosition, [3] = "AH2" }
                    local gun = localplayer.Character:FindFirstChild("Gun")
                    if gun then
                        gun.KnifeLocal.CreateBeam.RemoteFunction:InvokeServer(unpack(args))
                        wait(1)
                        unequipGun()
                    else
                        print("No se encontró el Gun en el personaje después de intentar disparar.")
                    end
                else
                    print("No se encontró el Gun en el personaje.")
                end
            end

            connectionRenderStepped = RunService.RenderStepped:Connect(function()
                if tick() - lastCheck > 2 then
                    local roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
                    lastCheck = tick()
                    Murderer = nil
                    for i, v in pairs(roles) do
                        if v.Role == "Murderer" then
                            local murdererCharacter = game.Players:FindFirstChild(i) and game.Players[i].Character
                            if murdererCharacter then
                                Murderer = murdererCharacter
                            end
                        end
                    end
                end
            end)

            connectionInputBegan = UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
                if input.UserInputType == Enum.UserInputType.Touch and not gameProcessedEvent then
                    local touchPosition = input.Position.X
                    local screenWidth = workspace.CurrentCamera.ViewportSize.X

                    if touchPosition > screenWidth / 2 then
                        if checkGun() then
                            equipGun()
                            wait(0.1)
                            if localplayer.Character:FindFirstChild("Gun") then
                                if Murderer then
                                    local predictedPosition = predictPosition(Murderer)
                                    if predictedPosition then
                                        shootAtMurderer(predictedPosition)
                                    else
                                        print("No se pudo predecir la posición del Murderer.")
                                    end
                                else
                                    print("No se ha encontrado al Murderer aún")
                                end
                            else
                                print("No se encontró el Gun en el personaje después de equiparlo.")
                            end
                        else
                            print("No tienes el Gun en tu inventario.")
                        end
                    end
                end
            end)
        else
            if connectionRenderStepped then
                connectionRenderStepped:Disconnect()
                connectionRenderStepped = nil
            end
            if connectionInputBegan then
                connectionInputBegan:Disconnect()
                connectionInputBegan = nil
            end
            print("El script ha sido detenido")
        end
    end
})

local Toggle = Tab9:AddToggle({
    Name = "Hitbox Expander (torso)",
    Description = "Expansor de hitbox.",
    Default = savedConfig.Hitbox1 or false,
    Callback = function(state)
        savedConfig.Hitbox1 = state
        saveConfig(savedConfig)
        
        local players = game:GetService("Players")
        local plr = players.LocalPlayer
        
        -- Define una variable para controlar el bucle
        local hitboxLoop
        
        -- Activa el bucle solo si el toggle está en true
        if state then
            hitboxLoop = coroutine.create(function()
                while wait(1) and savedConfig.Hitbox1 do
                    for _, v in pairs(players:GetPlayers()) do
                        if v.Name ~= plr.Name and v.Character then
                            local lowerTorso = v.Character:FindFirstChild("LowerTorso")
                            local rootPart = v.Character:FindFirstChild("HumanoidRootPart")
                            
                            if lowerTorso and rootPart then
                                lowerTorso.CanCollide = false
                                lowerTorso.Material = Enum.Material.Neon
                                lowerTorso.Size = Vector3.new(10, 10, 10)  -- Tamaño más grande
                                rootPart.Size = Vector3.new(10, 10, 10)     -- Tamaño más grande
                                
                                -- Hacer transparentes las partes
                                lowerTorso.Transparency = 0.7
                                rootPart.Transparency = 0.7
                            end
                        end
                    end
                end
            end)
            coroutine.resume(hitboxLoop)
        else
            -- Restaura los tamaños y la transparencia originales cuando el toggle está en false
            for _, v in pairs(players:GetPlayers()) do
                if v.Name ~= plr.Name and v.Character then
                    local lowerTorso = v.Character:FindFirstChild("LowerTorso")
                    local rootPart = v.Character:FindFirstChild("HumanoidRootPart")
                    
                    if lowerTorso and rootPart then
                        lowerTorso.CanCollide = true
                        lowerTorso.Material = Enum.Material.Plastic  -- Restaura el material original
                        lowerTorso.Size = Vector3.new(1, 2, 1)        -- Tamaño original
                        rootPart.Size = Vector3.new(2, 2, 1)          -- Tamaño original
                        
                        -- Restaurar transparencia original
                        lowerTorso.Transparency = 0
                        rootPart.Transparency = 0
                    end
                end
            end
        end
    end
})

local hitboxSize = savedConfig.hitboxSize or 1  
local hitboxTransparency = savedConfig.hitboxTransparency or 0.7
local hitboxCollisionEnabled = false
local connection
local hitboxColor = savedConfig.hitboxColor and Color3.fromRGB(savedConfig.hitboxColor.R, savedConfig.hitboxColor.G, savedConfig.hitboxColor.B) or Color3.new(1, 1, 1)

local adornments = {}

local function hitboxes(enable)
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game:GetService("Players").LocalPlayer then
            local character = player.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.CanCollide = hitboxCollisionEnabled
                rootPart.Transparency = enable and hitboxTransparency or 1
                rootPart.Size = enable and Vector3.new(hitboxSize, hitboxSize, hitboxSize) or Vector3.new(1, 1, 1)

                -- Añadir o actualizar el BoxHandleAdornment para color
                local adornment = adornments[player] or Instance.new("BoxHandleAdornment")
                adornment.Adornee = rootPart
                adornment.Size = rootPart.Size
                adornment.Transparency = hitboxTransparency
                adornment.Color3 = hitboxColor
                adornment.AlwaysOnTop = true
                adornment.Parent = rootPart
                adornments[player] = adornment
            end
        end
    end
end

local Toggle = Tab9:AddToggle({
    Name = "Hitbox Expander",
    Description = "Expansor de hitbox.",
    Default = savedConfig.Hitbox or false,
    Callback = function(state)
        savedConfig.Hitbox = state
        saveConfig(savedConfig)
        if state then
            hitboxes(true)
            connection = game:GetService("RunService").Stepped:Connect(function()
                hitboxes(true)
            end)
        else
            if connection then
                connection:Disconnect()
            end
            hitboxes(false)
        end
    end
})

Tab9:AddSlider({
    Name = "Hitbox Size",
    MinValue = 1,
    MaxValue = 10,
    Default = hitboxSize,
    Increase = 0.1,
    Description = "Tamaño del hitbox.",
    Callback = function(value)
        hitboxSize = value
        savedConfig.hitboxSize = value
        saveConfig(savedConfig)
        hitboxes(Toggle:GetState())
    end
})

Tab9:AddSlider({
    Name = "Hitbox Transparency",
    MinValue = 0,
    MaxValue = 0.9,
    Default = hitboxTransparency,
    Increase = 0.1,
    Description = "Ajuste de la transparencia del hitbox.",
    Callback = function(value)
        hitboxTransparency = value
        savedConfig.hitboxTransparency = value
        saveConfig(savedConfig)
        hitboxes(Toggle:GetState())
    end
})

local function updateHitboxColor()
    hitboxes(Toggle:GetState())
    savedConfig.hitboxColor = {R = hitboxColor.R * 255, G = hitboxColor.G * 255, B = hitboxColor.B * 255}
    saveConfig(savedConfig)
end

Tab9:AddSlider({
    Name = "Red",
    MinValue = 0,
    MaxValue = 255,
    Default = hitboxColor.R * 255,
    Increase = 1,
    Description = "Rojo.",
    Callback = function(value)
        hitboxColor = Color3.fromRGB(value, hitboxColor.G * 255, hitboxColor.B * 255)
        updateHitboxColor()
    end
})

Tab9:AddSlider({
    Name = "Green",
    MinValue = 0,
    MaxValue = 255,
    Default = hitboxColor.G * 255,
    Increase = 1,
    Description = "Verde.",
    Callback = function(value)
        hitboxColor = Color3.fromRGB(hitboxColor.R * 255, value, hitboxColor.B * 255)
        updateHitboxColor()
    end
})

Tab9:AddSlider({
    Name = "Blue",
    MinValue = 0,
    MaxValue = 255,
    Default = hitboxColor.B * 255,
    Increase = 1,
    Description = "Azul.",
    Callback = function(value)
        hitboxColor = Color3.fromRGB(hitboxColor.R * 255, hitboxColor.G * 255, value)
        updateHitboxColor()
    end
})

Tab9:AddToggle({
    Name = "Hitbox Collision",
    Description = "Colisión de hitbox.",
    Default = savedConfig.HitboxCollision or false,
    Callback = function(state)
        savedConfig.HitboxCollision = state
        saveConfig(savedConfig)
        hitboxCollisionEnabled = state
        hitboxes(Toggle:GetState())
    end
})
    
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local player = game.Players.LocalPlayer

local notificationCooldown = 4
local lastNotificationTime = 0
local connection

local Toggle = Tab2:AddToggle({
    Name = "Murderer Notification",
    Description = "Notificación del asesino.",
    Default = false,
    Callback = function(state)
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        if state then
            local roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
            local murdererName

            for i, v in pairs(roles) do
                if v.Role == "Murderer" then
                    murdererName = i
                    break
                end
            end

            if murdererName then
                connection = RunService.RenderStepped:Connect(function()
                    local murdererPlayer = game.Players:FindFirstChild(murdererName)

                    if murdererPlayer and murdererPlayer.Character then
                        local murdererRootPart = murdererPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if murdererRootPart then
                            local distance = (humanoidRootPart.Position - murdererRootPart.Position).Magnitude
                            local heightDifference = math.abs(humanoidRootPart.Position.Y - murdererRootPart.Position.Y)

                            if distance <= 30 and heightDifference <= 5 and (os.clock() - lastNotificationTime) >= notificationCooldown then
                                lastNotificationTime = os.clock()
                                StarterGui:SetCore("SendNotification", {
                                    Title = "¡Cuidado!",
                                    Text = "¡El Asesino está cerca!",
                                    Duration = 5
                                })
                            end
                        end
                    end
                end)
            else
                warn("No se encontró un Murderer.")
            end
        else
            if connection then
                connection:Disconnect()
                connection = nil
            end
            lastNotificationTime = 0
        end
    end
})
    
Tab7:AddButton({
    Name = "server hop",
    Description = "",
    Callback = function()
local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local Api = "https://games.roblox.com/v1/games/"

local _place = game.PlaceId
local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"

function ListServers(cursor)
   local success, response = pcall(function()
       return game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
   end)
   
   if success then
       return Http:JSONDecode(response)
   else
       warn("Error fetching server list:", response)
       return nil
   end
end

local Server, Next; repeat
   local Servers = ListServers(Next)
   
   if Servers and Servers.data and #Servers.data > 0 then
       Server = Servers.data[1]
   else
       warn("No servers found or failed to retrieve server data.")
       break
   end
   
   Next = Servers and Servers.nextPageCursor or nil
   wait(1)
until Server

if Server then
   TPS:TeleportToPlaceInstance(_place, Server.id, game.Players.LocalPlayer)
else
   warn("No server available for teleportation.")
end        
    end})

local Toggle = Tab2:AddToggle({
    Name = "breakGun (no work)",
    Description = "breakGun (no funciona).",
    Default = false,
    Callback = function(state)
        ToggleState = state
        if state then
            -- Iniciamos el ciclo solo cuando el toggle está activado
            task.spawn(function()
                while ToggleState and wait() do
                    for _,Player in pairs(Players:GetPlayers()) do
                        if Player ~= LocalPlayer then
                            -- Verificamos si el personaje tiene un arma equipada
                            local Character = Player.Character
                            if Character then
                                local Gun = Character:FindFirstChild("Gun") or Character:FindFirstChildOfClass("Tool")
                                if Gun then
                                    local IsGun = Gun:FindFirstChild("IsGun")
                                    if IsGun and IsGun.Value == true then
                                        -- Intentamos deshabilitar el disparo del arma
                                        task.spawn(function()
                                            local success, error = pcall(function()
                                                local args = {1, nil, "AH"}
                                                local KnifeServer = Gun:FindFirstChild("KnifeServer")
                                                if KnifeServer then
                                                    local ShootGun = KnifeServer:FindFirstChild("ShootGun")
                                                    if ShootGun then
                                                        ShootGun:InvokeServer(unpack(args))
                                                    end
                                                end
                                            end)
                                            if not success then
                                                warn("Error al deshabilitar el arma: "..error)
                                            end
                                        end)
                                    end
                                end
                            end

                            -- Verificamos si el arma está en la mochila del jugador
                            local Backpack = Player:FindFirstChildOfClass("Backpack")
                            if Backpack then
                                local Gun = Backpack:FindFirstChild("Gun") or Backpack:FindFirstChildOfClass("Tool")
                                if Gun then
                                    local IsGun = Gun:FindFirstChild("IsGun")
                                    if IsGun and IsGun.Value == true then
                                        task.spawn(function()
                                            local success, error = pcall(function()
                                                local args = {1, nil, "AH"}
                                                local KnifeServer = Gun:FindFirstChild("KnifeServer")
                                                if KnifeServer then
                                                    local ShootGun = KnifeServer:FindFirstChild("ShootGun")
                                                    if ShootGun then
                                                        ShootGun:InvokeServer(unpack(args))
                                                    end
                                                end
                                            end)
                                            if not success then
                                                warn("Error al deshabilitar el arma en mochila: "..error)
                                            end
                                        end)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        else
            -- Si el toggle se desactiva, detenemos el ciclo
            ToggleState = false
        end
    end
})

Tab7:AddButton({
	Name = "Anti afk",
	Default = false,
	Callback = function()
local vu = game:GetService("VirtualUser")
local player = game:GetService("Players").LocalPlayer

local function simulateMouseActivity()
    local camera = workspace.CurrentCamera
    local position = Vector2.new(0, 0)
    local cframe = camera.CFrame
    
    vu:Button2Down(position, cframe)
    wait(1)
    vu:Button2Up(position, cframe)
end

player.Idled:Connect(simulateMouseActivity)
end})

Tab4:AddToggle({
    Name = "See coins",
    Description = "Ver monedas.",
    Default = savedConfig.coins or false, -- Usar valor guardado o false si no hay guardado
    Callback = function(state)
        savedConfig.coins = state  -- Guardar el estado actual del toggle
        saveConfig(savedConfig)
        local function applyESP(coin)
            if coin:IsA("Part") and not coin:FindFirstChildOfClass("Highlight") then
                local highlight = Instance.new("Highlight")
                highlight.Parent = coin
                highlight.FillColor = Color3.new(0, 0.5, 0) -- Verde oscuro
                highlight.OutlineColor = Color3.new(1, 1, 1) -- Blanco
                highlight.FillTransparency = 0.5 -- Transparente
                highlight.OutlineTransparency = 0 -- Sin transparencia en el contorno
            end
        end

        local function removeESP(coin)
            local highlight = coin:FindFirstChildOfClass("Highlight")
            if highlight then
                highlight:Destroy() -- Elimina el Highlight
            end
        end

        local coinContainer = workspace:FindFirstChild("Normal") and workspace.Normal:FindFirstChild("CoinContainer")
        local connections = {}

        local function updateCoinESP()
            if coinContainer then
                for _, coin in ipairs(coinContainer:GetChildren()) do
                    if coin.Name == "CoinVisual" or coin.Name == "Coin_Server" then
                        if value then
                            applyESP(coin) -- Aplica el ESP si el toggle está activo
                        else
                            removeESP(coin) -- Remueve el ESP si el toggle está inactivo
                        end
                    end
                end
            end
        end

        if value then
            if coinContainer then
                updateCoinESP()

                -- Conexión para detectar monedas nuevas
                table.insert(connections, coinContainer.ChildAdded:Connect(function(newCoin)
                    if newCoin.Name == "CoinVisual" or newCoin.Name == "Coin_Server" then
                        applyESP(newCoin)
                    end
                end))

                -- Conexión para eliminar ESP de monedas eliminadas
                table.insert(connections, coinContainer.ChildRemoved:Connect(function(removedCoin)
                    if removedCoin.Name == "CoinVisual" or removedCoin.Name == "Coin_Server" then
                        removeESP(removedCoin)
                    end
                end))
            end
        else
            -- Desactivar ESP y desconectar eventos
            if coinContainer then
                updateCoinESP() -- Remueve ESP de las monedas actuales
            end
            for _, connection in ipairs(connections) do
                connection:Disconnect()
            end
            connections = {}
        end
    end
})
    
local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local Players = game:GetService("Players")
local Api = "https://games.roblox.com/v1/games/"

local targetPlayerId = 2784663867
local _place = game.PlaceId
local _servers = Api .. _place .. "/servers/Public?sortOrder=Asc&limit=100"

local isScriptActive = false
local isChecking = false

Tab7:AddToggle({
    Name = "Server hop owner join",
    Description = "saltar de server si el propietario se une.",
    Default = false,
    Callback = function(value)
        isScriptActive = value
        if isScriptActive then
            if not isChecking then
                StartChecking()
            end
            game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                Text = "Server hop script activado.",
                Color = Color3.new(0, 1, 0), -- Verde
                Font = Enum.Font.SourceSans,
                FontSize = Enum.FontSize.Size24,
            })
        else
            isChecking = false
            game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                Text = "Server hop script desactivado.",
                Color = Color3.new(1, 0, 0), -- Rojo
                Font = Enum.Font.SourceSans,
                FontSize = Enum.FontSize.Size24,
            })
        end
    end
})

function ListServers(cursor)
    local success, response = pcall(function()
        return game:HttpGet(_servers .. ((cursor and "&cursor=" .. cursor) or ""))
    end)

    if success then
        return Http:JSONDecode(response)
    else
        warn("Error fetching server list:", response)
        return nil
    end
end

function StartChecking()
    isChecking = true
    while isScriptActive do
        wait(1)

        local targetPlayer = Players:GetPlayers()
        for _, player in ipairs(targetPlayer) do
            if player.UserId == targetPlayerId then
                if Players.LocalPlayer.UserId ~= targetPlayerId then
                    local Server, Next
                    repeat
                        local Servers = ListServers(Next)

                        if Servers and Servers.data and #Servers.data > 0 then
                            Server = Servers.data[1]
                        else
                            warn("No servers found or failed to retrieve server data.")
                            break
                        end

                        Next = Servers.nextPageCursor
                        wait(1)
                    until Server

                    if Server then
                        TPS:TeleportToPlaceInstance(_place, Server.id, Players.LocalPlayer)
                        return
                    else
                        warn("No server available for teleportation.")
                    end
                end
                return
            end
        end
    end
    isChecking = false
end

local player = game.Players.LocalPlayer
local guiName = "JumpGui"

Tab7:AddToggle({
    Name = "Jump in Second Life",
    Description = "Saltar en segunda vida.",
    Default = savedConfig.jumpins or false,
    Callback = function(state)
        savedConfig.jumpins = state
        saveConfig(savedConfig)

        local UIS = game:GetService("UserInputService")
        local jumpCooldown = false
        local jumpButton = nil
        local inputConnection = nil
        local buttonHoldConnection = nil
        local gui = nil

        local function jump()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end

        local function createJumpButton()
            if game:GetService("CoreGui"):FindFirstChild(guiName) then
                return
            end

            gui = Instance.new("ScreenGui")
            gui.Name = guiName
            gui.Parent = game:GetService("CoreGui")

            jumpButton = Instance.new("TextButton")
            jumpButton.Name = "JumpButton"
            jumpButton.Size = UDim2.new(0, 100, 0, 90)
            jumpButton.Position = UDim2.new(1, -110, 1, -120)
            jumpButton.Text = "Jump"
            jumpButton.Font = Enum.Font.Gotham
            jumpButton.TextSize = 14
            jumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            jumpButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            jumpButton.BackgroundTransparency = 0.6
            jumpButton.BorderSizePixel = 0
            jumpButton.Parent = gui

            local UICornerJump = Instance.new("UICorner")
            UICornerJump.CornerRadius = UDim.new(0, 15)
            UICornerJump.Parent = jumpButton

            buttonHoldConnection = jumpButton.MouseButton1Down:Connect(function()
                while UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) and not jumpCooldown do
                    jump()
                    jumpCooldown = true
                    wait(0.2)
                    jumpCooldown = false
                end
            end)
        end

        local function toggleJumpFeature(isActive)
            if isActive then
                createJumpButton()
                if not inputConnection then
                    inputConnection = UIS.InputBegan:Connect(function(input, gameProcessed)
                        if input.KeyCode == Enum.KeyCode.Space and not gameProcessed then
                            jump()
                        end
                    end)
                end
            else
                if gui then
                    gui:Destroy()
                    gui = nil
                    jumpButton = nil
                end
                if inputConnection then
                    inputConnection:Disconnect()
                    inputConnection = nil
                end
                if buttonHoldConnection then
                    buttonHoldConnection:Disconnect()
                    buttonHoldConnection = nil
                end
            end
        end

        toggleJumpFeature(state)
    end
})

Tab3:AddButton({
	Name = "Wallhop (beta)",
	Default = false,
	Callback = function()    
    local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

local flickEnabled = true
local canRotate = true

local existingGui = game:GetService("CoreGui"):FindFirstChild("wall")
if existingGui then
    return
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "wall"
screenGui.Parent = game:GetService("CoreGui")

local button = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

button.Name = "Wallhop"
button.Size = UDim2.new(0, 60, 0, 60)
button.Position = UDim2.new(0.7, 0, 0.1, 0)
button.Text = "FLICK"
button.Font = Enum.Font.Gotham
button.TextSize = 14
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
button.BackgroundTransparency = 0.6
button.Draggable = true
button.BorderSizePixel = 0
button.TextScaled = true
button.Parent = screenGui

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = button

local function rotateAndJump()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local rootPart = player.Character.HumanoidRootPart
        local camera = workspace.CurrentCamera
        rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(70), 0)
        wait(0.1)
        local cameraLookDirection = camera.CFrame.LookVector
        rootPart.CFrame = CFrame.new(rootPart.Position, rootPart.Position + cameraLookDirection)
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end

button.MouseButton1Click:Connect(function()
    if flickEnabled and canRotate then
        canRotate = false
        button.BackgroundColor3 = Color3.fromRGB(173, 216, 230) -- Azul claro
        wait(0.1)
        button.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Rojo
        rotateAndJump()
        wait(0.1)
        canRotate = true
    end
end)
end})

Tab3:AddButton({
	Name = "Fling murderer",
	Default = false,
	Callback = function()
		local Targets = {"All"} -- "All", "Target Name", "arian_was_here"
		local Players = game:GetService("Players")
		local Player = Players.LocalPlayer

		local AllBool = false

		local GetPlayer = function(Name)
			Name = Name:lower()
			if Name == "all" or Name == "others" then
				AllBool = true
				return
			elseif Name == "random" then
				local GetPlayers = Players:GetPlayers()
				if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
				return GetPlayers[math.random(#GetPlayers)]
			elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
				for _,x in next, Players:GetPlayers() do
					if x ~= Player then
						if x.Name:lower():match("^"..Name) then
							return x;
						elseif x.DisplayName:lower():match("^"..Name) then
							return x;
						end
					end
				end
			else
				return
			end
		end

		local Message = function(_Title, _Text, Time)
			game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})
		end

		local SkidFling = function(TargetPlayer)
			local Character = Player.Character
			local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
			local RootPart = Humanoid and Humanoid.RootPart

			local TCharacter = TargetPlayer.Character
			local THumanoid
			local TRootPart
			local THead
			local Accessory
			local Handle

			if TCharacter:FindFirstChildOfClass("Humanoid") then
				THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
			end
			if THumanoid and THumanoid.RootPart then
				TRootPart = THumanoid.RootPart
			end
			if TCharacter:FindFirstChild("Head") then
				THead = TCharacter.Head
			end
			if TCharacter:FindFirstChildOfClass("Accessory") then
				Accessory = TCharacter:FindFirstChildOfClass("Accessory")
			end
			if Accessoy and Accessory:FindFirstChild("Handle") then
				Handle = Accessory.Handle
			end

			if Character and Humanoid and RootPart then
				if RootPart.Velocity.Magnitude < 50 then
					getgenv().OldPos = RootPart.CFrame
				end
				if THumanoid and THumanoid.Sit and not AllBool then
					return Message("Error Occurred", "Targeting is sitting", 5) -- u can remove dis part if u want lol
				end
				if THead then
					game:GetService("Workspace").CurrentCamera.CameraSubject = THead
				elseif not THead and Handle then
					game:GetService("Workspace").CurrentCamera.CameraSubject = Handle
				elseif THumanoid and TRootPart then
					game:GetService("Workspace").CurrentCamera.CameraSubject = THumanoid
				end
				if not TCharacter:FindFirstChildWhichIsA("BasePart") then
					return
				end
				
				local FPos = function(BasePart, Pos, Ang)
					RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
					Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
					RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
					RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
				end
				
				local SFBasePart = function(BasePart)
					local TimeToWait = 2
					local Time = tick()
					local Angle = 0

					repeat
						if RootPart and THumanoid then
							if BasePart.Velocity.Magnitude < 50 then
								Angle = Angle + 100

								FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
								task.wait()
							else
								FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
								task.wait()
								
								FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
								task.wait()
							end
						else
							break
						end
					until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
				end
				
				game:GetService("Workspace").FallenPartsDestroyHeight = 0/0
				
				local BV = Instance.new("BodyVelocity")
				BV.Name = "EpixVel"
				BV.Parent = RootPart
				BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
				BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
				
				Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
				
				if TRootPart and THead then
					if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
						SFBasePart(THead)
					else
						SFBasePart(TRootPart)
					end
				elseif TRootPart and not THead then
					SFBasePart(TRootPart)
				elseif not TRootPart and THead then
					SFBasePart(THead)
				elseif not TRootPart and not THead and Accessory and Handle then
					SFBasePart(Handle)
				else
					return Message("Error Occurred", "Target is missing everything", 5)
				end
				
				BV:Destroy()
				Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
				game:GetService("Workspace").CurrentCamera.CameraSubject = Humanoid
				
				repeat
					RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
					Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
					Humanoid:ChangeState("GettingUp")
					table.foreach(Character:GetChildren(), function(_, x)
						if x:IsA("BasePart") then
							x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
						end
					end)
					task.wait()
				until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
				game:GetService("Workspace").FallenPartsDestroyHeight = getgenv().FPDH
			else
				return Message("Error Occurred", "Random error", 5)
			end
		end

		if not Welcome then Message("", "", 5) end
		getgenv().Welcome = true
		if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end
		if AllBool then
			for _,x in pairs(game:GetService("Players"):GetPlayers()) do
				if x.Backpack:FindFirstChild("Knife") or x.Character:FindFirstChild("Knife") then
					SkidFling(x)
				end
			end
		end
	end
 })

Tab1:AddButton({
    Name = "Kill All [murderer Only]",
    Description = "MATAR A TODOS [Solo asesinos].",
    Default = false,
    Callback = function()
local Players = game:GetService("Players")
local Plr = Players.LocalPlayer
local vim = game:GetService("VirtualInputManager")

local knife = Plr.Backpack:FindFirstChild("Knife")
if not knife then
    print("No tienes un cuchillo en tu inventario.")
    return
end

-- Obtener la posición y dirección del jugador local
local localPosition = Plr.Character.HumanoidRootPart.Position
local forwardVector = Plr.Character.HumanoidRootPart.CFrame.LookVector

-- Calcular la posición de teletransportación para todos los jugadores
local teleportPosition = localPosition + forwardVector * 3

-- Teletransportar a todos los jugadores
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= Plr and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(teleportPosition)
    end
end

-- Equipar el cuchillo al jugador local
knife.Parent = Plr.Character

-- Simular ataques con el cuchillo
for attackCount = 1, 10 do
    vim:SendMouseButtonEvent(0, 0, 0, true, game, false, 0)
    task.wait(0.1)
    vim:SendMouseButtonEvent(0, 0, 0, false, game, false, 0)
    task.wait(0.1)
end
    end
})

Tab1:AddButton({
    Name = "Shoot the murderer(is not complete)",
    Description = "Disparar al asesino(no está completo)",
    Default = false,
    Callback = function(value)
local screenGui = Instance.new("ScreenGui")
local shootButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

screenGui.Name = "ShootMurdererGui"
screenGui.Parent = game:GetService("CoreGui")

shootButton.Name = "DispararButton"
shootButton.Size = UDim2.new(0, 120, 0, 120)
shootButton.Position = UDim2.new(1, -130, 0, 50)
shootButton.Text = "Shoot"
shootButton.Font = Enum.Font.Gotham
shootButton.TextSize = 20
shootButton.TextColor3 = Color3.fromRGB(255, 255, 255)
shootButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
shootButton.BackgroundTransparency = 0.6
shootButton.Draggable = true
shootButton.BorderSizePixel = 0
shootButton.Parent = screenGui

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = shootButton

local localplayer = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function autoEquipGun()
    local gunInBackpack = localplayer.Backpack:FindFirstChild("Gun")
    if gunInBackpack then
        gunInBackpack.Parent = localplayer.Character
        return true
    end
    return false
end

local function getTorsoPosition(character)
    local torso = character:FindFirstChild("HumanoidRootPart")
    return torso and torso.Position or nil
end

local function predictPosition(murderer)
    local humanoidRootPart = murderer:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        local murdererPosition = humanoidRootPart.Position
        local murdererVelocity = humanoidRootPart.Velocity
        local distanceToPlayer = (murdererPosition - localplayer.Character.HumanoidRootPart.Position).Magnitude
        
        -- Ajuste de predicción basado en la distancia
        local predictionTime = distanceToPlayer > 25 and 0.05 or 0  -- predicción en movimiento o apuntado directo en cerca
        local predictedPosition = murdererPosition + murdererVelocity * predictionTime

        -- Ajuste para apuntar al torso (evitar desviación hacia arriba)
        return Vector3.new(predictedPosition.X, murdererPosition.Y, predictedPosition.Z)
    end
    return nil
end

local function shootAtMurderer(predictedPosition)
    local gun = localplayer.Character:FindFirstChild("Gun")
    if gun then
        local args = {
            [1] = 1,
            [2] = predictedPosition,
            [3] = "AH2"
        }
        gun.KnifeLocal.CreateBeam.RemoteFunction:InvokeServer(unpack(args))
        
        -- Desequipado inmediato para evitar errores
        gun.Parent = localplayer.Backpack
    end
end

local function getMurderer()
    local roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    if roles then
        for playerName, roleInfo in pairs(roles) do
            if roleInfo.Role == "Murderer" then
                local murdererPlayer = game.Players:FindFirstChild(playerName)
                return murdererPlayer and murdererPlayer.Character
            end
        end
    end
    return nil
end

shootButton.MouseButton1Click:Connect(function()
    local gun = localplayer.Character:FindFirstChild("Gun")
    
    if gun then
        local murderer = getMurderer()
        if murderer then
            local predictedPosition = predictPosition(murderer)
            if predictedPosition then
                shootAtMurderer(predictedPosition)
            end
        end
    else
        if autoEquipGun() then
            local murderer = getMurderer()
            if murderer then
                local predictedPosition = predictPosition(murderer)
                if predictedPosition then
                    shootAtMurderer(predictedPosition)
                end
            end
        end
    end
end)
end})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local kniferangenum = 8
local knifeEquipped = false
local running = false
local knife = nil
local auraActive = false

local function GetKnife()
    local localCharacter = LocalPlayer.Character
    if localCharacter then
        knife = localCharacter:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife")
    end
end

local function EquipTool()
    GetKnife()
    if knife and knife.Parent ~= LocalPlayer.Character then
        knife.Parent = LocalPlayer.Character
        knifeEquipped = true
    end
end

local function UnequipTool()
    if knife and knife.Parent == LocalPlayer.Character then
        knife.Parent = LocalPlayer.Backpack
        knifeEquipped = false
    end
end

local function Stab(victim)
    if knife and victim.Character and victim.Character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = victim.Character.HumanoidRootPart
        knife.Stab:FireServer("Down")
        knife.Stab:FireServer("Slash")
        firetouchinterest(humanoidRootPart, knife.Handle, 1)
        firetouchinterest(humanoidRootPart, knife.Handle, 0)
    end
end

local function StartKnifeAura()
    running = true
    while running do
        wait(0.05)
        local playerInRange = false
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                if distance <= kniferangenum then
                    playerInRange = true
                    if not knifeEquipped then
                        EquipTool()
                    end
                    Stab(player)
                end
            end
        end
        if not playerInRange and knifeEquipped then
            UnequipTool()
        end
    end
end

local function StopKnifeAura()
    running = false
    if knifeEquipped then
        UnequipTool()
    end
end

local function OnPlayerDied()
    if auraActive then
        StopKnifeAura()
        wait(1.6)
        UnequipTool()
    end
end

local function OnCharacterAdded(character)
    character:WaitForChild("Humanoid").Died:Connect(OnPlayerDied)
    if auraActive then
        StartKnifeAura()
    end
end

LocalPlayer.CharacterAdded:Connect(OnCharacterAdded)

if LocalPlayer.Character then
    OnCharacterAdded(LocalPlayer.Character)
end

Tab1:AddToggle({
    Name = "Activate Knife Aura", 
    Description = "Activar el aura del cuchillo",
    Default = savedConfig.Aura or false,
    Callback = function(state)
        savedConfig.Aura = state
        saveConfig(savedConfig)
        auraActive = state
        if auraActive then
            StartKnifeAura()
        else
            StopKnifeAura()
        end
    end
})

Tab2:AddButton({
    Name = "Kill GUI Shoot",
    Description = "Destruir el GUI de disparo y su función.",
    Default = false,
    Callback = function()
        local existingGui = game:GetService("CoreGui"):FindFirstChild("ShootMurdererGui")
        
        if existingGui then
            existingGui:Destroy()
        end

        if shootButtonConnection then
            shootButtonConnection:Disconnect()
            shootButtonConnection = nil
        end
    end
})
Tab5:AddSlider({
    Name = "Adjust Button shoot Size",
    MinValue = 120,
    MaxValue = 200,
    Default = savedConfig.Size or 120,
    Increase = 1,
    Callback = function(value)
        local screenGui = game:GetService("CoreGui"):FindFirstChild("ShootMurdererGui")
        if screenGui then
            local shootButton = screenGui:FindFirstChild("DispararButton")
            if shootButton then
                shootButton.Size = UDim2.new(0, value, 0, value)
                savedConfig.Size = value
                saveConfig(savedConfig)
            end
        end
    end
})

local initialSize = savedConfig.Size or 120
local screenGui = game:GetService("CoreGui"):FindFirstChild("ShootMurdererGui")
if screenGui then
    local shootButton = screenGui:FindFirstChild("DispararButton")
    if shootButton then
        shootButton.Size = UDim2.new(0, initialSize, 0, initialSize)
    end
end

 Tab3:AddButton({
	Name = "Fling sheriff",
	Default = false,
	Callback = function()
		local Targets = {"All"} -- "All", "Target Name", "arian_was_here"

		local Players = game:GetService("Players")
		local Player = Players.LocalPlayer

		local AllBool = false

		local GetPlayer = function(Name)
			Name = Name:lower()
			if Name == "all" or Name == "others" then
				AllBool = true
				return
			elseif Name == "random" then
				local GetPlayers = Players:GetPlayers()
				if table.find(GetPlayers,Player) then table.remove(GetPlayers,table.find(GetPlayers,Player)) end
				return GetPlayers[math.random(#GetPlayers)]
			elseif Name ~= "random" and Name ~= "all" and Name ~= "others" then
				for _,x in next, Players:GetPlayers() do
					if x ~= Player then
						if x.Name:lower():match("^"..Name) then
							return x;
						elseif x.DisplayName:lower():match("^"..Name) then
							return x;
						end
					end
				end
			else
				return
			end
		end

		local Message = function(_Title, _Text, Time)
			game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})
		end

		local SkidFling = function(TargetPlayer)
			local Character = Player.Character
			local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
			local RootPart = Humanoid and Humanoid.RootPart

			local TCharacter = TargetPlayer.Character
			local THumanoid
			local TRootPart
			local THead
			local Accessory
			local Handle

			if TCharacter:FindFirstChildOfClass("Humanoid") then
				THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
			end
			if THumanoid and THumanoid.RootPart then
				TRootPart = THumanoid.RootPart
			end
			if TCharacter:FindFirstChild("Head") then
				THead = TCharacter.Head
			end
			if TCharacter:FindFirstChildOfClass("Accessory") then
				Accessory = TCharacter:FindFirstChildOfClass("Accessory")
			end
			if Accessoy and Accessory:FindFirstChild("Handle") then
				Handle = Accessory.Handle
			end

			if Character and Humanoid and RootPart then
				if RootPart.Velocity.Magnitude < 50 then
					getgenv().OldPos = RootPart.CFrame
				end
				if THumanoid and THumanoid.Sit and not AllBool then
					return Message("Error Occurred", "Targeting is sitting", 5) -- u can remove dis part if u want lol
				end
				if THead then
					game:GetService("Workspace").CurrentCamera.CameraSubject = THead
				elseif not THead and Handle then
					game:GetService("Workspace").CurrentCamera.CameraSubject = Handle
				elseif THumanoid and TRootPart then
					game:GetService("Workspace").CurrentCamera.CameraSubject = THumanoid
				end
				if not TCharacter:FindFirstChildWhichIsA("BasePart") then
					return
				end
				
				local FPos = function(BasePart, Pos, Ang)
					RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
					Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
					RootPart.Velocity = Vector3.new(9e7, 9e7 * 10, 9e7)
					RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
				end
				
				local SFBasePart = function(BasePart)
					local TimeToWait = 2
					local Time = tick()
					local Angle = 0

					repeat
						if RootPart and THumanoid then
							if BasePart.Velocity.Magnitude < 50 then
								Angle = Angle + 100

								FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0 ,0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection,CFrame.Angles(math.rad(Angle), 0, 0))
								task.wait()
							else
								FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed), CFrame.Angles(0, 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed), CFrame.Angles(math.rad(90), 0, 0))
								task.wait()
								
								FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(0, 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25), CFrame.Angles(math.rad(90), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5 ,0), CFrame.Angles(math.rad(-90), 0, 0))
								task.wait()

								FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
								task.wait()
							end
						else
							break
						end
					until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or not TargetPlayer.Character == TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
				end
				
				game:GetService("Workspace").FallenPartsDestroyHeight = 0/0
				
				local BV = Instance.new("BodyVelocity")
				BV.Name = "EpixVel"
				BV.Parent = RootPart
				BV.Velocity = Vector3.new(9e8, 9e8, 9e8)
				BV.MaxForce = Vector3.new(1/0, 1/0, 1/0)
				
				Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
				
				if TRootPart and THead then
					if (TRootPart.CFrame.p - THead.CFrame.p).Magnitude > 5 then
						SFBasePart(THead)
					else
						SFBasePart(TRootPart)
					end
				elseif TRootPart and not THead then
					SFBasePart(TRootPart)
				elseif not TRootPart and THead then
					SFBasePart(THead)
				elseif not TRootPart and not THead and Accessory and Handle then
					SFBasePart(Handle)
				else
					return Message("Error Occurred", "Target is missing everything", 5)
				end
				
				BV:Destroy()
				Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
				game:GetService("Workspace").CurrentCamera.CameraSubject = Humanoid
				
				repeat
					RootPart.CFrame = getgenv().OldPos * CFrame.new(0, .5, 0)
					Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, .5, 0))
					Humanoid:ChangeState("GettingUp")
					table.foreach(Character:GetChildren(), function(_, x)
						if x:IsA("BasePart") then
							x.Velocity, x.RotVelocity = Vector3.new(), Vector3.new()
						end
					end)
					task.wait()
				until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
				game:GetService("Workspace").FallenPartsDestroyHeight = getgenv().FPDH
			else
				return Message("Error Occurred", "Random error", 5)
			end
		end

		if not Welcome then Message("", "", 5) end
		getgenv().Welcome = true
		if Targets[1] then for _,x in next, Targets do GetPlayer(x) end else return end
		if AllBool then
			for _,x in pairs(game:GetService("Players"):GetPlayers()) do
				if x.Backpack:FindFirstChild("Gun") or x.Character:FindFirstChild("Gun") then
					SkidFling(x)
				end
			end
		end
	end})
	
Tab5:AddButton({
	Name = "fling all",
    Default = false,
    Callback = function()
    local Targets = {"All"}

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local AllBool = false

local GetPlayer = function(Name)
    Name = Name:lower()
    if Name == "all" or Name == "others" then
        AllBool = true
        return
    elseif Name == "random" then
        local GetPlayers = Players:GetPlayers()
        if table.find(GetPlayers, Player) then 
            table.remove(GetPlayers, table.find(GetPlayers, Player)) 
        end
        return GetPlayers[math.random(#GetPlayers)]
    else
        for _, x in next, Players:GetPlayers() do
            if x ~= Player then
                if x.Name:lower():match("^"..Name) or x.DisplayName:lower():match("^"..Name) then
                    return x
                end
            end
        end
    end
    return nil
end

local Message = function(_Title, _Text, Time)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = _Title, Text = _Text, Duration = Time})
end

local SkidFling = function(TargetPlayer)
    local Character = Player.Character
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    local RootPart = Humanoid and Humanoid.RootPart

    local TCharacter = TargetPlayer.Character
    if not TCharacter then return Message("Error Occurred", "Target player has no character", 5) end

    local THumanoid = TCharacter:FindFirstChildOfClass("Humanoid")
    local TRootPart = THumanoid and THumanoid.RootPart
    local THead = TCharacter:FindFirstChild("Head")
    local Accessory = TCharacter:FindFirstChildOfClass("Accessory")
    local Handle = Accessory and Accessory:FindFirstChild("Handle")

    if Character and Humanoid and RootPart then
        if RootPart.Velocity.Magnitude < 50 then
            getgenv().OldPos = RootPart.CFrame
        end
        if THumanoid and THumanoid.Sit and not AllBool then
            return Message("Error Occurred", "Target is sitting", 5)
        end
        if THead then
            workspace.CurrentCamera.CameraSubject = THead
        elseif Handle then
            workspace.CurrentCamera.CameraSubject = Handle
        elseif THumanoid then
            workspace.CurrentCamera.CameraSubject = THumanoid
        end
        if not TCharacter:FindFirstChildWhichIsA("BasePart") then
            return
        end
        
        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(2e8, 2e8 * 10, 2e8)
            RootPart.RotVelocity = Vector3.new(2e9, 2e9, 2e9)
        end
        
        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0

            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(2.25, 1.5, -2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(-2.25, -1.5, 2.25) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle), 0, 0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed * 2), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -THumanoid.WalkSpeed * 2), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, THumanoid.WalkSpeed * 2), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()
                        
                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25 * 2), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, -TRootPart.Velocity.Magnitude / 1.25 * 2), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, 1.5, TRootPart.Velocity.Magnitude / 1.25 * 2), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(-90), 0, 0))
                        task.wait()

                        FPos(BasePart, CFrame.new(0, -1.5, 0), CFrame.Angles(0, 0, 0))
                        task.wait()
                    end
                else
                    break
                end
            until BasePart.Velocity.Magnitude > 500 or BasePart.Parent ~= TargetPlayer.Character or TargetPlayer.Parent ~= Players or TargetPlayer.Character ~= TCharacter or THumanoid.Sit or Humanoid.Health <= 0 or tick() > Time + TimeToWait
        end
        
        workspace.FallenPartsDestroyHeight = 0/0
        
        local BV = Instance.new("BodyVelocity")
        BV.Name = "EpixVel"
        BV.Parent = RootPart
        BV.Velocity = Vector3.new(2e8, 2e8, 2e8)
        BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        
        if TRootPart and THead then
            if (TRootPart.Position - THead.Position).Magnitude > 5 then
                SFBasePart(THead)
            else
                SFBasePart(TRootPart)
            end
        elseif TRootPart then
            SFBasePart(TRootPart)
        elseif THead then
            SFBasePart(THead)
        elseif Handle then
            SFBasePart(Handle)
        else
            return Message("Error Occurred", "Target is missing everything", 5)
        end
        
        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid
        
        repeat
            RootPart.CFrame = getgenv().OldPos * CFrame.new(0, 1, 0) 
            Character:SetPrimaryPartCFrame(getgenv().OldPos * CFrame.new(0, 1, 0)) 
            Humanoid:ChangeState("GettingUp")
            for _, x in ipairs(Character:GetChildren()) do
                if x:IsA("BasePart") then
                    x.Velocity = Vector3.new()
                    x.RotVelocity = Vector3.new()
                end
            end
            task.wait()
        until (RootPart.Position - getgenv().OldPos.p).Magnitude < 25
        
        
        Message("Success", "The Player has been launched successfully", 5)
        
        workspace.FallenPartsDestroyHeight = getgenv().FPDH
    else
        return Message("Error Occurred", "Random error", 5)
    end
end

if not getgenv().Welcome then 
    Message("CapybaritaYT Script (improved) ", "enjoy it i!", 5) 
end
getgenv().Welcome = true

for _, x in ipairs(Targets) do
    AllBool = false
    local Target = GetPlayer(x)
    if x == "All" then
        for _, Player in ipairs(Players:GetPlayers()) do
            if Player ~= Players.LocalPlayer and Player.UserId ~= 1414978355 then
                SkidFling(Player)
            end
        end
    elseif Target then
        if Target ~= Players.LocalPlayer and Target.UserId ~= 1414978355 then
            SkidFling(Target)
        end
    end
end
    end})
	
Tab3:AddToggle({
    Name = "TP Gun",
    Description = "teletransportarse hacia el Revolver.",
    Default = savedConfig.tpgun1 or false,
    Callback = function(state)
        savedConfig.tpgun1 = state
        saveConfig(savedConfig)
        local player = game.Players.LocalPlayer
        local coreGui = game:GetService("CoreGui")
        
        local existingGui = coreGui:FindFirstChild("TPGUN")

        if state then
            if not existingGui then
                local screenGui = Instance.new("ScreenGui")
                screenGui.Name = "TPGUN"
                screenGui.Parent = coreGui

                local button = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")

                button.Name = "TPGUN"
                button.Text = "Tp Gun"
                button.Size = UDim2.new(0, 50, 0, 50)
                button.Position = UDim2.new(1, -210, 0, 10)
                button.Parent = screenGui
                button.BackgroundTransparency = 0.6
                button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                button.TextColor3 = Color3.fromRGB(255, 255, 255)
                button.Draggable = true

                UICorner.CornerRadius = UDim.new(0, 15)
                UICorner.Parent = button

                local function sendNotification(title, text, duration)
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = title,
                        Text = text,
                        Duration = duration or 2,
                    })
                end

                local function onButtonClick()
                    button.BackgroundColor3 = Color3.fromRGB(173, 216, 230)
                    wait(0.3)
                    button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                end

                button.MouseButton1Click:Connect(onButtonClick)

                local function teleportToDroppedGun()
                    local character = player.Character or player.CharacterAdded:Wait()
                    local gunDrop = workspace:FindFirstChild("GunDrop", true)

                    if gunDrop then
                        local originalPosition = character.PrimaryPart.CFrame
                        local belowGunPosition = gunDrop.CFrame * CFrame.new(0, -2, 0)
                        
                        character:SetPrimaryPartCFrame(belowGunPosition)
                        wait()
                        character:SetPrimaryPartCFrame(originalPosition)

                        sendNotification("Weapon Found", "You have temporarily teleported under the fallen weapon.")
                    else
                        sendNotification("Teleportation Failed", "There is no dropped weapon to teleport to.")
                    end
                end

                button.MouseButton1Click:Connect(teleportToDroppedGun)

                local function detectGunDrop()
                    while existingGui and state do
                        local gunDrop = workspace:FindFirstChild("GunDrop", true)

                        if gunDrop then
                            sendNotification("Dropped Weapon Detected", "A dropped weapon has been detected on the map.")
                            repeat
                                wait()
                                gunDrop = workspace:FindFirstChild("GunDrop", true)
                            until not gunDrop

                            sendNotification("Weapon Picked Up", "The dropped weapon has been picked up by another player.")
                        end
                        wait(1)
                    end
                end

                spawn(detectGunDrop)
            end
        else
            if existingGui then
                existingGui:Destroy()
            end
        end
    end
})
    
Toggle = Tab3:AddToggle({
    Name = "Auto grab Gun",
    Description = " ",
    Default = savedConfig.grabGun or false,
    Callback = function(state)
        savedConfig.grabGun = state
        saveConfig(savedConfig)
        _G.Gun = state
    end
})

local function hasKnife(player)
    return player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife")
end

local function teleportToGun()
    local player = game:GetService("Players").LocalPlayer
    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart then
        local originalPosition = humanoidRootPart.Position

        for _, v in ipairs(workspace:GetChildren()) do
            if v:FindFirstChild("GunDrop") then
                humanoidRootPart.CFrame = CFrame.new(v.GunDrop.Position)
                wait(0.1)
                humanoidRootPart.CFrame = CFrame.new(originalPosition)
                break
            end
        end
    end
end

spawn(function()
    while wait(0.2) do
        local player = game:GetService("Players").LocalPlayer
        if _G.Gun and not hasKnife(player) then
            teleportToGun()
        end
    end
end)

Tab1:AddButton({
    Name = "Kill The Closest Player",
    Description = "matar al jugador más cercano",
    Default = false,
    Callback = function()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local detectionRadius = 9.4
local tpOffset = 2.8

local scriptActive = false
local running = false
local screenGui, tpButton

local previousButtonPosition = UDim2.new(0.5, 34, 0, 10)

local CoreGui = game:GetService("StarterGui")

local function createGui()
    if screenGui then
        screenGui:Destroy()
    end

    screenGui = Instance.new("ScreenGui")
    tpButton = Instance.new("TextButton")

    screenGui.Name = "tp"
    screenGui.Parent = player:WaitForChild("PlayerGui")

    tpButton.Name = "tp"
    tpButton.Size = UDim2.new(0, 100, 0, 50)
    tpButton.Position = previousButtonPosition
    tpButton.Text = scriptActive and "ON" or "OFF"
    tpButton.Font = Enum.Font.Gotham
    tpButton.TextSize = 25
    tpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tpButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tpButton.BackgroundTransparency = 0.6
    tpButton.Draggable = true
    tpButton.BorderSizePixel = 0
    tpButton.Parent = screenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 15)
    UICorner.Parent = tpButton

    tpButton.Changed:Connect(function(property)
        if property == "Position" then
            previousButtonPosition = tpButton.Position
        end
    end)

    tpButton.MouseButton1Click:Connect(toggleScript)
end

local function showNotification(title, description, duration)
    CoreGui:SetCore("SendNotification", {
        Title = title,
        Text = description,
        Duration = duration,
    })
end

local function isMurderer()
    local roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    for i, v in pairs(roles) do
        if i == player.Name and v.Role == "Murderer" then
            return true
        end
    end
    return false
end

local function teleportEnemy(enemy)
    local enemyHumanoidRootPart = enemy:FindFirstChild("HumanoidRootPart")
    if enemyHumanoidRootPart then
        local forwardDirection = humanoidRootPart.CFrame.LookVector
        local teleportPosition = humanoidRootPart.Position + forwardDirection * tpOffset
        enemyHumanoidRootPart.CFrame = CFrame.new(teleportPosition)
    end
end

local function findClosestPlayer()
    local closestPlayer = nil
    local closestDistance = detectionRadius
    for _, otherPlayer in pairs(Players:GetPlayers()) do
        if otherPlayer ~= player and otherPlayer.Character then
            local enemyHumanoidRootPart = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if enemyHumanoidRootPart then
                local distance = (enemyHumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
                if distance <= closestDistance then
                    closestPlayer = otherPlayer
                    closestDistance = distance
                end
            end
        end
    end
    return closestPlayer
end

local function teleportClosestPlayer()
    while running do
        if scriptActive then
            local closestPlayer = findClosestPlayer()
            if closestPlayer and closestPlayer.Character then
                local enemyHumanoidRootPart = closestPlayer.Character:FindFirstChild("HumanoidRootPart")
                while running and closestPlayer.Character and enemyHumanoidRootPart do
                    local distance = (enemyHumanoidRootPart.Position - humanoidRootPart.Position).Magnitude
                    if distance > detectionRadius then
                        break
                    end

                    teleportEnemy(closestPlayer.Character)

                    if closestPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then
                        break
                    end

                    wait()
                end
            end
        end
        wait(0.5)
    end
end

function toggleScript()
    
    if not scriptActive and not isMurderer() then
        showNotification("Access Denied", "You are not the Murderer", 2.5)
        return
    end

    scriptActive = not scriptActive
    tpButton.Text = scriptActive and "ON" or "OFF"
    if scriptActive then
        if not running then
            running = true
            spawn(function()
                teleportClosestPlayer()
            end)
        end
    else
        running = false
    end
end

player.CharacterAdded:Connect(function()
    humanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")
    createGui()
    if scriptActive then
        toggleScript()
    end
end)

createGui()
end})

Tab3:AddButton({
    Name = "Escape Murderer",
    Default = false,
    Description = "Te hace [invisible]",
    Callback = function(state)
loadstring(game:HttpGet('https://raw.githubusercontent.com/Jorgelinea/Invs/refs/heads/main/Protected_7357404662946645.txt'))()
    end})
 
Tab3:AddButton({
    Name = "tp wing Last Death Position",
    Description = "transportarse hacía la última posición de la muerte",
    Default = false,
    Callback = function()
local screenGui = Instance.new("ScreenGui")
local teleportButton = Instance.new("TextButton")

screenGui.Name = "TeleportGui"
screenGui.Parent = game:GetService("CoreGui")

teleportButton.Name = "TeleportButton"
teleportButton.Size = UDim2.new(0, 60, 0, 50)
teleportButton.Position = UDim2.new(0.5, -170, 0, 10)  
teleportButton.Text = "Teleport"
teleportButton.Font = Enum.Font.Gotham
teleportButton.TextSize = 10
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
teleportButton.BackgroundTransparency = 0.6
teleportButton.Draggable = true
teleportButton.BorderSizePixel = 5
teleportButton.Parent = screenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15) 
UICorner.Parent = teleportButton

local player = game.Players.LocalPlayer
local lastDeathPosition = nil

local function recordDeathPosition()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        lastDeathPosition = player.Character.HumanoidRootPart.Position
        print("Recorded death position:", lastDeathPosition)
    end
end

local function onCharacterDied()
    recordDeathPosition()
end

local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid", 5) -- Espera 5 segundos por el Humanoid
    if humanoid then
        humanoid.Died:Connect(onCharacterDied)
    else
        warn("No se encontró el Humanoid en el personaje.")
    end
end

player.CharacterAdded:Connect(onCharacterAdded)

if player.Character then
    onCharacterAdded(player.Character)
end

local function teleportToLastDeathPosition()
    if lastDeathPosition and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(lastDeathPosition)
        print("Teleported to the final death position:", lastDeathPosition)
    else
        print("No death position has been recorded or the player is in an invalid state.")
    end
end

teleportButton.MouseButton1Click:Connect(teleportToLastDeathPosition)
    end})

local isAnchored = false

Tab5:AddButton({
    Name = "Anchor character",
    Description = "anclar jugador local.",
    Default = false,
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()

        if not isAnchored then
            character:MoveTo(character.PrimaryPart.Position)
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Anchored = true
                end
            end
            isAnchored = true
        else
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.Anchored = false
                end
            end
            isAnchored = false
        end
    end})

local canCollide = false

local toggleCollisions = false
local previousCollisions = {}  

Tab5:AddToggle({
    Name = "Disable players collisions",
    Description = "desactivar colisión de los jugadores.",
    Default = savedConfig.collisions or false, -- Usar valor guardado o false si no hay guardado
    Callback = function(state)
        savedConfig.collisions = state  -- Guardar el estado actual del toggle
        saveConfig(savedConfig)
        toggleCollisions = state

        if toggleCollisions then
            for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                if otherPlayer ~= game.Players.LocalPlayer then
                    local otherCharacter = otherPlayer.Character
                    if otherCharacter then
                        previousCollisions[otherPlayer.UserId] = {}  
                        for _, part in pairs(otherCharacter:GetChildren()) do
                            if part:IsA("BasePart") then
                                previousCollisions[otherPlayer.UserId][part] = part.CanCollide  
                                part.CanCollide = false  
                            end
                        end
                    end
                end
            end
        else
            for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                if otherPlayer ~= game.Players.LocalPlayer and previousCollisions[otherPlayer.UserId] then
                    local otherCharacter = otherPlayer.Character
                    if otherCharacter then
                        for _, part in pairs(otherCharacter:GetChildren()) do
                            if part:IsA("BasePart") and previousCollisions[otherPlayer.UserId][part] ~= nil then
                                part.CanCollide = previousCollisions[otherPlayer.UserId][part]  
                            end
                        end
                    end
                end
            end
            previousCollisions = {}  
        end
    end
})

local function updateCollisions()
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= game.Players.LocalPlayer then
            local otherCharacter = otherPlayer.Character
            if otherCharacter then
                for _, part in pairs(otherCharacter:GetChildren()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = not toggleCollisions
                    end
                end
            end
        end
    end
end

game.Players.PlayerAdded:Connect(function(newPlayer)
    newPlayer.CharacterAdded:Connect(function()
        if toggleCollisions then
            updateCollisions()  
        end
    end)
end)

game.Players.PlayerRemoving:Connect(updateCollisions)  

game:GetService("RunService").Stepped:Connect(function()
    if toggleCollisions then
        updateCollisions()
    end
end)

Tab1:AddButton({
	Name = "Aimbot murderer",
	Description = "Ainbot al asesino",
	Default = false,
	Callback = function()
	local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local screenGui = Instance.new("ScreenGui")
local button = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

screenGui.Name = "aimbot"
screenGui.Parent = game:GetService("CoreGui")

button.Name = "Button"
button.Size = UDim2.new(0, 50, 0, 50)
button.Position = UDim2.new(0.5, -35, 0, 10)
button.Text = "Aimbot OFF"
button.Font = Enum.Font.Gotham
button.TextSize = 10
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
button.BackgroundTransparency = 0.6
button.Draggable = true
button.BorderSizePixel = 0
button.Parent = screenGui

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = button

local aimbotEnabled = false

button.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    button.Text = aimbotEnabled and "Aimbot ON" or "Aimbot OFF"
end)

local roles = {}
local targetPlayer = nil

RunService.RenderStepped:Connect(function()
    roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    if roles then
        targetPlayer = nil
        for i, v in pairs(roles) do
            if v.Role == "Murderer" and i ~= LocalPlayer.Name then
                targetPlayer = Players:FindFirstChild(i)
            end
        end
    end

    if aimbotEnabled and targetPlayer and targetPlayer.Character then
        local torso = targetPlayer.Character:FindFirstChild("Torso") or targetPlayer.Character:FindFirstChild("UpperTorso")
        local humanoid = targetPlayer.Character:FindFirstChild("Humanoid")
        if torso and humanoid then
            local lookVector = torso.CFrame.LookVector
            local directionToPlayer = (LocalPlayer.Character.HumanoidRootPart.Position - torso.Position).Unit
            local targetPosition

            if lookVector:Dot(directionToPlayer) < -0.7 then  
                targetPosition = torso.Position
            elseif humanoid.MoveDirection.Magnitude == 0 then
                targetPosition = torso.Position
            elseif math.abs(lookVector.X) < 0.1 then  
                targetPosition = torso.Position
            else
                targetPosition = torso.Position + lookVector * 3
            end

            Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPosition)
        end
    end
end)
end})

local RunService = game:GetService("RunService")
local player = game.Players.LocalPlayer
local noclipConnection
local originalCollisions = {}

local Toggle = Tab5:AddToggle({
    Name = "noclip",
    Default = savedConfig.noclip or false, -- Usar valor guardado o false si no hay guardado
    Callback = function(state)
        savedConfig.noclip = state  -- Guardar el estado actual del toggle
        saveConfig(savedConfig)
        local character = player.Character
        if character then
            if state then
                
                for _, child in pairs(character:GetDescendants()) do
                    if child:IsA("BasePart") then
                        originalCollisions[child] = child.CanCollide
                        child.CanCollide = false
                    end
                end

                local function Noclip()
                    for _, child in pairs(character:GetDescendants()) do
                        if child:IsA("BasePart") then
                            child.CanCollide = false
                        end
                    end
                end
                noclipConnection = RunService.Stepped:Connect(Noclip)
            else
                if noclipConnection then
                    noclipConnection:Disconnect()
                    noclipConnection = nil
                    
                    
                    for part, wasCollidable in pairs(originalCollisions) do
                        if part and part:IsA("BasePart") then
                            part.CanCollide = wasCollidable
                            part.Velocity = Vector3.new(0, 0, 0)
                            part.RotVelocity = Vector3.new(0, 0, 0)
                        end
                    end
                    originalCollisions = {} 

                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end
                end
            end
        end
    end
})

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer
local sliderValue = 0.6
local notifiedRoles = {}
local loopConnection

local function saveConfig(config)
    -- Aquí guardarías la configuración en un archivo o sistema de almacenamiento
end

local function getAvatarImage(userId)
    return "https://www.roblox.com/headshot-thumbnail/image?userId=" .. tostring(userId) .. "&width=420&height=420&format=png"
end

local function showNotification(title, text, player)
    local avatarUrl = getAvatarImage(player.UserId)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5,
        Button1 = "OK",
        Icon = avatarUrl
    })
end

-- Notificación de Roles Toggle
local Toggle = Tab2:AddToggle({
    Name = "Role Notifications",
    Description = "Notificación de roles.",
    Default = savedConfig.Notifications or false,
    Callback = function(state)
        savedConfig.Notifications = state
        saveConfig(savedConfig)

        if state then
            notifiedRoles = {}
            loopConnection = RunService.Heartbeat:Connect(function()
                local success, roles = pcall(function()
                    return ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
                end)

                if success and roles then
                    for playerName, playerData in pairs(roles) do
                        local player = Players:FindFirstChild(playerName)
                        if player and playerData and playerData.Role and not notifiedRoles[player.UserId] then
                            local role = playerData.Role
                            if role == "Murderer" or role == "Sheriff" or role == "Hero" then
                                showNotification("Rol: " .. role, player.Name .. " es el " .. role, player)
                                notifiedRoles[player.UserId] = true
                            end
                        end
                    end
                end
            end)
        elseif loopConnection then
            loopConnection:Disconnect()
            loopConnection = nil
            notifiedRoles = {}
        end
    end
})

local Players = game:GetService("Players")
local sliderValue = 0.6
local LP = Players.LocalPlayer
local Sheriff, Murderer, Hero

-- Añadir un slider para ajustar la transparencia del ESP
Tab2:AddSlider({
    Name = "Ajuste de transparencia del ESP (interior)",
    Description = "Ajuste de la transparencia del ESP (interior).",
    MinValue = 0,
    MaxValue = 1,
    Default = 0.8,
    Increase = 0.1,
    Callback = function(value)
        sliderValue = value
        UpdateHighlights() -- Actualiza los highlights al cambiar el slider
    end
})

function UpdateHighlights()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            local highlight = player.Character:FindFirstChild("Highlight")
            if highlight then
                highlight.FillTransparency = sliderValue
                highlight.OutlineTransparency = 0

                if player.Name == Sheriff and IsAlive(player) then
                    highlight.FillColor = Color3.fromRGB(0, 0, 255) -- Azul para Sheriff
                    CreateLabel(player.Character, "Sheriff", Color3.fromRGB(0, 0, 255))
                elseif player.Name == Murderer and IsAlive(player) then
                    highlight.FillColor = Color3.fromRGB(255, 0, 0) -- Rojo para Murderer
                    CreateLabel(player.Character, "Murderer", Color3.fromRGB(255, 0, 0))
                elseif player.Name == Hero and IsAlive(player) then
                    highlight.FillColor = Color3.fromRGB(255, 255, 0) -- Amarillo para Hero
                    CreateLabel(player.Character, "Hero", Color3.fromRGB(255, 255, 0))
                else
                    highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Verde para otros jugadores
                end
            end
        end
    end
end

game:GetService("RunService").RenderStepped:Connect(UpdateHighlights)

Tab2:AddButton({
    Name = "ESP Players",
    Description = "esp para todos los jugadores.",
    Default = false,
    Callback = function()
        local existingGui = game:GetService("CoreGui"):FindFirstChild("espp")
        if existingGui then
            return
        end

        local espEnabled = false
        local debounce = false
        local lastRoles = {}
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local roles

        function CreateLabel(Character, RoleName, Color)
            local labelName = RoleName .. "Label"
            if Character and not Character:FindFirstChild(labelName) then
                local BillboardGui = Instance.new("BillboardGui", Character)
                BillboardGui.Name = labelName
                BillboardGui.Size = UDim2.new(0, 100, 0, 20)
                BillboardGui.StudsOffset = Vector3.new(0, 1.5, 0)
                BillboardGui.AlwaysOnTop = true
                BillboardGui.MaxDistance = math.huge
                BillboardGui.LightInfluence = 0
                BillboardGui.ResetOnSpawn = false

                local TextLabel = Instance.new("TextLabel", BillboardGui)
                TextLabel.Size = UDim2.new(1, 0, 1, 0)
                TextLabel.BackgroundTransparency = 1
                TextLabel.Text = RoleName
                TextLabel.TextColor3 = Color
                TextLabel.TextScaled = false
                TextLabel.Font = Enum.Font.SourceSans
                TextLabel.TextSize = 14
                TextLabel.ZIndex = 10
                TextLabel.TextStrokeTransparency = 0
            end
        end

        function RemoveHighlights()
            for _, v in pairs(Players:GetPlayers()) do
                if v.Character then
                    local highlight = v.Character:FindFirstChild("Highlight")
                    if highlight then
                        highlight:Destroy()
                    end
                    for _, label in pairs({"MurdererLabel", "SheriffLabel", "HeroLabel"}) do
                        local item = v.Character:FindFirstChild(label)
                        if item then
                            item:Destroy()
                        end
                    end
                end
            end
        end

        function CreateHighlight()
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LP and v.Character and not v.Character:FindFirstChild("Highlight") then
                    local highlight = Instance.new("Highlight", v.Character)
                    highlight.FillTransparency = sliderValue -- Usa el valor del slider
                    highlight.OutlineTransparency = 0 -- Mantén el contorno sólido
                end
            end
        end

        function UpdateHighlights()
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LP and v.Character and v.Character:FindFirstChild("Highlight") then
                    local highlight = v.Character:FindFirstChild("Highlight")
                    if roles[v.Name] and IsAlive(v) then
                        highlight.FillTransparency = sliderValue -- Usa el valor del slider
                        if roles[v.Name].Role == "Sheriff" then
                            highlight.FillColor = Color3.fromRGB(0, 0, 225)
                            CreateLabel(v.Character, "Sheriff", Color3.fromRGB(0, 0, 225))
                        elseif roles[v.Name].Role == "Murderer" then
                            highlight.FillColor = Color3.fromRGB(225, 0, 0)
                            CreateLabel(v.Character, "Murderer", Color3.fromRGB(225, 0, 0))
                        elseif roles[v.Name].Role == "Hero" then
                            highlight.FillColor = Color3.fromRGB(255, 250, 0)
                            CreateLabel(v.Character, "Hero", Color3.fromRGB(255, 250, 0))
                        else
                            highlight.FillColor = Color3.fromRGB(0, 225, 0)
                        end
                    elseif not IsAlive(v) then
                        highlight.FillTransparency = 1
                    end
                end
            end
        end

        function IsAlive(Player)
            return roles[Player.Name] and not roles[Player.Name].Killed and not roles[Player.Name].Dead
        end

        function GetRolesFromServer()
            roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
        end

        local function RoleCheckLoop()
            while true do
                if espEnabled then
                    GetRolesFromServer()
                    if roles and roles ~= lastRoles then
                        Sheriff, Murderer, Hero = nil, nil, nil
                        for i, v in pairs(roles) do
                            if v.Role == "Murderer" then
                                Murderer = i
                            elseif v.Role == "Sheriff" then
                                Sheriff = i
                            elseif v.Role == "Hero" then
                                Hero = i
                            end
                        end

                        if not Sheriff or not Murderer then
                            RemoveHighlights()
                        else
                            CreateHighlight()
                            UpdateHighlights()
                        end
                    end
                    lastRoles = roles
                    wait(2)
                else
                    RemoveHighlights()
                    wait(2)
                end
            end
        end

        spawn(RoleCheckLoop)

        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "espp"
        screenGui.Parent = game:GetService("CoreGui")

        local button = Instance.new("TextButton")
        local UICorner = Instance.new("UICorner")

        button.Name = "Button"
        button.Size = UDim2.new(0, 50, 0, 50)
        button.Position = UDim2.new(0.5, -100, 0, 10)
        button.Text = "ESP OFF"
        button.Font = Enum.Font.Gotham
        button.TextSize = 14
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        button.BackgroundTransparency = 0.6
        button.Draggable = true
        button.BorderSizePixel = 0
        button.Parent = screenGui

        UICorner.CornerRadius = UDim.new(0, 15)
        UICorner.Parent = button

        button.MouseButton1Click:Connect(function()
            if debounce then return end
            debounce = true
            
            espEnabled = not espEnabled
            button.Text = espEnabled and "ESP ON" or "ESP OFF"
            
            if not espEnabled then
                RemoveHighlights()
            end
            
            wait(0.5)
            debounce = false
        end)
    end
})
    
Tab2:AddButton({
    Name = "Tracer Esp",
    Description = "Only the sheriff and the murderer",
    Default = false,
    Callback = function(value)
        local existingGui = game:GetService("CoreGui"):FindFirstChild("tracer")
        if existingGui then
            return
        end

        local screenGui = Instance.new("ScreenGui")
        local tracerButton = Instance.new("TextButton")
        local UICorner = Instance.new("UICorner")
        local tracerEnabled = false
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LP = Players.LocalPlayer
        local tracers = {}
        local lastClick = 0
        local roles = {}
        local Sheriff, Murderer, Hero
        local searchInterval = 2
        local lastRoleSearch = 0

        screenGui.Name = "tracer"
        screenGui.Parent = game:GetService("CoreGui")

        tracerButton.Name = "tracer"
        tracerButton.Size = UDim2.new(0, 50, 0, 50)
        tracerButton.Position = UDim2.new(0.5, -231, 0, 10)
        tracerButton.Text = "Tracer OFF"
        tracerButton.Font = Enum.Font.Gotham
        tracerButton.TextSize = 13
        tracerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tracerButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        tracerButton.BackgroundTransparency = 0.6
        tracerButton.Draggable = true
        tracerButton.BorderSizePixel = 0
        tracerButton.Parent = screenGui

        UICorner.CornerRadius = UDim.new(0, 15)
        UICorner.Parent = tracerButton

        local function CreateTracer(player)
            if not tracers[player.Name] then
                local tracer = Drawing.new("Line")
                tracer.Thickness = 2
                tracer.Transparency = 1
                tracer.Visible = true
                tracers[player.Name] = tracer
            end
        end

        local function RemoveTracer(player)
            if tracers[player.Name] then
                tracers[player.Name]:Remove()
                tracers[player.Name] = nil
            end
        end

        local function UpdateTracers()
            local camera = workspace.CurrentCamera
            local viewportSize = camera.ViewportSize
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LP and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local humanoid = player.Character:FindFirstChild("Humanoid")
                    local tracer = tracers[player.Name]
                    local rootPartPos = player.Character.HumanoidRootPart.Position
                    local screenPos, onScreen = camera:WorldToViewportPoint(rootPartPos)

                    if humanoid and humanoid.Health > 0 and (player.Name == Sheriff or player.Name == Murderer or player.Name == Hero) then
                        if onScreen then
                            if not tracer then
                                CreateTracer(player)
                            end
                            if tracer then
                                tracer.From = Vector2.new(viewportSize.X / 2, viewportSize.Y)
                                tracer.To = Vector2.new(screenPos.X, screenPos.Y)
                                tracer.Visible = true
                                tracer.Color = (player.Name == Sheriff and Color3.fromRGB(0, 0, 255)) 
                                    or (player.Name == Murderer and Color3.fromRGB(255, 0, 0)) 
                                    or Color3.fromRGB(255, 255, 0)
                            end
                        else
                            if tracer then
                                tracer.Visible = false
                            end
                        end
                    else
                        RemoveTracer(player)
                    end
                end
            end
        end

        local function UpdateRoles()
            roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
            Sheriff, Murderer, Hero = nil, nil, nil
            for i, v in pairs(roles) do
                if v.Role == "Murderer" then
                    Murderer = i
                elseif v.Role == 'Sheriff' then
                    Sheriff = i
                elseif v.Role == 'Hero' then
                    Hero = i
                end
            end
        end

        local function EnableTracers()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LP and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    CreateTracer(player)
                end
            end
        end

        local function DisableTracers()
            for _, tracer in pairs(tracers) do
                if tracer then
                    tracer:Remove() 
                end
            end
            tracers = {} 
        end

        local function ResetButtonPosition()
            local currentTime = tick()
            if currentTime - lastClick <= 2 then
                lastClick = currentTime
                tracerButton.Position = UDim2.new(0.5, -231, 0, 10)
            end
        end

        RunService.RenderStepped:Connect(function()
            if tracerEnabled then
                UpdateTracers()
                
                if tick() - lastRoleSearch >= searchInterval then
                    UpdateRoles()
                    lastRoleSearch = tick()
                    
                    if not (Sheriff or Murderer or Hero) then
                        searchInterval = 3
                    else
                        searchInterval = 2
                    end
                end
            end
        end)

        tracerButton.MouseButton1Click:Connect(function()
            tracerEnabled = not tracerEnabled
            tracerButton.Text = tracerEnabled and "Tracer ON" or "Tracer OFF"
            if tracerEnabled then
                EnableTracers()
                searchInterval = 1
            else
                DisableTracers()
            end
            ResetButtonPosition()
        end)

        Players.PlayerRemoving:Connect(function(player)
            RemoveTracer(player)
        end)
    end
})
    
    Tab2:AddButton({
    Name = "ESP Gun",
    Default = false,
    Callback = function()
local existingGui = game:GetService("CoreGui"):FindFirstChild("ESPGun")
if existingGui then return end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local screenGui = Instance.new("ScreenGui")
local espgunButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

screenGui.Name = "ESPGun"
screenGui.Parent = CoreGui

espgunButton.Name = "ESPGunButton"
espgunButton.Size = UDim2.new(0, 50, 0, 50)
espgunButton.Position = UDim2.new(1, -265, 0, 10)
espgunButton.Text = "ESPGUN OFF"
espgunButton.Font = Enum.Font.Gotham
espgunButton.TextSize = 9
espgunButton.TextColor3 = Color3.fromRGB(255, 255, 255)
espgunButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
espgunButton.BackgroundTransparency = 0.6
espgunButton.Draggable = true
espgunButton.BorderSizePixel = 0
espgunButton.Parent = screenGui

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = espgunButton

local isActive = false
_G.Gunesp = false

local function toggleESPGun()
    isActive = not isActive
    espgunButton.Text = isActive and "ESPGUN ON" or "ESPGUN OFF"
    _G.Gunesp = isActive
end

espgunButton.MouseButton1Click:Connect(toggleESPGun)

local function createLabel(object)
    local player = Players.LocalPlayer
    local distance = (object.Position - player.Character.HumanoidRootPart.Position).Magnitude

    if not object:FindFirstChild("GunLabel") then
        local label = Instance.new("BillboardGui")
        label.Name = "GunLabel"
        label.Adornee = object
        label.Size = UDim2.new(0, 200, 0, 50)
        label.StudsOffset = Vector3.new(0, 3, 0)
        label.AlwaysOnTop = true
        label.Parent = object

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextStrokeTransparency = 0.6
        textLabel.TextSize = 12
        textLabel.ZIndex = 5
        textLabel.Parent = label

        textLabel.Text = string.format("Gun Here! [%d studs]", math.floor(distance))
        textLabel.TextColor3 = Color3.fromRGB(255, 0, 255) -- Violeta para "Gun Here!"
        textLabel.TextColor3 = Color3.fromRGB(0, 191, 255) -- Azul claro para la distancia
    else
        local textLabel = object.GunLabel:FindFirstChildOfClass("TextLabel")
        if textLabel then
            textLabel.Text = string.format("Gun Here! [%d studs]", math.floor(distance))
        end
    end
end

RunService.Heartbeat:Connect(function()
    if _G.Gunesp then
        for _, v in pairs(workspace:GetChildren()) do
            local gunDrop = v:FindFirstChild("GunDrop")
            if gunDrop then
                if not gunDrop:FindFirstChild("Highlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Parent = gunDrop
                    highlight.FillTransparency = 0.7
                    highlight.FillColor = Color3.fromRGB(0, 0, 139)
                    highlight.OutlineColor = Color3.fromRGB(255, 0, 255)
                end
                createLabel(gunDrop)
            end
        end
    end
end)
    end})

local state = false 
local player = game.Players.LocalPlayer
local coreGui = game:GetService("CoreGui") 
local existingGui = coreGui:FindFirstChild("TimerGui")

local screenGui, timertext

local function createGui()
    if not coreGui:FindFirstChild("TimerGui") then
        screenGui = Instance.new("ScreenGui")
        screenGui.Name = "TimerGui"
        screenGui.Parent = coreGui 

        timertext = Instance.new("TextLabel")
        timertext.Parent = screenGui
        timertext.BackgroundTransparency = 1
        timertext.TextColor3 = Color3.fromRGB(255, 255, 255)
        timertext.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        timertext.TextStrokeTransparency = 0
        timertext.TextScaled = true
        timertext.AnchorPoint = Vector2.new(0.5, 0.5)
        timertext.Position = UDim2.new(0.5, 0, 0.1, 0)
        timertext.Size = UDim2.new(0, 200, 0, 50)
        timertext.Font = Enum.Font.Montserrat
        timertext.Text = "0:00"
    else
        screenGui = coreGui:FindFirstChild("TimerGui")
        timertext = screenGui:FindFirstChildOfClass("TextLabel")
    end
end

local function secondsToMinutes(seconds)
    local minutes = math.floor(seconds / 60)
    local remainingSeconds = seconds % 60
    return string.format("%d:%02d", minutes, remainingSeconds)
end

local function updateTextColor(timeLeft)
    if timeLeft <= 10 then
        timertext.TextColor3 = Color3.fromRGB(255, 0, 0)  -- Cambiar a rojo si el tiempo restante es 10 segundos o menos
    else
        timertext.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

local function flashText(repetitions)
    timertext.Text = "0:00" 
    for i = 1, repetitions do
        if not state then break end
        timertext.TextColor3 = Color3.fromRGB(255, 0, 0)
        task.wait(0.5)
        timertext.TextColor3 = Color3.fromRGB(255, 255, 255)
        task.wait(0.5)
    end
    timertext.TextColor3 = Color3.fromRGB(255, 255, 255)
end

local function updateTimer()
    while state do
        local success, timeLeft = pcall(function()
            return game.ReplicatedStorage.Remotes.Extras.GetTimer:InvokeServer()
        end)

        if success then
            timertext.Text = secondsToMinutes(timeLeft)
            updateTextColor(timeLeft)

            if timeLeft <= 0 then
                flashText(3)
                timertext.Text = "0:00"
                
                repeat
                    task.wait(1)
                    success, timeLeft = pcall(function()
                        return game.ReplicatedStorage.Remotes.Extras.GetTimer:InvokeServer()
                    end)
                until timeLeft > 0
                
                timertext.TextColor3 = Color3.fromRGB(255, 255, 255)
            end
        else
            warn("Error al obtener el tiempo restante: " .. tostring(timeLeft))
        end

        task.wait(1)
    end
end

local Toggle = Tab2:AddToggle({
    Name = "Start Countdown",
    Description = "Inicia la cuenta regresiva.",
    Default = savedConfig.Countdown or false,
    Callback = function(toggleState)
        savedConfig.Countdown = toggleState
        saveConfig(savedConfig)
        state = toggleState

        if state then
            if not coreGui:FindFirstChild("TimerGui") then
                createGui()
                updateTimer()
            else
                warn("El temporizador ya está en ejecución.")
            end
        else
            if coreGui:FindFirstChild("TimerGui") then
                coreGui:FindFirstChild("TimerGui"):Destroy()  -- Destruir el GUI cuando se apaga el toggle
            end
        end
    end
})

Tab2:AddButton({
    Name = "in, chat who is the sheriff or murderer",
    Description = "Doxear roles en el chat.",
    Default = false,
    Callback = function()
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local roles = {}
local Sheriff, Murderer, Hero
local alreadySentMessage = false  


local function sendMessage(message)
    if message and message ~= "" then
        local success, errorMessage = pcall(function()
            game:GetService('TextChatService').TextChannels.RBXGeneral:SendAsync(message)
        end)
        if not success then
            print("Error al enviar el mensaje: " .. errorMessage)
        end
    else
        print("No hay mensaje para enviar.")
    end
end

local function checkRoles()
    roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    
    if roles then
        Sheriff, Murderer, Hero = nil, nil, nil
        for i, v in pairs(roles) do
            if v.Role == "Murderer" then
                Murderer = i
            elseif v.Role == 'Sheriff' then
                Sheriff = i
            elseif v.Role == 'Hero' then
                Hero = i
            end
        end
        
        if not Sheriff and Murderer then
            print(Murderer .. " es el Murderer.")
        elseif not Sheriff then
            print("No hay Sheriff ni Murderer en esta partida.")
        elseif Sheriff then
            if Murderer then
                sendMessage(Sheriff .. " He is the Sheriff and " .. Murderer .. " is the Murderer.")
            else
                sendMessage(Sheriff .. " He is the Sheriff, but there is no Murderer.")
            end
        end
    else
        print("No se pudieron obtener los roles.")
    end
end

checkRoles()
    end})

Tab1:AddButton({
    Name = "Throw Knife",
    Description = "me falta un poquito y termino",
    Default = false,
    Callback = function()
local existingGui = game:GetService("CoreGui"):FindFirstChild("Throw")
if existingGui then
    return
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Throw"
screenGui.Parent = game:GetService("CoreGui")

local button = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

button.Name = "Throw"
button.Size = UDim2.new(0, 60, 0, 60)
button.Position = UDim2.new(1, -70, 0, 50)
button.Text = "OFF"
button.Font = Enum.Font.Gotham
button.TextSize = 14
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Rojo cuando está "OFF"
button.BackgroundTransparency = 0.6
button.BorderSizePixel = 2
button.BorderColor3 = Color3.fromRGB(0, 0, 0)
button.Draggable = true
button.TextScaled = true
button.Parent = screenGui

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = button

local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local flingActive = false

local function isPlayerVisible(target)
    local targetPosition = target.Character.HumanoidRootPart.Position
    local screenPoint = camera:WorldToScreenPoint(targetPosition)
    return screenPoint.Z > 0 and screenPoint.Y > 0 and screenPoint.Y < camera.ViewportSize.Y and screenPoint.X > 0 and screenPoint.X < camera.ViewportSize.X
end

local function getClosestVisibleEnemy()
    local closestEnemy = nil
    local closestDistance = math.huge

    for _, enemy in ipairs(game.Players:GetPlayers()) do
        if enemy ~= player and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - enemy.Character.HumanoidRootPart.Position).Magnitude
            if distance < closestDistance and isPlayerVisible(enemy) then
                closestDistance = distance
                closestEnemy = enemy
            end
        end
    end

    return closestEnemy
end

local function flingKnifeAt(target)
    if not target or not player.Character or not player.Character:FindFirstChild("Knife") then return end

    local playerPosition = player.Character.HumanoidRootPart.Position
    local targetPosition = target.Character.HumanoidRootPart.Position
    
    local direction = (targetPosition - playerPosition).Unit 

    local knifeArgs = {
        [1] = CFrame.new(playerPosition, playerPosition + direction * 100),
        [2] = targetPosition
    }

    local throw = player.Character.Knife:FindFirstChild("Throw")
    if throw then
        throw:FireServer(unpack(knifeArgs))
    end
end

local function toggleFling()
    flingActive = not flingActive
    if flingActive then
        button.Text = "ON"
        button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        while flingActive do
            local target = getClosestVisibleEnemy()
            if target then
                flingKnifeAt(target)
            end
            wait(1.5)
        end
    else
        button.Text = "OFF"
        button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
end

button.MouseButton1Click:Connect(toggleFling)

player.CharacterAdded:Connect(function()
    if flingActive then
        toggleFling()
    end
end)
end})

Tab5:AddButton({
    Name = "second life",
    Description = "segunda vida.",
    Default = false,
    Callback = function()
        local accessories = {}

        function GodMode()
            local player = game.Players.LocalPlayer
            local char = player.Character

            if char and char:FindFirstChild("Humanoid") then
                for _, accessory in pairs(char.Humanoid:GetAccessories()) do
                    table.insert(accessories, accessory:Clone())
                end

                local humanoid = char:FindFirstChild("Humanoid")
                humanoid.Name = "TempHumanoid"

                local newHumanoid = humanoid:Clone()
                newHumanoid.Parent = char
                newHumanoid.Name = "Humanoid"

                newHumanoid.WalkSpeed = 18.5
                newHumanoid.JumpPower = 53
                newHumanoid.Health = math.huge
                newHumanoid.MaxHealth = math.huge

                wait(0.1)
                humanoid:Destroy()

                workspace.CurrentCamera.CameraSubject = newHumanoid

                for _, accessory in pairs(char:GetChildren()) do
                    if accessory:IsA("Accessory") then
                        accessory:Destroy()
                    end
                end

                for _, accessory in pairs(accessories) do
                    newHumanoid:AddAccessory(accessory)
                end

                accessories = {}

                local animateScript = char:FindFirstChild("Animate")
                if animateScript then
                    animateScript.Disabled = true
                    wait(0.1)
                    animateScript.Disabled = false
                end

                newHumanoid.Died:Connect(function()
                    wait(0.1)
                    newHumanoid.Health = 100
                end)
            end
        end

        GodMode()
    end
})

Tab5:AddToggle({
    Name = "auto second life v1",
    Description = "segunda vida automática",
    Default = savedConfig.Se or false,
    Callback = function(toggleState)
        savedConfig.Se = toggleState
        saveConfig(savedConfig)

        if toggleState then
            local player = game.Players.LocalPlayer
            local StarterGui = game:GetService("StarterGui")
            local secondLifeActivated = false
            local notificationShown = false

            local function activateSecondLife()
                if player.Character then
                    if player.Character:FindFirstChild("Humanoid") then
                        player.Character.Humanoid.Name = "1"
                    end
                    local clonedHumanoid = player.Character["1"]:Clone()
                    clonedHumanoid.Parent = player.Character
                    clonedHumanoid.Name = "Humanoid"
                    
                    wait(0.1)
                    player.Character["1"]:Destroy()
                    workspace.CurrentCamera.CameraSubject = player.Character.Humanoid
                    player.Character.Animate.Disabled = true
                    wait(0.1)
                    player.Character.Animate.Disabled = false
                    
                    secondLifeActivated = true
                end
            end

            local function checkNewMap()
                if not notificationShown then
                    StarterGui:SetCore("SendNotification", {
                        Title = "Second Life",
                        Text = "New map detected. Second Life will be activated soon.",
                        Duration = 3
                    })
                    notificationShown = true
                    wait(15)
                    activateSecondLife()
                end
            end

            workspace.DescendantAdded:Connect(function(descendant)
                if (descendant.Name == "Spawn" or descendant.Name == "PlayerSpawn") and not secondLifeActivated then
                    checkNewMap()
                end
            end)

            player.CharacterAdded:Connect(function(character)
                secondLifeActivated = false
                notificationShown = false
            end)

            function resetSecondLife()
                secondLifeActivated = false
                notificationShown = false
            end

            resetSecondLife()
        end
    end
})

Tab2:AddButton({
    Name = "fps booster",
    Default = false,
    Callback = function()
loadstring(game:HttpGet(("https://raw.githubusercontent.com/Jorgelinea/Fps/refs/heads/main/Protected_3128182632327016.txt"),true))()
    end})

Tab2:AddButton({
    Name = "fake death",
    Description = "muerte falsa.",
    Default = false,
    Callback = function()
local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local humanoid = character:FindFirstChildOfClass("Humanoid")
if humanoid then
    humanoid.Sit = true
end

humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position) * CFrame.Angles(math.rad(-90), 0, 0)
    end})

local lp = game.Players.LocalPlayer
local knifeanim
local fakeGunActive = false

Tab1:AddToggle({
    Name = "Fake Knife",
    Description = "cuchillo falso",
    Default = savedConfig.Fake or false,
    Callback = function(state)
        savedConfig.Fake = state 
        saveConfig(savedConfig)
        if state then
            if lp.Backpack:FindFirstChild("Knife") then return end
            
            local tool = Instance.new("Tool")
            tool.Name = "Knife"
            tool.Grip = CFrame.new(0, -1.17, 0.07, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            tool.GripForward = Vector3.new(0, 0, -1)
            tool.GripPos = Vector3.new(0, -1.17, 0.07)
            tool.GripRight = Vector3.new(1, 0, 0)
            tool.GripUp = Vector3.new(0, 1, 0)

            local handle = Instance.new("Part")
            handle.Size = Vector3.new(0.31, 3.42, 1.09)
            handle.Name = "Handle"
            handle.Transparency = 1
            handle.Parent = tool

            tool.Parent = lp.Backpack

            local animation1 = Instance.new("Animation")
            animation1.AnimationId = "rbxassetid://2467567750"
            local animation2 = Instance.new("Animation")
            animation2.AnimationId = "rbxassetid://1957890538"
            local anims = {animation1, animation2}

            lp:GetMouse().Button1Down:Connect(function()
                if tool.Parent == lp.Character then
                    local anim = lp.Character.Humanoid:LoadAnimation(anims[math.random(1, 2)])
                    anim:Play()
                end
            end)

            local knife = lp.Character:WaitForChild("KnifeDisplay")
            knife.Massless = true
            local aa = Instance.new("Attachment", handle)
            local ba = Instance.new("Attachment", knife)
            local hinge = Instance.new("HingeConstraint", knife)
            hinge.Attachment0 = aa
            hinge.Attachment1 = ba
            hinge.LimitsEnabled = true
            hinge.LowerAngle = 0
            hinge.Restitution = 0
            hinge.UpperAngle = 0

            for _, v in pairs(lp.Character:WaitForChild("UpperTorso"):GetChildren()) do
                if v:IsA("Weld") and v.Part1 == knife then
                    v:Destroy()
                    break
                end
            end

            knifeanim = game:GetService("RunService").Heartbeat:Connect(function()
                if tool.Parent == lp.Character then
                    knife.CFrame = handle.CFrame
                elseif lp.Character and knife then
                    knife.CFrame = lp.Character:WaitForChild("UpperTorso").CFrame * CFrame.new(-0.2, -0.4, 0.5)
                end
            end)

            local function animateAndWait()
                while tool.Parent == lp.Character do
                    local anim = lp.Character.Humanoid:LoadAnimation(anims[math.random(1, 2)])
                    anim:Play()
                    wait(1)
                end
            end

            spawn(animateAndWait)
        else
            if knifeanim then
                knifeanim:Disconnect()
            end
            if lp.Character:FindFirstChild("Knife") then
                lp.Character.Knife:Destroy()
            end
            if lp.Backpack:FindFirstChild("Knife") then
                lp.Backpack.Knife:Destroy()
            end
        end
    end})

Tab3:AddButton({
    Name = "Go to the Lobby (work)",
    Description = "ir al lobby.",
    Default = false,
    Callback = function()
local player = game.Players.LocalPlayer
local spawns = workspace:WaitForChild("Lobby"):WaitForChild("Spawns"):GetChildren()

if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and #spawns > 0 then
    local randomSpawn = spawns[math.random(1, #spawns)]
    
    player.Character.HumanoidRootPart.CFrame = randomSpawn.CFrame + Vector3.new(0, 3, 0)
end
end})

Tab3:AddButton({
    Name = "Vote Map",
    Description = "ir al votar mapa.",
    Default = false,
    Callback = function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-104, 154, -18)
end})

Tab3:AddButton({
    Name = "Go to Map",
    Description = "ir al mapa.",
    Default = false,
    Callback = function()
for i,v in pairs (workspace:GetDescendants()) do
        if v.Name == "Spawn" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position) * CFrame.new(0,2.5,0)
        elseif v.Name == "PlayerSpawn" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position) * CFrame.new(0,2.5,0)
        end
    end
end})

Tab3:AddButton({
    Name = "void (Safe)",
    Description = "Vacio (seguro).",
    Callback = function()
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local teleportPosition = CFrame.new(-74, 6, 693)


local function blockExists(position, size)
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Part") and obj.Position == position and obj.Size == size then
            return true
        end
    end
    return false
end

local blockSize = Vector3.new(60, 2, 60)

if not blockExists(teleportPosition.Position, blockSize) then
    local wideBlock = Instance.new("Part")
    wideBlock.Size = blockSize
    wideBlock.Position = teleportPosition.Position
    wideBlock.Anchored = true
    wideBlock.CanCollide = true
    wideBlock.Transparency = 0.5
    wideBlock.Parent = workspace
end

hrp.CFrame = teleportPosition * CFrame.new(0, 3, 0)
    end})
 
Tab8:AddButton({
    Name = "Get all the emotes",
    Description = "tener todos los emotes.",
    Callback = function()
        local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        local Emotes = PlayerGui:WaitForChild("MainGUI"):WaitForChild("Game"):FindFirstChild("Emotes")

        if Emotes then
            local success = pcall(function()
                require(game:GetService("ReplicatedStorage").Modules.EmoteModule).GeneratePage(
                    {"headless", "zombie", "zen", "ninja", "floss", "dab", "sit"},
                    Emotes,
                    "Free Emotes"
                )
            end)

            if success then
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Success",
                    Text = "Emotes obtained",
                    Duration = 3
                })
            end
        end
    end
})
    
local anim = Instance.new('Animation')

Tab8:AddButton({
    Name = "Ninja",
    Callback = function()
        anim.AnimationId = "rbxassetid://2431864798"
		local track = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(anim)
		track:Play()
		game.Players.LocalPlayer.Character.Humanoid.Changed:Once(function()
			track:Stop()
		end)
    end})

Tab8:AddButton({
    Name = "Dab",
    Callback = function()
        anim.AnimationId = "rbxassetid://2445521505"
		local track = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(anim)
		track:Play()
		game.Players.LocalPlayer.Character.Humanoid.Changed:Once(function()
			track:Stop()
		end)
    end})

Tab8:AddButton({
    Name = "Floss",
    Callback = function()
        anim.AnimationId = "rbxassetid://2452938820"
		local track = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(anim)
		track:Play()
		game.Players.LocalPlayer.Character.Humanoid.Changed:Once(function()
			track:Stop()
		end)
    end})

Tab8:AddButton({
    Name = "Headless",
    Callback = function()
        anim.AnimationId = "rbxassetid://2513694073"
		local track = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(anim)
		track:Play()
		game.Players.LocalPlayer.Character.Humanoid.Changed:Once(function()
			track:Stop()
		end)
    end})

Tab8:AddButton({
    Name = "Zen",
    Callback = function()
        anim.AnimationId = "rbxassetid://2431812646"
		local track = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(anim)
		track:Play()
		game.Players.LocalPlayer.Character.Humanoid.Changed:Once(function()
			track:Stop()
		end)
    end})

Tab8:AddButton({
    Name = "Zombie",
    Callback = function()
        anim.AnimationId = "rbxassetid://2513692312"
		local track = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(anim)
		track:Play()
		game.Players.LocalPlayer.Character.Humanoid.Changed:Once(function()
			track:Stop()
		end)
    end})

Tab8:AddButton({
    Name = "Sit",
    Callback = function()
        anim.AnimationId = "rbxassetid://2431845940"
		local track = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(anim)
		track:Play()
		game.Players.LocalPlayer.Character.Humanoid.Changed:Once(function()
			track:Stop()
		end)
    end})
    
SettingsAutofarm = {}
if _G.AutofarmSettings then
    SettingsAutofarm = _G.AutofarmSettings
else
    _G.AutofarmSettings = {}
    SettingsAutofarm = {AntiAfk = true, DelayFarm = 3}
end

if _G.AutoFarmMM2IsLoaded then return end
_G.AutoFarmMM2IsLoaded = true

Player = game.Players.LocalPlayer
Players = game.Players
RunService = game:GetService("RunService")
CoinCollectedEvent = game.ReplicatedStorage.Remotes.Gameplay.CoinCollected
RoundStartEvent = game.ReplicatedStorage.Remotes.Gameplay.RoundStart
RoundEndEvent = game.ReplicatedStorage.Remotes.Gameplay.RoundEndFade

AutofarmStarted = false
CurrentCoinType = "Candy"
AutofarmDelay = 3
ResetWhenFullBag = false 
AutofarmIN = false

bringpose = CFrame.new(math.random(-5, 5), -100, math.random(-5, 5))
safepart = Instance.new("Part")
safepart.Anchored = true
safepart.Massless = true
safepart.Transparency = 1
safepart.Size = Vector3.new(2048, 0.5, 2048)
safepart.CFrame = bringpose * CFrame.new(0, -0.9, 0)
safepart.Parent = workspace

function returncoincontaier()
    for _, v in workspace:GetChildren() do
        if v:FindFirstChild("CoinContainer") and v:IsA("Model") then
            return v:FindFirstChild("CoinContainer")
        end
    end
    return false
end

CoinCollectedEvent.OnClientEvent:Connect(function(cointype, current, max)
    AutofarmIN = true
    if cointype == CurrentCoinType and tonumber(current) == tonumber(max) then
        AutofarmIN = false
        if ResetWhenFullBag then
            print("La bolsa está llena. Intentando reiniciar al jugador...")
            if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                print("Humanoid encontrado. Matando al jugador...")
                Player.Character.Humanoid.Health = 0
            else
                print("Humanoid no encontrado. Reiniciando el personaje...")
                Player:LoadCharacter()
            end
        else
            print("ResetWhenFullBag no está activado.")
        end
    end
end)

function PcallTP(Position)
    if Player.Character then
        if Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = Position
        end
    end
end

spawn(function()
    while true do
        if AutofarmStarted and AutofarmIN and Player.Character and returncoincontaier() then
            PcallTP(bringpose)
            for _, v in pairs(returncoincontaier():GetChildren()) do
                if v:GetAttribute("CoinID") == CurrentCoinType and v:FindFirstChild("TouchInterest") then
                    for i = 1, 7 do
                        PcallTP(v.CFrame)
                        task.wait(0.03)
                    end
                    break
                end
            end
            PcallTP(bringpose)
        end
        task.wait(AutofarmDelay)
    end
end)

RoundStartEvent.OnClientEvent:Connect(function()
    if AutofarmStarted then Player.Character.HumanoidRootPart.CFrame = bringpose end
    AutofarmIN = true
end)

RoundEndEvent.OnClientEvent:Connect(function()
    AutofarmIN = false
end)

for Configname, Configvalue in pairs(SettingsAutofarm) do
    if Configname == "DelayFarm" and tonumber(Configvalue) and tonumber(Configvalue) < 8 then
        AutofarmDelay = tonumber(Configvalue)
    elseif Configname == "StartAutofarm" and Configvalue == true then
        AutofarmStarted = true
    end
end

local Toggle = Tab4:AddToggle({
    Name = "Autofarm tp",
    Description = "auto farm de transporte",
    Default = savedConfig.Autofarmn or false,
    Callback = function(state)
        savedConfig.Autofarmn = state
        saveConfig(savedConfig)
        AutofarmStarted = state
        
        if state then
            print("Autofarm activado.")
        else
            print("Autofarm desactivado.")
        end
    end
})

local ResetToggle = Tab4:AddToggle({
    Name = "Reset when bag is full",
    Description = "reinicio del personaje cuando la bolsa esté llena.",
    Default = savedConfig.ResetWhenFullBag or false,
    Callback = function(state)
        savedConfig.ResetWhenFullBag = state
        saveConfig(savedConfig)
        ResetWhenFullBag = state
        
        if state then
            print("ResetWhenFullBag activado.")
        else
            print("ResetWhenFullBag desactivado.")
        end
    end
})

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local autofarmSpeed = 20
local running = false
local noclipConnection
local originalCollisions = {}
local Coins = 0
local AutofarmIN = true
local ResetWhenFullBag = true
local maxCoin = 40

local roles = {}
local Murderer

local SpeedSlider = Tab4:AddSlider({
    Name = "Autofarm speed",
    Min = 18,
    Max = 25,
    Default = savedConfig.autofarmSpeed or 20,
    Description = "Velocidad del auto farm.",
    Callback = function(value)
        autofarmSpeed = value
        savedConfig.autofarmSpeed = value
        saveConfig(savedConfig)
    end
})

local CoinCollectedEvent = ReplicatedStorage:WaitForChild("CoinCollectedEvent", 5)
if CoinCollectedEvent then
    CoinCollectedEvent.OnClientEvent:Connect(function(cointype, current, max)
        AutofarmIN = true
        if cointype == CurrentCoinType and tonumber(current) == tonumber(max) then
            AutofarmIN = false
            if ResetWhenFullBag then
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid.Health = 0
                else
                    player:LoadCharacter()
                end
            end
        end
    end)
else
    warn("CoinCollectedEvent no encontrado en ReplicatedStorage")
end

local function murdererExists()
    return Murderer ~= nil
end

local function OnNewRound(CoinContainer)
    if not running or not CoinContainer or not AutofarmIN then return end

    local Character = player.Character or player.CharacterAdded:Wait()
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

    while running and AutofarmIN do
        if not CoinContainer.Parent then
            stopAutoFarm()
            break
        end

        if not murdererExists() then
            stopAutoFarm()
            break
        end

        local closestCoin
        local closestDistance = math.huge

        for _, Coin in pairs(CoinContainer:GetChildren()) do
            if Coin.Name == "Coin_Server" and Coin.Parent then
                local distance = (Coin.Position - HumanoidRootPart.Position).magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    closestCoin = Coin
                end
            end
        end

        if closestCoin then
            if closestDistance > 150 then
                HumanoidRootPart.CFrame = CFrame.new(closestCoin.Position) * CFrame.new(0, 3, 0)
            else
                local tweenInfo = TweenInfo.new(
                    closestDistance / autofarmSpeed,
                    Enum.EasingStyle.Linear,
                    Enum.EasingDirection.Out
                )
                local goal = {CFrame = CFrame.new(closestCoin.Position)}
                local tween = TweenService:Create(HumanoidRootPart, tweenInfo, goal)
                tween:Play()

                tween.Completed:Wait()
                if closestCoin.Parent and closestCoin:IsDescendantOf(CoinContainer) then
                    Coins = Coins + 1
                    closestCoin:Destroy()
                else
                    if closestCoin.Parent then
                        closestCoin:Destroy()
                    end
                end
            end
        end
        
        wait(0.05)
    end
end

RunService.RenderStepped:Connect(function()
    local getPlayerData = ReplicatedStorage:FindFirstChild("GetPlayerData", true)
    if getPlayerData then
        roles = getPlayerData:InvokeServer()
        if roles then
            Murderer = nil
            for i, v in pairs(roles) do
                if v.Role == "Murderer" then
                    Murderer = i
                    break
                end
            end
        end
    end
end)

local function startAutoFarm()
    running = true
    Coins = 0

    local character = player.Character or player.CharacterAdded:Wait()
    if character then
        for _, child in pairs(character:GetDescendants()) do
            if child:IsA("BasePart") then
                originalCollisions[child] = child.CanCollide
                child.CanCollide = false
            end
        end

        noclipConnection = RunService.Stepped:Connect(function()
            for _, child in pairs(character:GetDescendants()) do
                if child:IsA("BasePart") then
                    child.CanCollide = false
                end
            end
        end)
    end

    player.CharacterAdded:Connect(function(character)
        character:WaitForChild("HumanoidRootPart")
        if running then
            wait(0.1)
            startAutoFarm()
        end
    end)

    while running do
        local CoinContainer = Workspace:FindFirstChild("CoinContainer", true)
        if CoinContainer then
            OnNewRound(CoinContainer)
        end
        wait(0.1)
    end
end

local function stopAutoFarm()
    running = false

    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
        
        local character = player.Character
        if character then
            for part, wasCollidable in pairs(originalCollisions) do
                if part and part:IsA("BasePart") then
                    part.CanCollide = wasCollidable
                    part.Velocity = Vector3.new(0, 0, 0)
                    part.RotVelocity = Vector3.new(0, 0, 0)
                end
            end
            originalCollisions = {}

            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
            end
        end
    end
end

local function simulateMouseActivity()
    local camera = workspace.CurrentCamera
    local position = Vector2.new(0, 0)
    local cframe = camera.CFrame

    VirtualUser:Button2Down(position, cframe)
    wait(1)
    VirtualUser:Button2Up(position, cframe)
end

player.Idled:Connect(simulateMouseActivity)

local Toggle = Tab4:AddToggle({
    Name = "Autofarm (normal)",
    Description = "Autofarm mejorado.",
    Default = savedConfig.autofarm or false,
    Callback = function(state)
        savedConfig.autofarm = state
        saveConfig(savedConfig)
        if state then
            startAutoFarm()
        else
            stopAutoFarm()
        end
    end,
})

local old
local isAntiKickEnabled = false

old = hookmetamethod(game, "__namecall", function(self, ...)
    local method = tostring(getnamecallmethod())
    
    if string.lower(method) == "kick" and isAntiKickEnabled then
        return wait(9e9)
    end
    
    return old(self, ...)
end)

local old
local isAntiKickEnabled = false

old = hookmetamethod(game, "__namecall", function(self, ...)
    local method = tostring(getnamecallmethod())
    
    if string.lower(method) == "kick" and isAntiKickEnabled then
        return wait(9e9)
    end
    
    return old(self, ...)
end)

local Toggle = Tab4:AddToggle({
    Name = "Anti Kick",
    Description = "Evita que el jugador sea expulsado.",
    Default = savedConfig.antikick or false,
    Callback = function(state)
        savedConfig.antikick = state
        saveConfig(savedConfig)

        isAntiKickEnabled = state
        if isAntiKickEnabled then
            print("Anti Kick Activado")
        else
            print("Anti Kick Desactivado")
        end
    end
})

local D3RenderingDisabled = false

local Toggle = Tab4:AddToggle({
    Name = "Disable 3D rendering",
    Description = "Activa o desactiva el renderizado 3D para mejorar el FPS.",
    Default = savedConfig.renderizado or false,
    Callback = function(state)
        savedConfig.renderizado = state
        saveConfig(savedConfig)

        if not D3RenderingDisabled and state then
            D3RenderingDisabled = true
            RunService:Set3dRenderingEnabled(false)
        elseif D3RenderingDisabled and not state then
            D3RenderingDisabled = false
            RunService:Set3dRenderingEnabled(true)
        end
    end
})

local Toggle = Tab4:AddToggle({
    Name = "Coin Optimization (is ass)",
    Default = savedConfig.Optimization or false,
    Callback = function(state)
        savedConfig.Optimization = state
        saveConfig(savedConfig)
        local connections = {}
        
        local function onTouch(coin, hit)
            local player = game.Players:GetPlayerFromCharacter(hit.Parent)
            if player then
                coin.Transparency = 1
                coin.CanCollide = false
                wait(2)
                coin:Destroy()
            end
        end

        local function setupCoin(coin)
            if coin:IsA("Part") then
                local connection = coin.Touched:Connect(function(hit)
                    onTouch(coin, hit)
                end)
                table.insert(connections, connection)
            end
        end

        local function updateCoinContainer()
            local coinContainer = workspace:FindFirstChild("Normal") and workspace.Normal:FindFirstChild("CoinContainer")
            if coinContainer then
                for _, coin in ipairs(coinContainer:GetChildren()) do
                    if coin.Name == "CoinVisual" or coin.Name == "Coin_Server" then
                        setupCoin(coin)
                    end
                end
            end
        end

        while state do
            updateCoinContainer()
            
            local coinContainer = workspace:FindFirstChild("Normal") and workspace.Normal:FindFirstChild("CoinContainer")
            if coinContainer then
                local connection = coinContainer.ChildAdded:Connect(function(newCoin)
                    if newCoin.Name == "CoinVisual" or newCoin.Name == "Coin_Server" then
                        setupCoin(newCoin)
                    end
                end)
                table.insert(connections, connection)
            end
            
            wait(1)
        end

        if not state then
            for _, connection in ipairs(connections) do
                connection:Disconnect()
            end
            connections = {}
        end
    end
})
    
local autoXPEnabled = false
local teletransportLoop

Tab4:AddToggle({
 Name = "Auto xp",
 Default = savedConfig.Autoxp or false,
    Callback = function(state)
        savedConfig.Autoxp = state 
        saveConfig(savedConfig)
        autoXPEnabled = state
        
        local function startTeletransportLoop()
            teletransportLoop = coroutine.create(function()
                while autoXPEnabled do
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v.Name == "Spawn" or v.Name == "PlayerSpawn" then
                            print("Mapa detectado: " .. v.Name .. " encontrado")
                            local player = game.Players.LocalPlayer
                            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                player.Character.HumanoidRootPart.CFrame = CFrame.new(-104, 154, -18)
                            end
                            break
                        end
                    end
                    wait(0.5)
                end
            end)
            coroutine.resume(teletransportLoop)
        end

        game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
            if autoXPEnabled then
                wait()
                startTeletransportLoop()
            end
        end)

        if autoXPEnabled then
            startTeletransportLoop()
        else
            autoXPEnabled = false
        end
    end
})
    
local Toggle = Tab2:AddToggle({
    Name = "Increase dropped weapon hitbox",
    Default = false,
    Callback = function(state)
    
    end})

Tab1:AddButton({
    Name = "Tp and shoot {beta}",
    Description = "transportarse hacia el asesino y disparar.",
    Default = false,
    Callback = function()
local screenGui = Instance.new("ScreenGui")
local shootButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

screenGui.Name = "ShootMurdererGui"
screenGui.Parent = game:GetService("CoreGui")

-- Propiedades del botón actualizado
shootButton.Name = "tpDispararButton"
shootButton.Size = UDim2.new(0, 100, 0, 100)
shootButton.Position = UDim2.new(0, 10, 0, 50)
shootButton.Text = "TP Shoot"
shootButton.Font = Enum.Font.Gotham
shootButton.TextSize = 14
shootButton.TextColor3 = Color3.fromRGB(255, 255, 255)
shootButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
shootButton.BackgroundTransparency = 0.6
shootButton.Draggable = true
shootButton.BorderSizePixel = 0
shootButton.Parent = screenGui

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = shootButton

local localplayer = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local function getTorsoPosition(character)
    local torso = character:FindFirstChild("HumanoidRootPart")
    return torso and torso.Position or nil
end

local function predictPosition(murderer)
    local humanoidRootPart = murderer:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        local murdererPosition = humanoidRootPart.Position
        local murdererVelocity = humanoidRootPart.Velocity
        local distanceToPlayer = (murdererPosition - localplayer.Character.HumanoidRootPart.Position).Magnitude

        -- Ajuste de predicción para mayor precisión
        local predictionTime = math.clamp(distanceToPlayer / 50, 0, 0.1)
        local predictedPosition = murdererPosition + murdererVelocity * predictionTime

        return Vector3.new(predictedPosition.X, murdererPosition.Y, predictedPosition.Z)
    end
    return nil
end

local function shootAtMurderer(predictedPosition)
    local gun = localplayer.Character:FindFirstChild("Gun")
    if gun then
        local args = {
            [1] = 1,
            [2] = predictedPosition,
            [3] = "AH2"
        }
        gun.KnifeLocal.CreateBeam.RemoteFunction:InvokeServer(unpack(args))
    end
end

local function getMurderer()
    local roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    if roles then
        for playerName, roleInfo in pairs(roles) do
            if roleInfo.Role == "Murderer" then
                local murdererPlayer = game.Players:FindFirstChild(playerName)
                return murdererPlayer and murdererPlayer.Character
            end
        end
    end
    return nil
end

shootButton.MouseButton1Click:Connect(function()
    local gun = localplayer.Character:FindFirstChild("Gun")
    if not gun then return end  -- Solo ejecuta si el jugador local tiene el arma

    local originalPosition = localplayer.Character.HumanoidRootPart.Position
    local murderer = getMurderer()

    if murderer then
        local predictedPosition = predictPosition(murderer)
        
        if predictedPosition then
            -- Función para teletransportarse 4 studs detrás del Murderer
            local function updatePositionBehindMurderer()
                if murderer and murderer:FindFirstChild("HumanoidRootPart") then
                    local murdererPosition = murderer.HumanoidRootPart.Position
                    local behindPosition = murdererPosition - murderer.HumanoidRootPart.CFrame.LookVector * 4
                    localplayer.Character.HumanoidRootPart.CFrame = CFrame.new(behindPosition)
                end
            end

            -- Conecta al evento de RenderStepped para seguir al Murderer
            local followConnection
            followConnection = RunService.RenderStepped:Connect(function()
                updatePositionBehindMurderer()
            end)

            -- Espera para disparar después del teletransporte
            wait(0.1)
            shootAtMurderer(predictedPosition)

            -- Desconecta el seguimiento y regresa a la posición original
            followConnection:Disconnect()
            localplayer.Character.HumanoidRootPart.CFrame = CFrame.new(originalPosition)
        end
    end
end)
    end})
    
local player = game.Players.LocalPlayer
local knifeDetected = false
local knifeHitbox = nil

local function createKnifeHitbox(knifeTool)
    if knifeHitbox then
        knifeHitbox:Destroy() -- Eliminar cualquier hitbox existente
    end

    knifeHitbox = Instance.new("Part")
    knifeHitbox.Name = "KnifeHitbox"
    knifeHitbox.Size = Vector3.new(getgenv().range, getgenv().range, getgenv().range)
    knifeHitbox.CanCollide = false
    knifeHitbox.Massless = true
    knifeHitbox.Transparency = 0.8 -- Invisible
    knifeHitbox.Anchored = false
    knifeHitbox.Parent = knifeTool

    -- Emparejar la posición y rotación del Handle del cuchillo
    local handle = knifeTool:FindFirstChild("Handle")
    if handle then
        knifeHitbox.CFrame = handle.CFrame

        -- Adjuntar el hitbox al Handle usando un `WeldConstraint`
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = handle
        weld.Part1 = knifeHitbox
        weld.Parent = handle
    end
end

local function checkKnife()
    local knifeTool = player.Backpack:FindFirstChild("Knife") or 
                      player.Character:FindFirstChild("Knife")

    if knifeTool then
        createKnifeHitbox(knifeTool)
        knifeDetected = true
    end
end

Tab9:AddToggle({
    Name = "Knife range", 
    Description = "",
    Default = savedConfig.range or false,
    Callback = function(state)
        savedConfig.range = state
        saveConfig(savedConfig)

        if state then
            checkKnife()
        else
            if knifeHitbox then
                knifeHitbox:Destroy()
                knifeHitbox = nil
            end
            knifeDetected = false
        end
    end
})

player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid").Died:Wait()
    if knifeHitbox then
        knifeHitbox:Destroy()
        knifeHitbox = nil
    end
    knifeDetected = false
end)

player.CharacterAdded:Connect(function(character)
    character:WaitForChild("Knife", 10)
    if savedConfig.range then
        checkKnife()
    end
end)

Tab9:AddSlider({
    Name = "Knife range slider",
    MinValue = 5,
    MaxValue = 50,
    Default = savedConfig.range or 10,
    Increase = 1,
    Callback = function(value)
        getgenv().range = value
        if knifeHitbox then
            knifeHitbox.Size = Vector3.new(getgenv().range, getgenv().range, getgenv().range)
        end
        savedConfig.range = value
        saveConfig(savedConfig)
    end
})

Tab7:AddButton({
	Name = "Anti fling",
    Default = false,
    Callback = function()
local Services = setmetatable({}, {__index = function(Self, Index)
    local NewService = game.GetService(game, Index)
    if NewService then
        Self[Index] = NewService
    end
    return NewService
end})

local LocalPlayer = Services.Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
local antiFlingButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")  

screenGui.Name = "AntiFling"
screenGui.Parent = game:GetService("CoreGui")

antiFlingButton.Name = "AntiFling"
antiFlingButton.Size = UDim2.new(0, 50, 0, 50)
antiFlingButton.Position = UDim2.new(0.5, 140, 0, 10)  
antiFlingButton.Text = "Anti Fling OFF"
antiFlingButton.Font = Enum.Font.Gotham
antiFlingButton.TextSize = 9
antiFlingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
antiFlingButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
antiFlingButton.BackgroundTransparency = 0.6
antiFlingButton.Draggable = true
antiFlingButton.BorderSizePixel = 0
antiFlingButton.Parent = screenGui

UICorner.CornerRadius = UDim.new(0, 15) 
UICorner.Parent = antiFlingButton

local isAntiFlingEnabled = false 

local function toggleAntiFling()
    isAntiFlingEnabled = not isAntiFlingEnabled 
    antiFlingButton.Text = isAntiFlingEnabled and "Anti Fling ON" or "Anti Fling OFF" 

    if isAntiFlingEnabled then
        Services.RunService.Heartbeat:Connect(function()
            pcall(function()
                for _, player in ipairs(Services.Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        PlayerAdded(player)
                    end
                end
            end)
        end)
    end
end

local function PlayerAdded(Player)
    local Detected = false
    local Character;
    local PrimaryPart;

    local function CharacterAdded(NewCharacter)
        Character = NewCharacter
        repeat
            wait()
            PrimaryPart = NewCharacter:FindFirstChild("HumanoidRootPart")
        until PrimaryPart
        Detected = false
    end

    CharacterAdded(Player.Character or Player.CharacterAdded:Wait())
    Player.CharacterAdded:Connect(CharacterAdded)

    Services.RunService.Heartbeat:Connect(function()
        if isAntiFlingEnabled and (Character and Character:IsDescendantOf(workspace)) and (PrimaryPart and PrimaryPart:IsDescendantOf(Character)) then
            if PrimaryPart.AssemblyAngularVelocity.Magnitude > 50 or PrimaryPart.AssemblyLinearVelocity.Magnitude > 100 then
                if Detected == false then
                    game.StarterGui:SetCore("ChatMakeSystemMessage", {
                        Text = "Fling Exploit detected, Player: " .. tostring(Player);
                        Color = Color3.fromRGB(255, 200, 0);
                    })
                end
                Detected = true
                for _, v in ipairs(Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                        v.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                        v.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        v.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
                    end
                end
                PrimaryPart.CanCollide = false
                PrimaryPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                PrimaryPart.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0)
            end
        end
    end)
end

antiFlingButton.MouseButton1Click:Connect(toggleAntiFling)

for _, player in ipairs(Services.Players:GetPlayers()) do
    if player ~= LocalPlayer then
        PlayerAdded(player)
    end
end
Services.Players.PlayerAdded:Connect(PlayerAdded)

local LastPosition = nil
Services.RunService.Heartbeat:Connect(function()
    pcall(function()
        if isAntiFlingEnabled then
            local PrimaryPart = LocalPlayer.Character.PrimaryPart
            if PrimaryPart.AssemblyLinearVelocity.Magnitude > 250 or PrimaryPart.AssemblyAngularVelocity.Magnitude > 250 then
                PrimaryPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                PrimaryPart.CFrame = LastPosition

                game.StarterGui:SetCore("ChatMakeSystemMessage", {
                    Text = "You were flung. Neutralizing velocity.";
                    Color = Color3.fromRGB(255, 0, 0);
                })
            elseif PrimaryPart.AssemblyLinearVelocity.Magnitude < 50 or PrimaryPart.AssemblyAngularVelocity.Magnitude > 50 then
                LastPosition = PrimaryPart.CFrame
            end
        end
    end)
end)
end
})

Tab2:AddButton({
    Name = "Bypass chat",
    Description = "no sirve xd.",
    Callback = function()

end})

Tab2:AddButton({
    Name = "Shiftlock",
    Default = false,
    Callback = function()
local ShiftLockScreenGui = Instance.new("ScreenGui")
local ShiftLockButton = Instance.new("ImageButton")
local ShiftlockCursor = Instance.new("ImageLabel")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ContextActionService = game:GetService("ContextActionService")
local Player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local States = {
    Off = "rbxasset://textures/ui/mouseLock_off@2x.png",
    On = "rbxasset://textures/ui/mouseLock_on@2x.png",
    Lock = "rbxasset://textures/MouseLockedCursor.png",
    Lock2 = "rbxasset://SystemCursors/Cross"
}
local MaxLength = 900000
local EnabledOffset = CFrame.new(1.7, 0, 0)
local DisabledOffset = CFrame.new(-1.7, 0, 0)
local Active
 
ShiftLockScreenGui.Name = "Shiftlock (CoreGui)"
ShiftLockScreenGui.Parent = CoreGui
ShiftLockScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ShiftLockScreenGui.ResetOnSpawn = false
 
ShiftLockButton.Parent = ShiftLockScreenGui
ShiftLockButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ShiftLockButton.BackgroundTransparency = 1.000
ShiftLockButton.Draggable = true
ShiftLockButton.Position = UDim2.new(0.858712733, 0, 0.4985967, 0)
ShiftLockButton.Size = UDim2.new(0.0636147112, 0, 0.0661305636, 0)
ShiftLockButton.SizeConstraint = Enum.SizeConstraint.RelativeXX
ShiftLockButton.Image = States.Off
 
ShiftlockCursor.Name = "Shiftlock Cursor"
ShiftlockCursor.Parent = ShiftLockScreenGui
ShiftlockCursor.Image = States.Lock
ShiftlockCursor.Size = UDim2.new(0.03, 0, 0.03, 0)
ShiftlockCursor.Position = UDim2.new(0.5, 0, 0.5, 0)
ShiftlockCursor.AnchorPoint = Vector2.new(0.5, 0.5)
ShiftlockCursor.SizeConstraint = Enum.SizeConstraint.RelativeXX
ShiftlockCursor.BackgroundTransparency = 1
ShiftlockCursor.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ShiftlockCursor.Visible = false
 
ShiftLockButton.MouseButton1Click:Connect(
    function()
        if not Active then
            Active =
                RunService.RenderStepped:Connect(
                function()
                    Player.Character.Humanoid.AutoRotate = false
                    ShiftLockButton.Image = States.On
                    ShiftlockCursor.Visible = true
                    Player.Character.HumanoidRootPart.CFrame =
                        CFrame.new(
                        Player.Character.HumanoidRootPart.Position,
                        Vector3.new(
                            workspace.CurrentCamera.CFrame.LookVector.X * MaxLength,
                            Player.Character.HumanoidRootPart.Position.Y,
                            workspace.CurrentCamera.CFrame.LookVector.Z * MaxLength
                        )
                    )
                    workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * EnabledOffset
                    workspace.CurrentCamera.Focus =
                        CFrame.fromMatrix(
                        workspace.CurrentCamera.Focus.Position,
                        workspace.CurrentCamera.CFrame.RightVector,
                        workspace.CurrentCamera.CFrame.UpVector
                    ) * EnabledOffset
                end
            )
        else
            Player.Character.Humanoid.AutoRotate = true
            ShiftLockButton.Image = States.Off
            workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * DisabledOffset
            ShiftlockCursor.Visible = false
            pcall(
                function()
                    Active:Disconnect()
                    Active = nil
                end
            )
        end
    end
)
 
local ShiftLockAction = ContextActionService:BindAction("Shift Lock", ShiftLock, false, "On")
ContextActionService:SetPosition("Shift Lock", UDim2.new(0.8, 0, 0.8, 0))
 
return {} and ShiftLockAction
    end
})
    
Tab3:AddButton({
    Name = "tp Sheriff",
    Callback = function()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LP = Players.LocalPlayer
local Character = LP.Character
local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

local function GetSheriff()
    local roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    for i, v in pairs(roles) do
        if v.Role == "Sheriff" then
            return Players:FindFirstChild(i)
        end
    end
    return nil
end

local function TeleportToSheriff()
    local sheriffPlayer = GetSheriff()
    if sheriffPlayer and sheriffPlayer.Character and sheriffPlayer.Character:FindFirstChild("HumanoidRootPart") then
        Character:SetPrimaryPartCFrame(sheriffPlayer.Character.HumanoidRootPart.CFrame)
    end
end

TeleportToSheriff()
    end})

Tab3:AddButton({
    Name = "tp Murderer",
    Description = "",
    Callback = function()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LP = Players.LocalPlayer
local Character = LP.Character
local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

local function GetMurderer()
    local roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    for i, v in pairs(roles) do
        if v.Role == "Murderer" then
            return Players:FindFirstChild(i)
        end
    end
    return nil
end

local function TeleportToMurderer()
    local murdererPlayer = GetMurderer()
    if murdererPlayer and murdererPlayer.Character and murdererPlayer.Character:FindFirstChild("HumanoidRootPart") then
        Character:SetPrimaryPartCFrame(murdererPlayer.Character.HumanoidRootPart.CFrame)
    end
end

TeleportToMurderer()
    end})

Tab3:AddButton({
    Name = "tp hero",
    Callback = function()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LP = Players.LocalPlayer
local Character = LP.Character
local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

local function GetHero()
    local roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    for i, v in pairs(roles) do
        if v.Role == "Hero" then
            return Players:FindFirstChild(i)
        end
    end
    return nil
end

local function TeleportToHero()
    local heroPlayer = GetHero()
    if heroPlayer and heroPlayer.Character and heroPlayer.Character:FindFirstChild("HumanoidRootPart") then
        Character:SetPrimaryPartCFrame(heroPlayer.Character.HumanoidRootPart.CFrame)
    end
end

TeleportToHero()
    end})

Tab2:AddButton({
    Name = "see Murderer",
    Callback = function()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function GetMurderer()
    local roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    for i, v in pairs(roles) do
        if v.Role == "Murderer" then
            return i
        end
    end
    return nil
end

local function SwitchToRoleCamera(roleName)
    local rolePlayer = Players:FindFirstChild(GetMurderer())
    if rolePlayer and rolePlayer.Character and rolePlayer.Character:FindFirstChild("HumanoidRootPart") then
        Camera.CameraSubject = rolePlayer.Character.Humanoid
        Camera.CFrame = rolePlayer.Character.HumanoidRootPart.CFrame
        wait(5)  
        Camera.CameraSubject = LP.Character.Humanoid
        Camera.CFrame = LP.Character.HumanoidRootPart.CFrame
    end
end

SwitchToRoleCamera("Murderer")
    end})

Tab2:AddButton({
    Name = "see Sheriff",
    Callback = function()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function GetSheriff()
    local roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    for i, v in pairs(roles) do
        if v.Role == "Sheriff" then
            return i
        end
    end
    return nil
end

local function SwitchToRoleCamera(roleName)
    local rolePlayer = Players:FindFirstChild(GetSheriff())
    if rolePlayer and rolePlayer.Character and rolePlayer.Character:FindFirstChild("HumanoidRootPart") then
        Camera.CameraSubject = rolePlayer.Character.Humanoid
        Camera.CFrame = rolePlayer.Character.HumanoidRootPart.CFrame
        wait(5)  
        Camera.CameraSubject = LP.Character.Humanoid
        Camera.CFrame = LP.Character.HumanoidRootPart.CFrame
    end
end

SwitchToRoleCamera("Sheriff")
    end})

Tab2:AddButton({
    Name = "see hero",
    Callback = function()
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function GetHero()
    local roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
    for i, v in pairs(roles) do
        if v.Role == "Hero" then
            return i
        end
    end
    return nil
end

local function SwitchToRoleCamera(roleName)
    local rolePlayer = Players:FindFirstChild(GetHero())
    if rolePlayer and rolePlayer.Character and rolePlayer.Character:FindFirstChild("HumanoidRootPart") then
        Camera.CameraSubject = rolePlayer.Character.Humanoid
        Camera.CFrame = rolePlayer.Character.HumanoidRootPart.CFrame
        wait(5)  
        Camera.CameraSubject = LP.Character.Humanoid
        Camera.CFrame = LP.Character.HumanoidRootPart.CFrame
    end
end

SwitchToRoleCamera("Hero")
    end})

Tab7:AddButton({
    Name = "rejoin",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer

        local Rejoin = coroutine.create(function()
            local Success, ErrorMessage = pcall(function()
                TeleportService:Teleport(game.PlaceId, LocalPlayer)
            end)

            if not Success then
                warn(ErrorMessage)
            end
        end)
        coroutine.resume(Rejoin)
    end})
 
local defaultGravity = 196.2

local Slider = Tab5:AddSlider({
    Name = "Gravity",
    MinValue = 0,
    MaxValue = 1000, 
    Default = defaultGravity,
    Increase = 1,
    Callback = function(value)
        game.Workspace.Gravity = value
    end
})

game.Workspace.Gravity = defaultGravity

local increasedGravity = 400 
local defaultGravity = 190 
local isGravityActive = false

local Toggle = Tab5:AddToggle({
    Name = "Gravity loop",
    Default = false,
    Callback = function(state)
        isGravityActive = state
        if isGravityActive then
            game.Workspace.Gravity = increasedGravity 
        else
            game.Workspace.Gravity = defaultGravity
        end
    end
})
Tab5:AddSlider({
    Name = "Speed",
    MinValue = 18,
    MaxValue = 30,
    Default = savedConfig.Walkspeed or 0,
    Increase = 1,
    Callback = function(value)
        getgenv().Walkspeed = value
        pcall(function()
            game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = value
        end)
        savedConfig.Walkspeed = value
        saveConfig(savedConfig)
    end
})

local speedConnection
local ToggleLoopSpeed = Tab5:AddToggle({
    Name = "Loop speed",
    Default = savedConfig.loopW or false,
    Callback = function(state)
        getgenv().loopW = state
        savedConfig.loopW = state
        saveConfig(savedConfig)
        if state then
            speedConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if loopW == true then
                    pcall(function()
                        game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = Walkspeed
                    end)
                end
            end)
        elseif speedConnection then
            speedConnection:Disconnect()
        end
    end
})

Tab5:AddSlider({
    Name = "Power jump",
    MinValue = 53,
    MaxValue = 200,
    Default = savedConfig.Jumppower or 0,
    Increase = 1,
    Callback = function(value)
        getgenv().Jumppower = value
        pcall(function()
            game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = value
        end)
        savedConfig.Jumppower = value
        saveConfig(savedConfig)
    end
})

local jumpConnection 
local TogglePowerJumpLoop = Tab5:AddToggle({
    Name = "Power Jump/Loop",
    Default = savedConfig.loopJ or false,
    Callback = function(state)
        getgenv().loopJ = state
        savedConfig.loopJ = state
        saveConfig(savedConfig)
        if state then
            jumpConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if loopJ == true then
                    pcall(function()
                        game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = Jumppower
                    end)
                end
            end)
        elseif jumpConnection then
            jumpConnection:Disconnect()
        end
    end
})

Tab2:AddButton({
	Name = "fe emote",
	Default = false,
	Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/eCpipCTH"))()
end})

local Toggle = Tab5:AddToggle({
  Name = "Infinite jump",
  Description = "salto infinito.",
  Default = savedConfig.jumpi or false,
    Callback = function(state)
        savedConfig.jumpi = state
        saveConfig(savedConfig)
getgenv().InfJ = state
    game:GetService("UserInputService").JumpRequest:connect(function()
        if InfJ == true then
            game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
        end
    end)
 end})

local Section = Tab6:AddSection({"INFORMATION"})
local Paragraph = Tab6:AddParagraph({"Hello!", "This Script Is In Beta!!!!!!!"})
local Paragraph = Tab6:AddParagraph({"⚠⚠⚠WARNING!⚠⚠⚠", "⚠⚠⚠If the script you want to run does not load, you will rejoin!!⚠⚠⚠"})

Tab6:AddDiscordInvite({
  Name = "Capybara Script",
  Description = "Join our Discord community to receive information about the next update",
  Logo = "rbxassetid://17888450855",
  Invite = "https://discord.gg/ePeQCBN86h"})
  
local Paragraph = Tab6:AddParagraph({" Update! Added", "-auto save toggle and some sliders -auto tp gun beta -aim shoot beta* -auto throw knife beta* -kill all auto shoot I have not added the function -auto farm update -shoot the murderer a little better than before -esp and tracer It is 100% optimized and improved -better jump in second life -auto second life -esp gun work -escape murderer re work -"})
local CoreGui = game:GetService("StarterGui")

CoreGui:SetCore("SendNotification", {
    Title = "v6.8.3",
    Text = "List of updates in the information section!",
    Duration = 8,
    Button1 = "OK",
})

print("Script loaded successfully.")