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
    -- Target Buffs
    for i = 1, (mq.TLO.Target.BuffCount() or 1) do
        if data.Refresh(mq.TLO.Target.Buff(i).ID(), dataTable.Target.Buffs[i]) then
            dataTable.Target.Buffs[i] = mq.TLO.Target.Buff(i).ID()
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
    -- Spellbar
    for i = 1, mq.TLO.Me.NumGems() do
        if data.Refresh((mq.TLO.Me.Gem(i).ID() or 0), dataTable.Spellbar[i]) then
            dataTable.Spellbar[i] = mq.TLO.Me.Gem(i).ID()
            print('Sending spellbar update')
            utils.boxActor:send(msgHandler.driverAddress,
                {
                    id = 'Data-Refresh',
                    dataType = 'Spellbar',
                    newData = mq.TLO.Me.Gem(i).ID(),
                    boxName = boxName,
                    subIndex = i
                })
        end
    end
end





local function main()
    while Running do
        RefreshData()

        mq.delay(10)
    end
end



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


main()
