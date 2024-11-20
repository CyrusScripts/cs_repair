#Repair Kit for QBCore

## Overview
This script allows players to use a repair kit (`repairitem`) to repair vehicles in their QBCore server.
Disclaimer I made this repairkit script for my own qbcore server and so i dont know if this will work with 
qb-inventory or any other inventory system but if your looking for a simple repairkit you've come to the right place.

## Features
- Integration with `ox_lib` for notifications and progress bar.
- Fully customizable repair functionality.

## Installation

1. Download the `cs_repair` folder and place it in your `resources` directory.
2. Add `start cs_repair` to your `server.cfg`.
3. Add the `repairitem` to your shared items (`shared/items.lua`):

```lua
['repairitem'] = {
    name = 'repairitem',
    label = 'Repair Kit',
    weight = 1000,
    type = 'item',
    image = 'repairkit.png',
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
    description = 'A repair kit to fix vehicles'
},