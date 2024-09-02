local mq = require('mq')
local data = {}
local isDataInitialized = false
data.charData = {}
-- driver function
function data.CreateEntry(charName)
    data.charData[charName] = {}
    printf('Data Table Entry Created for %s', charName)
end

local function returnIsCasting()
    if mq.TLO.Me.Casting() then
        return true
    else
        return false
    end
end

function data.InitializeHotbars(charName)
    -- type -1 means bar isn't open
    -- type 0 means empty button
    -- type 1: Melee/Range Atk (slot 0,1)
    -- Type 7: Spell Gem
    -- Type 8: Pet Command

    data.charData[charName].Hotbars = {}
    for hotbar = 1, 10 do
        data.charData[charName].Hotbars[hotbar] = {}
        for button = 1, 12 do
            if hotbar == 1 then
                data.charData[charName].Hotbars[hotbar][button] = {

                    Label = mq.TLO.Window('HotbuttonWnd/HB_Button' .. button).HotButton.Label(),
                    Type = mq.TLO.Window('HotbuttonWnd/HB_Button' .. button).HotButton.Type()
                }
            else
                data.charData[charName].Hotbars[hotbar][button] = {

                    Label = mq.TLO.Window('HotbuttonWnd' .. hotbar .. '/HB_Button' .. button).HotButton.Label(),
                    Type = mq.TLO.Window('HotbuttonWnd' .. hotbar .. '/HB_Button' .. button).HotButton.Type()
                }
            end
            printf("Hotbar: %i Button[%i]:\n Label: %s\n Type:%s", hotbar, button,
                data.charData[charName].Hotbars[hotbar][button].Label,
                data.charData[charName].Hotbars[hotbar][button].Type)
        end
    end
end

function data.Refresh(currentData, prevData)
    return currentData ~= prevData
end

function data.GetData(name)
    if name then
        return data.charData[mq.TLO.Me.Name()]
    else
        return data.charData
    end
end

-- box function
function data.InitializeData()
    data.CreateEntry(mq.TLO.Me.Name())
    local dataTable = data.charData[mq.TLO.Me.Name()]
    -- stat init
    dataTable.Stats = { HP = mq.TLO.Me.PctHPs(), Mana = mq.TLO.Me.PctMana(), End = mq.TLO.Me.PctEndurance() }
    dataTable.Info = { Name = mq.TLO.Me.Name(), Class = mq.TLO.Me.Class(), Race = mq.TLO.Me.Race() }
    -- Target
    dataTable.Target = { Id = mq.TLO.Target.ID(), Buffs = {} }
    dataTable.Target.Buffs = {}
    if dataTable.Target.Id ~= (nil or 0) then
        if mq.TLO.Target.BuffCount() > 0 then
            for i = 0, (mq.TLO.Target.BuffCount() or 0) do
                dataTable.Target.Buffs[i] = (mq.TLO.Target.Buff(i).Spell.ID() or 0)
            end
        else
            for i = 0, #dataTable.Target.Buffs do
                dataTable.Target.Buffs[i] = 0
                printf('No Target Buffs, Clearing Buff Slot %i', i)
            end
        end
    end
    dataTable.Target.ConColor = mq.TLO.Target.ConColor() or 0
    -- Spellbar
    dataTable.Spellbar = {}
    for i = 1, mq.TLO.Me.NumGems() do
        dataTable.Spellbar[i] = mq.TLO.Me.Gem(i).ID()
    end
    -- Buffs
    dataTable.Buffs = {}
    for i = 0, mq.TLO.Me.MaxBuffSlots() do
        dataTable.Buffs[i] = (mq.TLO.Me.Buff(i).Spell.ID() or 0)
    end

    dataTable.Sitting = mq.TLO.Me.Sitting()
    dataTable.isCasting = returnIsCasting()
    -- data.InitializeHotbars(mq.TLO.Me.Name())
    if dataTable.Group == nil then dataTable.Group = {} end
    for i = 0, mq.TLO.Group.GroupSize() or 0 do
        dataTable.Group[i] = {Id = mq.TLO.Group.Member(i).ID(), Name = mq.TLO.Group.Member(i).DisplayName()}
        
    end

    isDataInitialized = true
end

-- box function
function data.isDataInitialized()
    return isDataInitialized
end

-- driver function
function data.InitCharDataEntry(name, charData)
    if data.charData[name] == nil then
        data.CreateEntry(name)
    end
    data.charData[name] = charData
end

return data
