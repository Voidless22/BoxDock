local mq = require('mq')
local msgHandler = require('msgHandler')
local actors = require('actors')

local utils = {}

utils.driverActor = actors.register('Driver', msgHandler.driverMessageHandler)
utils.boxActor = actors.register('Box', msgHandler.boxMessageHandler)



return utils