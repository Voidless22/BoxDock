local mq                 = require('mq')
local data               = require('data')
local gui                = require('gui')
local defaultLayout = require('defaultLayout')
local msgHandler         = {}
msgHandler.connected     = false
msgHandler.boxAddress    = { mailbox = 'Box', script = 'boxdock/box' }
msgHandler.driverAddress = { mailbox = 'Driver', script = 'boxdock' }
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

local dataTable
function msgHandler.driverMessageHandler(message)
    local msgId = message.content.id
    if msgId == 'Driver-Search' then
        printf('Connection attempt from %s.', message.content.boxName)
        data.CreateEntry(message.content.boxName)
        gui.CreateGuiEntry(message.content.boxName)
        message:send({ id = 'Driver-Found' })
    end
    if msgId == 'Data-Init' then
        data.InitCharDataEntry(message.content.boxName, message.content.data)
        printf('Initializing data entries for %s', message.content.boxName)
        dataTable = data.GetData(message.content.boxName)
    end

    if msgId == 'Data-Refresh' then
        local boxName = message.content.boxName
        local dataType = message.content.dataType
        local newData = message.content.newData
        local subIndex = message.content.subIndex
        local charData = data.charData[boxName]
        -- HP
        if dataType == 'Stats-HP' then
            charData.Stats.HP = newData
            printf('HP Update (%s): %i ', boxName, newData)
        elseif dataType == 'Stats-Mana' then
            charData.Stats.Mana = newData
            printf('Mana Update (%s): %i', boxName, newData)
        elseif dataType == 'Stats-End' then
            charData.Stats.End = newData
            printf('Endurance Update (%s): %i', boxName, newData)
        elseif dataType == 'Spellbar' then
            print('recieved spellbar update')
            charData.Spellbar[subIndex] = newData
            printf('Spellbar Update (Gem %i): %s', subIndex, mq.TLO.Spell(newData).Name())
        elseif dataType == 'Target Id' then
            charData.Target.Id = newData
            printf('Target Update: %s', mq.TLO.Spawn(newData).Name())
            if charData.Target.Id == 0 then
                if charData.Target.Buffs then
                    for i = 1, #charData.Target.Buffs do
                        charData.Target.Buffs[i] = 0
                        printf('No Target, Clearing Buff Slot %i', i)
                    end
                end
            end
        elseif dataType == 'Target Buff' then
            if charData.Target.Buffs == nil then charData.Target.Buffs = {} end
            charData.Target.Buffs[subIndex] = newData
            printf('Target Buff Update(Slot: %i): %s', subIndex, mq.TLO.Spell(newData).Name())
        elseif dataType == 'Buff' then
            charData.Buffs[subIndex] = newData
            printf('Buff Update:(Slot: %i): %s', subIndex, mq.TLO.Spell(newData).Name())
        end
    end
end

function msgHandler.boxMessageHandler(message)
    local msgId = message.content.id
    if msgId == 'Driver-Found' then
        msgHandler.connected = true
    end
end

function msgHandler.CheckConnected()
    return msgHandler.connected
end

return msgHandler
