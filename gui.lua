local mq                           = require('mq')
local imgui                        = require('ImGui')
local settingsWnd                  = require('settingsWnd')
local data                         = require('data')
local gui                          = {}

gui.showGui, gui.openGui           = true, true
gui.ShowSettings, gui.OpenSettings = false, false

local window_flags                 = 0
local no_titlebar                  = true
local no_scrollbar                 = true
local no_resize                    = false
if no_titlebar then window_flags = bit32.bor(window_flags, ImGuiWindowFlags.NoTitleBar) end
if no_scrollbar then window_flags = bit32.bor(window_flags, ImGuiWindowFlags.NoScrollbar) end
if no_resize then window_flags = bit32.bor(window_flags, ImGuiWindowFlags.NoResize) end

local charWnd = {}

local function getFilePath(fileName)
    local filePath = debug.getinfo(1, 'S').short_src

    print(filePath)
    local path = filePath:gsub("gui.lua", fileName)

    return path
end
local BDTexFile = getFilePath('icon.png')
local BDTex = mq.CreateTexture(BDTexFile)

function gui.CreateGuiEntry(name)
    charWnd[name] = { Open = true, Show = true }
end

local function DrawBDButton()
    ImGui.SetWindowSize(64, 64)
    ImGui.SetCursorPos(0, 0)
    if BDTex then

        ImGui.Image(BDTex:GetTextureID(), BDTex.size, ImVec2(0,0), ImVec2(1,1))
        ImGui.SetCursorPos(8,8)
       local Button= ImGui.InvisibleButton("Settings", ImVec2(48,48))
        if Button then
            gui.OpenSettings = not gui.OpenSettings
        end
        ImGui.OpenPopupOnItemClick("BD Menu")
        if ImGui.BeginPopup("BD Menu") then
            for index, value in pairs(charWnd) do
                if ImGui.MenuItem(index, nil, value.Open) then
                    value.Open = not value.Open
                end
            end
            ImGui.EndPopup()
        end
    end
end

function gui.GuiLoop()
    if gui.openGui then
        gui.openGui, gui.showGui = ImGui.Begin('BDButton', gui.showGui,
            bit32.bor(window_flags, ImGuiWindowFlags.NoResize, ImGuiWindowFlags.NoBackground))
        if gui.showGui and BDTex then
            DrawBDButton()
        end
        ImGui.End()
    end
    if gui.OpenSettings then
        gui.OpenSettings, gui.ShowSettings = ImGui.Begin('Settings', gui.OpenSettings)
        if gui.OpenSettings then
            --settingsWnd.DrawSettingsWindow()
        end
        ImGui.End()
    end
    for index, value in pairs(charWnd) do
        if value.Open then
            value.Open, value.Show = ImGui.Begin(index .. '-BD', value.Show, window_flags)
            if value.Open then

            end
            ImGui.End()
        end
    end
end

return gui
