local mq = require('mq')
local msgHandler = require('msgHandler')
local utils = require('utils')
local data = require('data')
local Running = true
local boxName = mq.TLO.Me.Name()

local function RefreshData()
    local dataTable = data.charData[mq.TLO.Me.Name()]
    -- HP
    if data.Refresh(mq.TLO.Me.PctHPs(), dataTable.Stats.HP) then
        print('sending update')
        dataTable.Stats.HP = mq.TLO.Me.PctHPs()
        utils.boxActor:send(msgHandler.driverAddress,
            { id = 'Data-Refresh', dataType = 'Stats-HP', newData = mq.TLO.Me.PctHPs(), boxName = boxName })
    end
    -- Mana
    if data.Refresh(mq.TLO.Me.PctMana(), dataTable.Stats.Mana) then
        dataTable.Stats.Mana = mq.TLO.Me.PctMana()
        utils.boxActor:send(msgHandler.driverAddress,
            { id = 'Data-Refresh', dataType = "Stats-Mana", newData = mq.TLO.Me.PctMana(), boxName = boxName })
    end
    -- Endurance
    if data.Refresh(mq.TLO.Me.PctEndurance(), dataTable.Stats.End) then
        dataTable.Stats.End = mq.TLO.Me.PctEndurance()
        utils.boxActor:send(msgHandler.driverAddress,
            { id = 'Data-Refresh', dataType = "Stats-End", newData = mq.TLO.Me.PctEndurance(), boxName = boxName })
    end
    -- Target Id
    if data.Refresh(mq.TLO.Target.ID(), dataTable.Target.Id) then
        dataTable.Target.Id = mq.TLO.Target.ID()
        utils.boxActor:send(msgHandler.driverAddress,
            { id = 'Data-Refresh', dataType = 'Target Id', newData = mq.TLO.Target.ID(), boxName = boxName })
        -- clear our target buffs if we have no target
        if dataTable.Target.Id == 0 then
            for i = 1, #dataTable.Target.Buffs do
                dataTable.Target.Buffs[i] = 0
                printf('No Target, Clearing Buff Slot %i', i)
            end
        end
    end
    if data.Refresh(mq.TLO.Target.ConColor, dataTable.Target.ConColor) then
        dataTable.Target.ConColor = mq.TLO.Target.ConColor() or 0 
        utils.boxActor:send(msgHandler.driverAddress,
        { id = 'Data-Refresh', dataType = 'Target-ConColor', newData =   dataTable.Target.ConColor, boxName = boxName })
    end
    -- Target Buffs
    if dataTable.Target.Id ~= (0 or nil) and dataTable.Target.Buffs ~= nil then
        for i = 0, (mq.TLO.Target.BuffCount() or 0) do
            if data.Refresh(mq.TLO.Target.Buff(i).Spell.ID(), dataTable.Target.Buffs[i]) then
                dataTable.Target.Buffs[i] = mq.TLO.Target.Buff(i).Spell.ID()
                utils.boxActor:send(msgHandler.driverAddress,
                    {
                        id = 'Data-Refresh',
                        dataType = 'Target Buff',
                        subIndex = i,
                        newData = mq.TLO.Target.Buff(i).ID(),
                        boxName =
                            boxName
                    })
            end
        end
    end
    -- Spellbar
    for i = 1, mq.TLO.Me.NumGems() do
        if data.Refresh((mq.TLO.Me.Gem(i).ID() or 0), dataTable.Spellbar[i]) then
            dataTable.Spellbar[i] = mq.TLO.Me.Gem(i).ID() or 0
            print('Sending spellbar update')
            utils.boxActor:send(msgHandler.driverAddress,
                {
                    id = 'Data-Refresh',
                    dataType = 'Spellbar',
                    newData = mq.TLO.Me.Gem(i).ID() or 0,
                    boxName = boxName,
                    subIndex = i
                })
        end
    end
    -- Buffs
    for i = 0, (mq.TLO.Me.BuffCount() or 0) do
        if data.Refresh(mq.TLO.Me.Buff(i).Spell.ID(), dataTable.Buffs[i]) then
            dataTable.Buffs[i] = mq.TLO.Me.Buff(i).Spell.ID()
            mq.delay(10)
            utils.boxActor:send(msgHandler.driverAddress,
                {
                    id = 'Data-Refresh',
                    dataType = 'Buff',
                    subIndex = i,
                    newData = mq.TLO.Me.Buff(i).Spell.ID(),
                    boxName =
                        boxName
                })
        end
    end
end


local function Connect()
    while not msgHandler.CheckConnected() do
        print('Searching for a driver....')
        utils.boxActor:send(msgHandler.driverAddress, { id = 'Driver-Search', boxName = boxName })
        mq.delay('1s')
    end

    if msgHandler.CheckConnected() then
        data.InitializeData()
        mq.delay('30s', data.isDataInitialized)
        utils.boxActor:send(msgHandler.driverAddress,
            { id = 'Data-Init', boxName = boxName, data = data.GetData(mq.TLO.Me.Name()) })
        print('Sending data initialization to driver.')
    end
end



local function main()
    while Running do
        RefreshData()

        mq.delay(10)
    end
end



Connect()


main()
