local defaultLayout =  {
    ['Window'] = {
        ['Size'] = { w = 512, h = 256 }
    },
    ['Stats'] = {
        Enabled = true,
        ['Name'] = {
            ['Enabled'] = true,
            ['Loc'] = {x=1,y=1},
            ['Color'] = ImVec4(1,1,1,1)
        },
        ['HP'] = {
            ['Enabled'] = true,
            ['Loc'] = { x = 0, y = 16 },
            ['Size'] = { w = 50, h = 16 },
            ['Color'] = ImVec4(1, 0, 0, 1)
        },
        ['Mana'] = {
            ['Enabled'] = true,
            ['Loc'] = { x = 0, y = 32 },
            ['Size'] = { w = 50, h = 16 },
            ['Color'] = ImVec4(0, 0, 1, 1)
        },
        ['Endurance'] = {
            ['Enabled'] = true,
            ['Loc'] = { x = 0, y = 32 },
            ['Size'] = { w = 50, h = 16 },
            ['Color'] = ImVec4(0, 0.5, 0.5, 1)
        },
    }
}

return defaultLayout