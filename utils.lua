local mq = require('mq')
local msgHandler = require('msgHandler')
local actors = require('actors')

local utils = {}

utils.driverActor = actors.register('Driver', msgHandler.driverMessageHandler)
utils.boxActor = actors.register('Box', msgHandler.boxMessageHandler)

function utils.split(inputstr, sep)
    if sep == nil then
        sep = "%s"
      end
      local t = {}
      for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
      end
      return t
end

return utils