Super Mario Console Adventure (x86 Assembly)
👤 A Maaz Hussain Production | 🎓 Roll No: 24i-0708
A fully functional, console-based platformer game developed entirely in x86 Assembly Language (MASM). This project demonstrates low-level programming concepts, direct memory management, and game physics without the use of high-level game engines.
________________________________________
🎮 Project Overview
This repository contains the source code for a recreation of the classic Super Mario mechanics. The game runs in the Windows Command Prompt and utilizes the Irvine32 library for standard I/O and Winmm.lib for asynchronous sound handling.
The project was built to explore the challenges of game loop architecture, collision detection, and rendering using raw byte manipulation in a 16-color console environment.
✨ Key Features & Happenings
•	Dynamic Level Loading: Maps are not hardcoded; the game reads .txt files (e.g., level1.txt) into a memory buffer, parsing characters to render terrain, enemies, and items dynamically.
•	Physics Engine: Custom-written gravity, jumping velocity, and friction logic. Includes implementation for Double Jump mechanics.
•	Collision Detection: Precise hitbox detection for:
o	Ground/Ceiling (Platforming).
o	Horizontal Obstacles (Walls).
o	Enemy Stomping vs. Player Damage.
o	Lava (Instant death and respawn).
•	Power-Up System: collecting items changes player state, allowing the destruction of specific blocks ('W' or 'B' types) and changing the player's color palette.
•	Boss Fight Logic: A programmed Boss battle (Level 3) featuring:
o	AI Radar: The boss tracks player position relative to itself.
o	Projectiles: Fires fireballs based on player proximity.
•	Audio System: Integration with Windows API (PlaySoundA) to handle background music loops and asynchronous sound effects (Jump, Coin, Game Over).
•	Persistent Leaderboard: Uses File I/O to read and write high scores to leaderboard.txt, sorting player rankings.
🛠️ Technical Concepts & Challenges
This project tackles several advanced Assembly concepts:
1. Direct Memory Addressing & Buffer Management
The game map is stored as a single byte array (mapBuffer). Rendering and collision detection rely on calculating offsets (Row * RowSize + Column) to access specific coordinates in memory instantly.
2. The Game Loop & State Management
The GameLoop label acts as the heart of the engine, managing a delicate balance of:
•	Rendering: Optimized character printing using Gotoxy to minimize flickering.
•	Input Handling: Polling keystrokes without pausing execution.
•	Logic Updates: Ticking timers for animations, power-ups, and enemy movement.
3. Procedure Abstraction
The code is modularized into procedures (e.g., UpdatePhysics, CheckForCoins, DrawMap, SaveScoreToFile) to maintain clean stack management and register preservation.
4. Custom Debugging Tools
Implementation of a "Ghost Mode" (triggered via 'G'), allowing the developer to bypass collision checks for testing level layouts.
🕹️ Controls
Key	Action
W	Jump / Double Jump
A	Move Left
D	Move Right
P	Pause Game
X	Return to Main Menu
G	Toggle Ghost Mode (Debug)
🚀 How to Run
1.	Prerequisites: Visual Studio with MASM installed and the Irvine32 library configured.
2.	Assets: Ensure all .wav sound files and .txt level files are in the same directory as the executable.
3.	Build: Assemble and Link the try2.asm file.
4.	Run: Execute the resulting .exe file.
📂 File Structure
•	try2.asm - The main source code containing game logic, data segments, and procedures.
•	levelX.txt - Text-based map blueprints parsed by the game.
•	*.wav - Audio assets for BGM and SFX.
•	leaderboard.txt - Stores persistent player data.
________________________________________
© 2025 Maaz Hussain. All Rights Reserved.
