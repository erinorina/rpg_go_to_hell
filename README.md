# Go to hell tabletop rpg

Godot Engine v4.1.3.stable

## To Do:


### CORE DICE ROLL

- [ ] Fisher-Yates shuffle algorithm for dice roll in exploration/plain [Wiki](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle)


### CORE ROLL EVENTS

- [ ] 1 loose object/life... , trap
- [ ] 2 loose/win gold, thiefs encounter
- [x] 3 normal combats encounter
- [x] 4 Sage encounter experience gain
- [ ] 5 find object, buy/sell object
- [ ] 6 chose a path stay/change destination

### CORE SCENES

- [ ] Nomad Marchand Buy/sell, inventory
- [ ] Change the travel destination, explore a new zone or stay in the level

# Hight Level Code Overview

## singleton_monsters.gd
This allows dynamically spawning a monster plane prefab that fades in/out over time when shown/hidden through the monster_show function. The textures, meshes, materials etc are reused for different monsters.

- [x] A shader that can fade textures
- [x] Loading random textures
- [x] Creating a 3D plane mesh
- [x] Controlling fade animation each frame

## singleton.gd
manages player stats, Loads different game scenes, Shows/hides scenes to switch between them

- [x] defines a player_stats dictionary to store player stats like level, XP, health, attack etc
- [x] functions to reset player stats
- [x] loads different scene files (HUD, Menu, Combat level 1 etc.) and instantiates them as scene instances

## exploration/plain.gd
Uses scenes for explorable worlds, State machine for traveling/combat phases, Rolls for random distance and events, Loads appropriate content per level

- [x] fsm IDLE, ROLLING, ADVANCING, COMBAT
- [x] Switches worlds when player levels up
- [x] Advances travel on rolling
- [x] Enters combat on reaching destination
- [x] roll_events

## combat_level_1/fight.gd
Random monster generation, Attack dice rolling and outcome, Calculating and displaying stats, XP/leveling on victory, Scene transitions on win/loss

- [x] Generates random monster based on level
- [x] Compares and determines winner, Awards XP to player on win
- [x] Calculate random attack values within min-max ranges, Scales ranges based on player level
- [x] XP/leveling on victory
- [x] Scene transitions on win/loss
