# AntiCheatConsole

**Purpose:**  
Developer console-style controller for overriding AntiCheat behavior in a Roblox environment.  
Supports overriding sword touch, logging hits, ignoring age checks, tracking pals, and a master disable-all switch. Includes a floating, scrollable debug console.
 (game specific)
---

## **Files**

- **AntiCheatConsole.lua** — main controller file. Returns a table with `:Init()` and settings API.  
- **loader.lua** — lightweight loader snippet for direct `loadstring` execution.

---

## **Installation / Usage**

1. Place the repository on GitHub (or any raw file host like Pastebin).  
2. In your executor / Roblox Studio, run:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/Polarisx1/AntiCheatConsole/main/loader.lua"))()
