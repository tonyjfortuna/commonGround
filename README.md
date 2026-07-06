# 🌲 Common Ground

A Farming Simulator 25 map mod. You start with nothing but a pickup truck, a tent, and a chainsaw in a New Hampshire inspired forest. The goal is to build up from a bare camp into a full farm town, the kind you'd see fully built in the vanilla game.

▶️ [Watch the start with nothing gameplay video](https://www.youtube.com/watch?v=dSr3Ix5P7HM)

## 💡 Concept

Most farm sim maps drop you into an already built world. Common Ground strips that away. You start with a camp, a truck, a tent, and a chainsaw. Equipment and buildings are not available up front. An NPC vendor shows up over time and offers a limited set of products, and you unlock more by upgrading his shop. Progression is tied to earning access, not just earning money.

The map itself is being built section by section on a grid, starting from the center and expanding outward. The final layout is planned to include roads, a river, lakes, and Mount Washington in the background, aiming for a real New Hampshire feel rather than a generic map.

## ✅ What's built

- **Survival start.** Player spawns with a pickup truck and a tent near a campfire, no store access.
- **Chainsaw hand off.** `commonGroundStartingItems.lua` hooks into mission load, requests the starting chainsaw to load asynchronously through the game's hand tool loading system, and assigns it to the player once loading completes.
- **Store lockout.** `commonGroundStoreFilter.lua` patches the game's store manager (`addItem` and `loadItem`) so every item is hidden from the shop as soon as it's registered, with a continuous sweep in `update()` to catch anything added afterward. This is the mechanism behind the gated economy, nothing is buyable until the vendor system unlocks it.
- **Save via tent.** Player can save progress by interacting with the tent at camp.
- **Custom configuration layer.** Vehicles, placeables, items, store items, fields, field ground, farmlands, environment, and starting hand tools are all configured through edited XML to match the survival start design.
- **Center map section complete**, with the rest of the grid planned but not yet built out.

## 📋 Planned, not yet built

- Stone collection scattered across the map.
- Campfire construction, requiring a set number of stones plus wood, and player built rather than pre-placed.
- Fuel consumption on the campfire at a set rate, so it needs to be fed to stay lit.
- Remaining map sections beyond the center, including roads, river, lakes, and the Mount Washington backdrop.
- NPC vendor shop progression and unlock tiers.

## 🚧 Status

Paused mid development. The core loop (chainsaw, tent save, truck start, locked store) works. Development stalled while working through the campfire building and fuel system.

## ⚠️ Why this repo doesn't include the full mod

This repo contains only the code and configuration I wrote myself: the Lua scripts and the edited XML config files. It does not include the map terrain data, sound files, or any 3D models, including brand name equipment models (Stihl, Husqvarna, Jonsered, McCulloch), Giants Software's base map template, or a modified campfire model originally created by another modder. Those are not mine to redistribute. The gameplay video above shows the mod running with those assets in place.

## 🛠️ Tech

- **Lua** for runtime behavior (item loading, store manager patching, event hooks).
- **XML** for map, vehicle, placeable, field, and environment configuration.
- Built with Giants Editor for Farming Simulator 25.
