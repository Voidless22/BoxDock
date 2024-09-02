local defaultLayout = {
}

defaultLayout.Window = {
    Size = { w = 512, h = 256 }
}
defaultLayout.Info = {
    Enabled = true,
    Name = {
        Enabled = true,
        Loc = { x = 5, y = 0 },
        Color = ImVec4(1, 1, 1, 1)
    },
    Class = {
        Enabled = true,
        Loc = { x = 5, y = 16 },
        Color = ImVec4(1, 1, 1, 1)
    },
    Race = {
        Enabled = true,
        Loc = { x = 5, y = 32 },
        Color = ImVec4(1, 1, 1, 1)
    }
}
defaultLayout.Stats = {
    Enabled = true,
    HP = {
        Enabled = true,
        Loc = { x = 5, y = 48 },
        Size = { w = 80, h = 16 },
        Color = ImVec4(1, 0, 0, 1)
    },
    Mana = {
        Enabled = true,
        Loc = { x = 5, y = 64 },
        Size = { w = 64, h = 16 },
        Color = ImVec4(0, 0, 1, 1)
    },
    Endurance = {
        Enabled = true,
        Loc = { x = 5, y = 80 },
        Size = { w = 48, h = 16 },
        Color = ImVec4(0, 0.5, 0.5, 1)
    },
}
defaultLayout.Buffs = {
    Enabled = true,
    TitleText = true,
    TotalWndSpace = { w = 68, h = (defaultLayout.Window.Size.h - 32) },
    Loc = { x = 5, y = 100 },
    -- 16x16,32x32,etc.
    BuffIconSize = 16
}
defaultLayout.Spellbar = {
    Enabled = true,
    GemGap = 12,
    Orientation = "Horizontal",
    Orientations = { Horizontal = {}, Vertical = {}, WndSpace = {}, Custom = {} },
    StartingLoc = { x = 12, y = (defaultLayout.Window.Size.h - 48 )},
    GemSize = 32,
    TotalWndSpace = { w = 156, h = 56 },
    WndSpaceStartLoc = { x = 128, y = 0 }

}

defaultLayout.Target = {
    Enabled = true,
    NameText = true,
    Loc = { x = (defaultLayout.Window.Size.w - 128), y = 5 },
    WndSpace = {w=128,h=16},
    Size = {w=128, h=16},
    Color = ImVec4(1,0,0,1),
    Buffs = {
        Enabled = true,
        Loc = { x = (defaultLayout.Window.Size.w - 128), y=48},
        WndSpace = {w=128, h=64},
        IconSize = 16
    }   
}
defaultLayout.Group = {
    Enabled = true,
    NameText = true,
    Loc = {x = (defaultLayout.Window.Size.w / 5),  y=12},
    WndSpace = { w=170, h=48},
    Color = ImVec4(1,0,0,1), 
    Size = {w=56,h=32}
}
defaultLayout.Hotbar = {
    Enabled = true,
    Loc = {x = (defaultLayout.Window.Size.w / 5), y = 78},
    WndSpace = {w=360, h=160},
    BtnSize = {w=32, h=32}
}

defaultLayout.Spellbar.Orientations.Horizontal = {}
defaultLayout.Spellbar.Orientations.Vertical = {}
for i=1, 12 do
    defaultLayout.Spellbar.Orientations.Horizontal[i] = {
        Enabled = true,
        Loc = {x = defaultLayout.Spellbar.StartingLoc.x + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * i), y = defaultLayout.Spellbar.StartingLoc.y}
    }
end
for i=1, 12 do
    defaultLayout.Spellbar.Orientations.Vertical[i] = {
        Enabled = true,
        Loc = {x = defaultLayout.Spellbar.StartingLoc.x, y = defaultLayout.Spellbar.StartingLoc.y + defaultLayout.Spellbar.GemGap  + (defaultLayout.Spellbar.GemSize * i) }
    }
end


return defaultLayout
