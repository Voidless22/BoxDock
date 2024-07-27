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
        Size = { w = 50, h = 16 },
        Color = ImVec4(1, 0, 0, 1)
    },
    Mana = {
        Enabled = true,
        Loc = { x = 5, y = 64 },
        Size = { w = 50, h = 16 },
        Color = ImVec4(0, 0, 1, 1)
    },
    Endurance = {
        Enabled = true,
        Loc = { x = 5, y = 80 },
        Size = { w = 50, h = 16 },
        Color = ImVec4(0, 0.5, 0.5, 1)
    },
}
defaultLayout.Buffs = {
    Enabled = true,
    TotalWndSpace = {w=64, h=(defaultLayout.Window.Size.h - 32)},
    Loc = {x = (defaultLayout.Window.Size.w - 65), y= 0},
    -- 16x16,32x32,etc.
    BuffIconSize = 32
}
return defaultLayout
