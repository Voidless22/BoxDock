local mq                       = require('mq')
local imgui                    = require('ImGui')
local settingsWnd              = require('settingsWnd')
local data                     = require('data')
local editor                   = require('editor')
local defaultLayout            = require('defaultLayout')
local dockModules              = require('dockModules')
local gui                      = {}

gui.showGui, gui.openGui       = true, true
gui.ShowEditor, gui.OpenEditor = false, false

local window_flags             = 0
local no_titlebar              = true
local no_scrollbar             = true
local no_resize                = false
if no_titlebar then window_flags = bit32.bor(window_flags, ImGuiWindowFlags.NoTitleBar) end
if no_scrollbar then window_flags = bit32.bor(window_flags, ImGuiWindowFlags.NoScrollbar) end
if no_resize then window_flags = bit32.bor(window_flags, ImGuiWindowFlags.NoResize) end

local charWnd = {}
gui.Layout = {}



function gui.LoadDefaultLayout(source, dest)
    for key, value in pairs(source) do
        if type(value) == 'table' then
            printf('New SubTable: %s', key)
            dest[key] = {}
            gui.LoadDefaultLayout(value, dest[key])
        else
            printf("Key: %s Value: %s", key, value)
            dest[key] = value
        end
    end
end

function gui.CreateGuiEntry(name)
    charWnd[name] = { Open = true, Show = true }
    gui.Layout[name] = {}
    gui.LoadDefaultLayout(defaultLayout, gui.Layout[name])
end

local function getFilePath(fileName)
    local filePath = debug.getinfo(1, 'S').short_src

    print(filePath)
    local path = filePath:gsub("gui.lua", fileName)

    return path
end

local BDTexFile = getFilePath('icon.png')
local BDTex = mq.CreateTexture(BDTexFile)



local function DrawDock(charName)
    local charData = data.charData[charName]
    ImGui.SetWindowSize(ImVec2(gui.Layout[charName].Window.Size.w, gui.Layout[charName].Window.Size.h))
    if charData.Info ~= nil then
        dockModules.Info(gui.Layout[charName], charData)
    end
    if charData.Stats ~= nil then
        dockModules.Stats(gui.Layout[charName], charData)
    end
    if charData.Buffs ~= nil then
        dockModules.Buffs(gui.Layout[charName], charData)
    end
    if charData.Spellbar ~= nil then
        dockModules.Spellbar(gui.Layout[charName], charData)
    end
    if charData.Target ~= nil then
        dockModules.Target(gui.Layout[charName], charData)
    end
    if charData.Group ~= nil then
        dockModules.Group(gui.Layout[charName], charData)
    end
    dockModules.Hotbar(gui.Layout[charName], charData)
end

local function DrawBDButton()
    ImGui.SetWindowSize(64, 64)
    ImGui.SetCursorPos(0, 0)
    if BDTex then
        ImGui.Image(BDTex:GetTextureID(), BDTex.size, ImVec2(0, 0), ImVec2(1, 1))
        ImGui.SetCursorPos(8, 8)
        local Button = ImGui.InvisibleButton("Editor", ImVec2(48, 48))
        if Button then
            gui.OpenEditor = not gui.OpenEditor
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
    if gui.OpenEditor then
        gui.OpenEditor, gui.ShowEditor = ImGui.Begin('Editor', gui.OpenEditor)
        if gui.OpenEditor then
            editor.DrawEditorWindow()
        end
        ImGui.End()
    end
    for index, value in pairs(charWnd) do
        if value.Open then
            value.Open, value.Show = ImGui.Begin(index .. '-BD', value.Show, window_flags)
            if value.Open then
                DrawDock(index)
            end
            ImGui.End()
        end
    end
end

return gui
