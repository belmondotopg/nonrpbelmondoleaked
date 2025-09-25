radioConfig = {
    Controls = {
        Activator = { -- Open/Close Radio
            Name = "INPUT_REPLAY_START_STOP_RECORDING_SECONDARY", -- Control name
            Key = 289, -- F2
        },
        Secondary = {
            Name = "INPUT_SPRINT",
            Key = 21, -- Left Shift
            Enabled = true, -- Require secondary to be pressed to open radio with Activator
        },
        Toggle = { -- Toggle radio on/off
            Name = "INPUT_CONTEXT", -- Control name
            Key = 51, -- E
        },
        Increase = { -- Increase Frequency
            Name = "INPUT_CELLPHONE_RIGHT", -- Control name
            Key = 175, -- Right Arrow
            Pressed = false,
        },
        Decrease = { -- Decrease Frequency
            Name = "INPUT_CELLPHONE_LEFT", -- Control name
            Key = 174, -- Left Arrow
            Pressed = false,
        },
        Input = { -- Choose Frequency
            Name = "INPUT_FRONTEND_ACCEPT", -- Control name
            Key = 201, -- Enter
            Pressed = false,
        },
        Broadcast = {
            Name = "INPUT_CHARACTER_WHEEL", -- Control name
            Key = 19, -- Caps Lock
        },
        ToggleClicks = { -- Toggle radio click sounds
            Name = "INPUT_SELECT_WEAPON", -- Control name
            Key = 37, -- Tab
        }
    },
    Frequency = {
        Private = {},
        Current = 100, -- Don't touch
        CurrentIndex = 100, -- Don't touch
        Min = 1, -- Minimum frequency
        Max = 1000, -- Max number of frequencies
        List = {}, -- Frequency list, Don't touch
        Access = {}, -- List of freqencies a player has access to
    },
    Frequencyname = {
        {
            id = 1,
            name = "PD #1"
        },
        {
            id = 2,
            name = "Akcja #1"
        },
        {
            id = 3,
            name = "Akcja #2"
        },
        {
            id = 4,
            name = "Napad #1"
        },
        {
            id = 5,
            name = "Napad #2"
        },
    },
    RestrictedOffset = 0,
    RestrictedFrequencies = {
        ['police'] = { 1,2,3,4,5 },
    },
    AllowRadioWhenClosed = true -- Allows the radio to be used when not open (uses police radio animation) 
}
