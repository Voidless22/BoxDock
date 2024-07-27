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

-- util that I can't put in utils because for some dumb reason my actors are stored there and require loops go brrr
local function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
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
        for i = 0, (mq.TLO.Target.BuffCount() or 0) do
            dataTable.Target.Buffs[i] = (mq.TLO.Target.Buff(i).ID() or 0)
        end
    end
    -- Spellbar
    dataTable.Spellbar = {}
    for i = 1, mq.TLO.Me.NumGems() do
        dataTable.Spellbar[i] = mq.TLO.Me.Gem(i).ID()
    end
    -- Buffs
    dataTable.Buffs = {}
    for i = 1, (mq.TLO.Me.BuffCount() or 1) do
        dataTable.Buffs[i] = mq.TLO.Me.Buff(i).Spell.ID() or 0
    end
    
    dataTable.Sitting = mq.TLO.Me.Sitting()
    dataTable.isCasting = returnIsCasting()

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
