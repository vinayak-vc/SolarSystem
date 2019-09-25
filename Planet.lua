
Planet_Models = {}

Planet_Distance = {}
Planet_Timer = 0
Planet_PrePos = {}
NumOfPlanets = 9
local lineColour = {1, 0, 0}

Sun = nil
Mercury = nil
Venus = nil
Earth = nil
Mars = nil
Jupiter = nil
saturn = nil
neptune = nil
Uranus = nil

function Planet_Init(entityName, id, pos, scale)
  Planet_Destroy() -- reset
  
    -- Sets the zoom(scale) and position of the scene
  local worldScale = 8
  local holoDevice = Core_HoloDevice:Get()
  Scene.SetWorldPos({0,4, -holoDevice.heightOffset * worldScale})
  Scene.SetWorldScale(worldScale)

  local pathToModel = Scene.GetModelPath(id)
  local Planet_InitialModelPath = System.GetDirFromPath(pathToModel)
  Sun = Scene.GetEntityByName(entityName)
  local scale = 208
  Sun:SetPos({0,0,0})
  Sun:SetScale(scale)
  Sun:SetRevolving(true)

  local count = 1

--  staticSolarSystem = Scene.AddEntity(Military_InitialModelPath .. "/Models/Planet.FBX", {0,0,0}, {0,0,0}, 1)
 -- staticSolarSystem:Lock()
  
  -- Load models
  for modelIndex, model in ipairs(Planet_ModelList) do
      Planet_Models[model[1]] = Scene.AddEntity(Military_InitialModelPath .. model[2], model[3], model[4], model[5])
      Planet_Models[model[1]]:Lock()
      Planet_Models[model[1]]["OriginalPos"] = Planet_Models[model[1]]:GetPos()
      Planet_Models[model[1]]["OriginalScale"] = Planet_Models[model[1]]:GetScale()
      Planet_Models[model[1]]:SetRevolving(true)
    
      local labelText = Planet_Models[model[1]]["name"]
      local labelDescription = Planet_Models[model[1]]["name"]
      local labelMaxSize = 2
      local labelID = Scene.AddLabelWithDescription(labelText, labelDescription, {0, 0, 0})
      Scene.LabelMoveAndAttach(labelID, Planet_Models[model[1]]) 
      Scene.LabelSetMaxSize(labelID, labelMaxSize)
          
          if count == 1 then
            Mercury = Planet_Models[model[1]]
          elseif count == 2 then
            Venus = Planet_Models[model[1]]
          elseif count == 3 then
            Earth = Planet_Models[model[1]]
          elseif count == 4 then
            Mars = Planet_Models[model[1]]
          elseif count == 5 then
            Jupiter = Planet_Models[model[1]]
          elseif count == 6 then
            saturn = Planet_Models[model[1]]
         elseif count == 7 then
            neptune = Planet_Models[model[1]]
         elseif count == 8 then
            Uranus = Planet_Models[model[1]]
        end 
      
      count = count + 1
      
    
  end
   
   Planet_Timer = 0
end
   

  
function Planet_Destroy()
  -- Clean up
  DeleteEntities(Planet_Models)
  Planet_Models = {}
  Sun = nil
   
  Planet_Timer = 0
  Planet_Distance = {}
  Planet_PrePos = {}
  
end

function Planet_DeleteEntities(entityList)
  for id, entity in pairs(entityList) do
    entity:Remove()
  end
end

function Planet_Update(dt)
  -- Increment the timer
  Planet_Timer = Planet_Timer + dt

  MoveinCircle(Sun,Planet_Timer)
  MoveinCircle(Mercury,Planet_Timer)
  MoveinCircle(Venus,Planet_Timer)
  MoveinCircle(Earth,Planet_Timer)
  MoveinCircle(Mars,Planet_Timer)
  MoveinCircle(Jupiter,Planet_Timer)
  MoveinCircle(saturn,Planet_Timer)
  MoveinCircle(neptune,Planet_Timer)
  MoveinCircle(Uranus,Planet_Timer)
  
 -- X := originX + cos(angle)*radius;
 -- Y := originY + sin(angle)*radius;
  
  
end

function PrintPOS(model)
  
  posi = model:GetPos()
  currentpos = {posi[1] + }
  WriteToText(model["name"] .. " X => " ..posi[1] .. " Y => ".. posi[2] .. " Z => " .. posi[3])     
  
end
--[[
Sun = nil
Mercury = nil
Venus = nil
Earth = nil
Mars = nil
Jupiter = nil
saturn = nil
neptune = nil
Uranus = nil
]]--

TextFileName = "D:\\Log.txt"
file = io.open(TextFileName,"a")

function WriteToText(content)
    file:write("\n" .. content)
end

function MoveinCircle(mod , Example_Timer)
  local raptor  = mod
     -- Calculate the current position on the circle. This function can
  -- be found in Math.lua for further details
  local circle = MathCircle({0,0,0}, 1.4, 2, Example_Timer)
  -- Store the current direction the raptor is facing
  local curDir = raptor:GetDir()
  -- Updates the position of the raptor
  raptor:SetPos(circle[1])
  -- Sets the yaw component of the models direction
  curDir[1] = circle[2]
  raptor:SetDir(curDir)
end