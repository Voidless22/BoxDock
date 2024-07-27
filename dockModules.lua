local mq = require('mq')
local imgui = require('ImGui')

local dockModules = {}

local colors = {
    ['Grey'] = ImVec4(0.42, 0.47, 0.53, 1),
    ['Green'] = ImVec4(0, 1, 0, 1),
    ['Light Blue'] = ImVec4(0, 0.7, 0.8, 1),
    ['Blue'] = ImVec4(0, 0, 1, 1),
    ["White"] = ImVec4(1, 1, 1, 1),
    ['Yellow'] = ImVec4(1, 1, 0, 1),
    ['Red'] = ImVec4(1, 0, 0, 1)
}

local function ConColorToImVec4(color)
    if color == "GREY" then
        return colors['Grey']
    elseif color == "GREEN" then
        return colors['Green']
    elseif color == "LIGHT BLUE" then
        return colors['Light Blue']
    elseif color == "BLUE" then
        return colors["Blue"]
    elseif color == "WHITE" then
        return colors["White"]
    elseif color == "YELLOW" then
        return colors["Yellow"]
    elseif color == "RED" then
        return colors["Red"]
    end
end

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
            if layout.Info.Name.Loc.x == "Center" then
                local wndWidth = ImGui.GetWindowSize()
                local textWidth = ImGui.CalcTextSize(data.Info.Name)

                ImGui.SetCursorPos(((wndWidth - textWidth) * 0.5), layout.Info.Name.Loc.y)
            else
                ImGui.SetCursorPos(layout.Info.Name.Loc.x, layout.Info.Name.Loc.y)
            end

            ImGui.TextColored(layout.Info.Name.Color, data.Info.Name)
        end
        if layout.Info.Class.Enabled then
            if layout.Info.Class.Loc.x == "Center" then
                local wndWidth = ImGui.GetWindowSize()
                local textWidth = ImGui.CalcTextSize(data.Info.Class)
                ImGui.SetCursorPos(((wndWidth - textWidth) * 0.5), layout.Info.Class.Loc.y)
            else
                ImGui.SetCursorPos(layout.Info.Class.Loc.x, layout.Info.Class.Loc.y)
            end
            ImGui.TextColored(layout.Info.Class.Color, data.Info.Class)
        end
        if layout.Info.Race.Enabled then
            if layout.Info.Race.Loc.x == "Center" then
                local wndWidth = ImGui.GetWindowSize()
                local textWidth = ImGui.CalcTextSize(data.Info.Race)
                ImGui.SetCursorPos(((wndWidth - textWidth) * 0.5), layout.Info.Race.Loc.y)
            else
                ImGui.SetCursorPos(layout.Info.Race.Loc.x, layout.Info.Race.Loc.y)
            end
            ImGui.TextColored(layout.Info.Race.Color, data.Info.Race)
        end
    end
end

local animSpellIcons = mq.FindTextureAnimation('A_SpellIcons')
local gemBG = mq.FindTextureAnimation('A_SpellGemBackground')
function dockModules.Buffs(layout, data)
    if not layout.Buffs.Enabled then
        return
    else
        ImGui.SetCursorPos(layout.Buffs.Loc.x, layout.Buffs.Loc.y)
        local buffSpace = { w = layout.Buffs.TotalWndSpace.w, h = layout.Buffs.TotalWndSpace.h }
        local columnCount = math.floor(buffSpace.w / layout.Buffs.BuffIconSize)
        local currentColumn = 1
        local currentRow = 1
        ImGui.Text("Buffs")
        ImGui.SetCursorPos(layout.Buffs.Loc.x, (layout.Buffs.Loc.y + ImGui.CalcTextSizeVec('Buffs').y))
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

function dockModules.Spellbar(layout, data)
    if not layout.Spellbar.Enabled then
        return
    else
        local orientation = layout.Spellbar.Orientation
        if orientation == "Horizontal" or orientation == "Vertical" then
            for i = 1, #data.Spellbar do
                local layoutData = layout.Spellbar.Orientations[orientation][i]
                if layoutData.Enabled then
                    ImGui.SetCursorPos(layoutData.Loc.x, layoutData.Loc.y)
                    -- if there's no spell
                    if data.Spellbar[i] == 0 then
                        ImGui.DrawTextureAnimation(gemBG, layoutData.Size, layoutData.Size)
                    else
                        animSpellIcons:SetTextureCell(mq.TLO.Spell(data.Spellbar[i]).SpellIcon())
                        ImGui.DrawTextureAnimation(animSpellIcons, layout.Spellbar.GemSize, layout.Spellbar.GemSize)
                    end
                end
            end
        elseif orientation == "WndSpace" then
            ImGui.SetCursorPos(layout.Spellbar.WndSpaceStartLoc.x, layout.Spellbar.WndSpaceStartLoc.y)

            local spellbarSpace = { w = layout.Spellbar.TotalWndSpace.w, h = layout.Spellbar.TotalWndSpace.h }
            local columnCount = math.floor(spellbarSpace.w / layout.Spellbar.GemSize)
            local currentColumn = 1
            local currentRow = 1
            for i = 1, #data.Spellbar do
                if data.Spellbar[i] ~= 0 then
                    animSpellIcons:SetTextureCell(mq.TLO.Spell(data.Spellbar[i]).SpellIcon())
                    if currentColumn < columnCount then
                        local prevX = ImGui.GetCursorPosX()
                        local prevY = ImGui.GetCursorPosY()
                        ImGui.DrawTextureAnimation(animSpellIcons, layout.Spellbar.GemSize, layout.Spellbar.GemSize)
                        ImGui.SetCursorPosX(prevX + layout.Spellbar.GemSize)
                        ImGui.SetCursorPosY(prevY)
                        currentColumn = currentColumn + 1
                    elseif currentColumn >= columnCount then
                        local prevY = ImGui.GetCursorPosY()
                        ImGui.DrawTextureAnimation(animSpellIcons, layout.Spellbar.GemSize, layout.Spellbar.GemSize)
                        ImGui.SetCursorPosX(layout.Spellbar.WndSpaceStartLoc.x)
                        ImGui.SetCursorPosY(prevY + layout.Spellbar.GemSize)
                        currentRow = currentRow + 1
                        currentColumn = 1
                    end
                end
            end
        end
    end
end

function dockModules.Target(layout, data)
    if not layout.Target.Enabled then
        return
    else
        if layout.Target.NameText and data.Target.Id ~= 0 and data.Target.ConColor ~= 0 then
            ImGui.SetCursorPos((layout.Window.Size.w - layout.Target.WndSpace.w), layout.Target.Loc.y)
            if ImGui.CalcTextSize(mq.TLO.Spawn(data.Target.Id).CleanName()) > layout.Target.WndSpace.w then
                ImGui.SetCursorPos(
                    (layout.Window.Size.w - ImGui.CalcTextSize(mq.TLO.Spawn(data.Target.Id).CleanName()) - 5),
                    layout.Target.Loc.y)
            end
            local conColor = ConColorToImVec4(data.Target.ConColor)
            ImGui.TextColored(conColor, mq.TLO.Spawn(data.Target.Id).CleanName())
            ImGui.SetCursorPosX(layout.Window.Size.w - layout.Target.WndSpace.w)
            ImGui.SetCursorPosY(ImGui.GetCursorPosY() + 4)
            ImGui.PushStyleColor(ImGuiCol.PlotHistogram, layout.Target.Color)
            local hpRatio = (mq.TLO.Spawn(data.Target.Id).PctHPs() / 100) or 0
            ImGui.ProgressBar(hpRatio,
                ImVec2(layout.Target.Size.w,
                    layout.Target.Size.h))
            
            if layout.Target.Buffs.Enabled then
                ImGui.SetCursorPos(layout.Target.Buffs.Loc.x, layout.Target.Buffs.Loc.y)
                local buffSpace = { w = layout.Target.Buffs.WndSpace.w, h = layout.Target.Buffs.WndSpace.h }
                local columnCount = math.floor(buffSpace.w / layout.Target.Buffs.IconSize)
                local currentColumn = 1
                local currentRow = 1
                ImGui.SetCursorPos(layout.Target.Buffs.Loc.x, layout.Target.Buffs.Loc.y)
                for index, value in ipairs(data.Target.Buffs) do
                    if value ~= 0 then
                        animSpellIcons:SetTextureCell(mq.TLO.Spell(value).SpellIcon())
                        if currentColumn < columnCount then
                            local prevX = ImGui.GetCursorPosX()
                            local prevY = ImGui.GetCursorPosY()
                            ImGui.DrawTextureAnimation(animSpellIcons, layout.Target.Buffs.IconSize, layout.Target.Buffs.IconSize)
                            ImGui.SetCursorPosX(prevX + layout.Target.Buffs.IconSize)
                            ImGui.SetCursorPosY(prevY)
                            currentColumn = currentColumn + 1
                        elseif currentColumn >= columnCount then
                            local prevY = ImGui.GetCursorPosY()
                            ImGui.DrawTextureAnimation(animSpellIcons, layout.Target.Buffs.IconSize, layout.Target.Buffs.IconSize)
                            ImGui.SetCursorPosX(layout.Target.Buffs.Loc.x)
                            ImGui.SetCursorPosY(prevY + layout.Target.Buffs.IconSize)
                            currentRow = currentRow + 1
                            currentColumn = 1
                        end
                    end
                end
            end
        end

    end
end

return dockModules
