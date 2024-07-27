local mq = require('mq')
local imgui = require('ImGui')

local dockModules = {}

function dockModules.Stats(layout, data)
    -- HP Bar
    if not layout.Stats.Enabled then
        return
    else
        if layout.Stats.Name.Enabled then
            ImGui.SetCursorPos(layout.Stats.Name.Loc.x, layout.Stats.Name.Loc.y)
            ImGui.TextColored(layout.Stats.Name.Color, data.Name)
        end
        if layout.Stats.HP.Enabled then
            local hpRatio = (data.Stats.HP / 100) or 0
            ImGui.SetCursorPos(layout.Stats.HP.Loc.x, layout.Stats.HP.Loc.y)
            ImGui.PushStyleColor(ImGuiCol.PlotHistogram, layout.Stats.HP.Color)
            ImGui.ProgressBar(hpRatio, ImVec2(layout.Stats.HP.Size.w, layout.Stats.HP.Size.h))
        end
        if layout.Stats.Mana.Enabled then
            local manaRatio = (data.Stats.Mana / 100) or 0
            ImGui.SetCursorPos(layout.Stats.Mana.Loc.x, layout.Stats.Mana.Loc.y)
            ImGui.PushStyleColor(ImGuiCol.PlotHistogram, layout.Stats.Mana.Color)
            ImGui.ProgressBar(manaRatio, ImVec2(layout.Stats.Mana.Size.w, layout.Stats.Mana.Size.h))
        end
        if layout.Stats.Endurance.Enabled then
            local endRatio = (data.Stats.Endurance / 100) or 0
            ImGui.SetCursorPos(layout.Stats.Endurance.Loc.x, layout.Stats.Endurance.Loc.y)
            ImGui.PushStyleColor(ImGuiCol.PlotHistogram, layout.Stats.Endurance.Color)
            ImGui.ProgressBar(endRatio, ImVec2(layout.Stats.Endurance.Size.w, layout.Stats.Endurance.Size.h))
        end
    end
end



return dockModules
