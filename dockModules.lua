local mq = require('mq')
local imgui = require('ImGui')

local dockModules = {}

function dockModules.Stats(layout, data)
    -- HP Bar
    if not layout.Stats.Enabled then
        return
    else
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
            local endRatio = (data.Stats.End / 100) or 0
            ImGui.SetCursorPos(layout.Stats.Endurance.Loc.x, layout.Stats.Endurance.Loc.y)
            ImGui.PushStyleColor(ImGuiCol.PlotHistogram, layout.Stats.Endurance.Color)
            ImGui.ProgressBar(endRatio, ImVec2(layout.Stats.Endurance.Size.w, layout.Stats.Endurance.Size.h))
        end
    end
end

function dockModules.Info(layout, data)
    if not layout.Info.Enabled then
        return
    else
        if layout.Info.Name.Enabled then
            ImGui.SetCursorPos(layout.Info.Name.Loc.x, layout.Info.Name.Loc.y)
            ImGui.TextColored(layout.Info.Name.Color, data.Info.Name)
        end
        if layout.Info.Class.Enabled then
            ImGui.SetCursorPos(layout.Info.Class.Loc.x, layout.Info.Class.Loc.y)
            ImGui.TextColored(layout.Info.Class.Color, data.Info.Class)
        end
        if layout.Info.Race.Enabled then
            ImGui.SetCursorPos(layout.Info.Race.Loc.x, layout.Info.Race.Loc.y)
            ImGui.TextColored(layout.Info.Race.Color, data.Info.Race)
        end
    end
end
local animSpellIcons = mq.FindTextureAnimation('A_SpellIcons')

function dockModules.Buffs(layout, data)
if  not layout.Buffs.Enabled then
    return
else
    ImGui.SetCursorPos(layout.Buffs.Loc.x, layout.Buffs.Loc.y)
    local buffSpace = {w=layout.Buffs.TotalWndSpace.w, h=layout.Buffs.TotalWndSpace.h}
    local columnCount = math.floor(buffSpace.w / layout.Buffs.BuffIconSize)
    local currentColumn = 1
    local currentRow = 1
    for index, value in ipairs(data.Buffs) do
        if value ~= 0 then
            animSpellIcons:SetTextureCell(mq.TLO.Spell(value).SpellIcon())
            if currentColumn < columnCount then
                local prevX = ImGui.GetCursorPosX()
                local prevY = ImGui.GetCursorPosY()
                ImGui.DrawTextureAnimation(animSpellIcons, layout.Buffs.BuffIconSize, layout.Buffs.BuffIconSize)
                ImGui.SetCursorPosX(prevX + layout.Buffs.BuffIconSize)
                ImGui.SetCursorPosY(prevY)
                currentColumn = currentColumn + 1
            elseif currentColumn >= columnCount then
                local prevY = ImGui.GetCursorPosY()
                ImGui.DrawTextureAnimation(animSpellIcons, layout.Buffs.BuffIconSize, layout.Buffs.BuffIconSize)
                ImGui.SetCursorPosX(layout.Buffs.Loc.x)
                ImGui.SetCursorPosY(prevY + layout.Buffs.BuffIconSize)
                currentRow = currentRow + 1
                currentColumn = 1
            end
        end
    end

end

end



return dockModules
