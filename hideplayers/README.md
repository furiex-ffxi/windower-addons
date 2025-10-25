# Hide Players Addon

This Windower addon allows you to selectively hide specific players from view. It's designed to reduce on-screen clutter and improve performance in crowded areas by preventing designated players from being rendered.

## Features

- **Selective Hiding**: Hides players based on a configurable "denylist".
- **Flicker-Free**: Uses efficient packet manipulation to prevent players from ever appearing on your screen, rather than hiding them after they've already rendered.
- **External Configuration**: Manage your denylist in a simple `settings.lua` file, keeping your main addon file clean.
- **Case-Insensitive**: Player names in the denylist are matched without regard to case.

## Installation

1.  Place `hideplayers.lua` into your `Windower/addons/` folder.
2.  Create a new folder named `data` inside the `Windower/addons/hideplayers/` folder.
3.  Create a new file named `settings.lua` inside the `Windower/addons/hideplayers/data/` folder.

Your final folder structure should look like this:
```
Windower/
└── addons/
    └── hideplayers/
        ├── hideplayers.lua
        ├── README.md
        └── data/
            └── settings.lua
```

## Configuration

To specify which players you want to hide, you must add their names to the `settings.lua` file. The addon expects this file to return a Lua table containing a `denylist`.

Open `c:\Program Files (x86)\Windower\addons\hideplayers\data\settings.lua` with a text editor and add the following content, modifying the names as needed.

### Example `settings.lua`
```lua
return {
    denylist = {
        'PlayerNameToHide1',
        'AnotherPlayer',
        'SomeRmtCharacter',
    }
}
```

## Usage

Simply load the addon in-game with the command: `//lua load hideplayers`.

The addon will automatically start hiding players who are on your denylist. To update the list, edit the `settings.lua` file and reload the addon with `//lua r hideplayers`.