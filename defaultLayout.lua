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
    GemGap = 2,
    Orientation = "Horizontal",
    Orientations = { Horizontal = {}, Vertical = {}, WndSpace = {}, Custom = {} },
    StartingLoc = { x = (defaultLayout.Window.Size.w / 4), y = (defaultLayout.Window.Size.h) - 30 },
    GemSize = 28,
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

defaultLayout.Spellbar.Orientations.Horizontal = {
    [1] = {
        Enabled = true,
        Loc = defaultLayout.Spellbar.StartingLoc
    },
    [2] = {
        Enabled = true,
        Loc = { x = (defaultLayout.Spellbar.StartingLoc.x + defaultLayout.Spellbar.GemGap + defaultLayout.Spellbar.GemSize), y = defaultLayout.Spellbar.StartingLoc.y }
    },
    [3] = {
        Enabled = true,
        Loc = { x = (defaultLayout.Spellbar.StartingLoc.x + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 2)), y = defaultLayout.Spellbar.StartingLoc.y }
    },
    [4] = {
        Enabled = true,
        Loc = { x = (defaultLayout.Spellbar.StartingLoc.x + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 3)), y = defaultLayout.Spellbar.StartingLoc.y }
    },
    [5] = {
        Enabled = true,
        Loc = { x = (defaultLayout.Spellbar.StartingLoc.x + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 4)), y = defaultLayout.Spellbar.StartingLoc.y }
    },
    [6] = {
        Enabled = true,
        Loc = { x = (defaultLayout.Spellbar.StartingLoc.x + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 5)), y = defaultLayout.Spellbar.StartingLoc.y }
    },
    [7] = {
        Enabled = true,
        Loc = { x = (defaultLayout.Spellbar.StartingLoc.x + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 6)), y = defaultLayout.Spellbar.StartingLoc.y }
    },
    [8] = {
        Enabled = true,
        Loc = { x = (defaultLayout.Spellbar.StartingLoc.x + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 7)), y = defaultLayout.Spellbar.StartingLoc.y }
    },
    [9] = {
        Enabled = true,
        Loc = { x = (defaultLayout.Spellbar.StartingLoc.x + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 8)), y = defaultLayout.Spellbar.StartingLoc.y }
    },
    [10] = {
        Enabled = true,
        Loc = { x = (defaultLayout.Spellbar.StartingLoc.x + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 9)), y = defaultLayout.Spellbar.StartingLoc.y }
    },
    [11] = {
        Enabled = true,
        Loc = { x = (defaultLayout.Spellbar.StartingLoc.x + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 10)), y = defaultLayout.Spellbar.StartingLoc.y }
    },
    [12] = {
        Enabled = true,
        Loc = { x = (defaultLayout.Spellbar.StartingLoc.x + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 11)), y = defaultLayout.Spellbar.StartingLoc.y }
    },
    [13] = {
        Enabled = true,
        Loc = { x = (defaultLayout.Spellbar.StartingLoc.x + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 12)), y = defaultLayout.Spellbar.StartingLoc.y }
    },
}
defaultLayout.Spellbar.Orientations.Vertical = {
    [1] = {
        Enabled = true,
        Loc = defaultLayout.Spellbar.StartingLoc
    },
    [2] = {
        Enabled = true,
        Loc = { x = defaultLayout.Spellbar.StartingLoc.x, y = (defaultLayout.Spellbar.StartingLoc.y + defaultLayout.Spellbar.GemGap + defaultLayout.Spellbar.GemSize) }
    },
    [3] = {
        Enabled = true,
        Loc = { x = defaultLayout.Spellbar.StartingLoc.x, y = (defaultLayout.Spellbar.StartingLoc.y + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 2)) }
    },
    [4] = {
        Enabled = true,
        Loc = { x = defaultLayout.Spellbar.StartingLoc.x, y = (defaultLayout.Spellbar.StartingLoc.y + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 3)) }
    },
    [5] = {
        Enabled = true,
        Loc = { x = defaultLayout.Spellbar.StartingLoc.x, y = (defaultLayout.Spellbar.StartingLoc.y + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 4)) }
    },
    [6] = {
        Enabled = true,
        Loc = { x = defaultLayout.Spellbar.StartingLoc.x, y = (defaultLayout.Spellbar.StartingLoc.y + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 5)) }
    },
    [7] = {
        Enabled = true,
        Loc = { x = defaultLayout.Spellbar.StartingLoc.x, y = (defaultLayout.Spellbar.StartingLoc.y + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 6)) }
    },
    [8] = {
        Enabled = true,
        Loc = { x = defaultLayout.Spellbar.StartingLoc.x, y = (defaultLayout.Spellbar.StartingLoc.y + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 7)) }
    },
    [9] = {
        Enabled = true,
        Loc = { x = defaultLayout.Spellbar.StartingLoc.x, y = (defaultLayout.Spellbar.StartingLoc.y + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 8)) }
    },
    [10] = {
        Enabled = true,
        Loc = { x = defaultLayout.Spellbar.StartingLoc.x, y = (defaultLayout.Spellbar.StartingLoc.y + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 9)) }
    },
    [11] = {
        Enabled = true,
        Loc = { x = defaultLayout.Spellbar.StartingLoc.x, y = (defaultLayout.Spellbar.StartingLoc.y + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 10)) }
    },
    [12] = {
        Enabled = true,
        Loc = { x = defaultLayout.Spellbar.StartingLoc.x, y = (defaultLayout.Spellbar.StartingLoc.y + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 11)) }
    },
    [13] = {
        Enabled = true,
        Loc = { x = defaultLayout.Spellbar.StartingLoc.x, y = (defaultLayout.Spellbar.StartingLoc.y + defaultLayout.Spellbar.GemGap + (defaultLayout.Spellbar.GemSize * 12)) }
    },
}
return defaultLayout
