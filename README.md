# Website NPC

A FiveM resource that spawns configurable NPCs who can open specified websites when players interact with them.

## Features

- Spawn multiple NPCs at configurable locations
- Custom NPC models for each spawn point
- Customizable interaction labels
- Opens external websites when players interact with NPCs
- Automatic NPC cleanup on resource stop
- ESX framework integration

## Dependencies

- es_extended (ESX)

## Installation

1. Download the resource
2. Place it in your FiveM resources folder
3. Add the following to your `server.cfg`:
```cfg
ensure website_npc
```

## Configuration

All NPCs can be configured in `config.lua`. Each NPC entry requires the following properties:

```lua
{
    coords = vector3(x, y, z),    -- NPC spawn coordinates
    heading = number,             -- NPC heading/rotation
    model = "model_name",         -- NPC model name
    website = "url",              -- Website URL to open
    label = "interaction_text"    -- Text shown when player is near
}
```

### Example Configuration

```lua
Config.NPCs = {
    {
        coords = vector3(-1199.7023, -890.2485, 13.8862),
        heading = 303.2139,
        model = "a_m_y_business_02",
        website = "https://example.com",
        label = "~r~[E]~w~ Open Website"
    }
}
```

## Usage

1. NPCs will automatically spawn at their configured locations when the resource starts
2. Approach an NPC to see the interaction prompt
3. Press `E` to interact with the NPC and open their configured website
4. Press `ESC` to close the website

## Controls

- `E` - Interact with NPC
- `ESC` - Close website

## Technical Details

- Uses NUI for website handling
- Implements proper cleanup of NPCs on resource stop
- Includes server-side event handling for security
- Freezes NPCs in place and makes them invincible
- Optimized with proper model loading/unloading

## Modifications and Usage Terms

Modifications and improvements to this resource are welcome and encouraged. However, the resale or commercial redistribution of this resource or its derivatives is strictly prohibited.

## License

See LICENSE file for details.
