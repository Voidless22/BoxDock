local mq = require('mq')
local actors = require('actors')
local gui = require('gui')
local utils = require('utils')
local Running = true

local function Main()
    while Running do
        mq.delay(10)
    end
end


mq.imgui.init('BoxDock', gui.GuiLoop)
Main()
