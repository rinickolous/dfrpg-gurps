# DFRPG/Dungeon Fantasy Extension for [GURPS-4e-FG-Ruleset](https://github.com/ronnke/GURPS-4e-FG-Ruleset)

This is a DFRPG/Dungeon Fantaasy conversion extension for [Ronnke's](https://github.com/ronnke) GURPS 4th Edition Fantasy Grounds ruleset.
The extension gets rid of parts of the ruleset unnecessary for a DFRPG game (e.g. [Tech Level](https://gurps.fandom.com/wiki/Tech_Level)), leaving room for things like a field to keep track of [Mana](https://gurps.fandom.com/wiki/Mana).

#Current List of Features

Character Sheet:
- Replaces "Tech Level" and "Cultural Familiarities" section with a "Mana Sources" section, allowing casters to keep track of various source of magical power.
- Redesigned "Traits" tab, separating the "Disadvantages" and "Quirks" sections, as this feels more appropriate in DFRPG.
- Removed reference to things like "Tech Level" and "Legality Class" as these do not come into play in DFRPG (by default).
- Removed the separation between Currency and the rest of the player Inventory. By default, currency is stored in a location, and has weight. This change is designed to reflect that.
- Added combat fields for Control Points/Control Maximum, referring to the points used in the alternative grappling system in [Fantastic Dungeon Grappling](https://www.drivethrurpg.com/product/298466/Fantastic-Dungeon-Grappling) 

NPC Sheet:
- Added a "Spells" tab, which works exactly as the "Abilities" tab.
- Added an "Inventory" tab, useful for looting NPCs.

#GCS Compatibility
As this ruleset makes significant changes to the character format, importing characters from GCS will cause some issues by default.
To fix this, the ruleset comes with Output Templates for GCS, which export the character sheet into a format more compatible with this extension.
