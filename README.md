# Website NPC

A FiveM resource that allows you to create interactive locations with either NPCs or markers that can open specified websites when players interact with them.

## Showcase
[Watch the showcase video](https://streamable.com/wwtpxb)

## Features

- Choose between NPC or marker for each location individually
- Customizable marker colors and scales
- Custom NPC models
- Customizable interaction labels
- Opens external websites when players interact
- Automatic NPC cleanup on resource stop
- ESX framework integration
- Performance optimized

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

Each location in `Config.NPCs` requires the following properties:

```lua
{
    coords = vector3(x, y, z),    -- Spawn coordinates
    heading = number,             -- Heading/rotation (for NPCs)
    model = "model_name",         -- NPC model name (when not using marker)
    website = "url",              -- Website URL to open
    label = "interaction_text",   -- Text shown when player is near
    useMarker = false            -- Set to true for marker, false for NPC
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
        label = "~r~[E]~w~ Open Website",
        useMarker = false -- Will spawn as NPC
    },
    {
        coords = vector3(127.1963, -1295.5615, 29.4198),
        heading = 222.4668,
        model = "a_m_y_business_0",
        website = "https://example.com",
        label = "~r~[E]~w~ Open Website",
        useMarker = true -- Will spawn as marker
    }
}
```

## Usage

1. Configure your locations in the config file
2. Each location can be either an NPC or a marker based on the useMarker setting
3. Approach an NPC/marker to see the interaction prompt
4. Press `E` to interact and open the configured website
5. Press `ESC` to close the NUI Focus 

## Controls

- `E` - Interact with NPC/marker
- `ESC` - Close website

## Technical Details

- Uses NUI for website handling
- Implements proper cleanup of NPCs on resource stop
- Includes server-side event handling for security
- Freezes NPCs in place and makes them invincible
- Optimized with proper model loading/unloading
- Smart sleep system for performance optimization
- Fixed orange marker style (type 21) for better visibility

## Modifications and Usage Terms

Modifications and improvements to this resource are welcome and encouraged. However, the resale or commercial redistribution of this resource or its derivatives is strictly prohibited.

- `E` - Interact with NPC/marker
- `ESC` - Close website

## Technical Details

- Uses NUI for website handling
- Implements proper cleanup of NPCs on resource stop
- Includes server-side event handling for security
- Freezes NPCs in place and makes them invincible
- Optimized with proper model loading/unloading
- Smart sleep system for performance optimization

## Modifications and Usage Terms

Modifications and improvements to this resource are welcome and encouraged. However, the resale or commercial redistribution of this resource or its derivatives is strictly prohibited.

## License

See LICENSE file for details.
