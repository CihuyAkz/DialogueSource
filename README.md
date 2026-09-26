# SimpleDialogue NPC Generator v2

Single-file HTML dialogue builder for Roblox NPCs.

## What changed
- Red-to-black gradient UI with clearer sections and steps.
- One-script generation flow.
- `CihuyAkz/DialogueSource` is the hardcoded source reference.
- The uploaded `SimpleDialogue.rbxm` snapshot is embedded into the HTML as the offline baseline.
- Source-compatible helpers are inlined into the generated Luau: `CreateOption`, `CreateNode`, `CreateAutoNode`, `CreateCondition`, and `CreateTree`.
- Prompt highlighting, floating dialogue text, player response text, typing, branching, auto nodes, and distance cleanup are generated in the single Script.

## Use
Open `dialogue_generator.html` in a browser. Configure the NPC and nodes, then use **Generate 1 Script** or **Download .client.lua**.

## Roblox
Paste the generated Script directly inside the NPC Model and set **RunContext = Client**. The NPC needs a `Head`, `PrimaryPart`, or another `BasePart`.

Source reference: https://github.com/CihuyAkz/DialogueSource
