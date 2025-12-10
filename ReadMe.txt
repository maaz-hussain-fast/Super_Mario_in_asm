========================================================================
PROJECT TITLE: Super Mario Assembly Clone
AUTHOR:        Maaz Hussain
ROLL NUMBER:   24i-0708
COURSE:        Computer Organization and Assembly Language (COAL)
========================================================================

------------------------------------------------------------------------
[1] PROJECT DESCRIPTION
------------------------------------------------------------------------
This project is a 2D platformer game developed entirely in x86 Assembly 
Language (MASM) using the Irvine32 library. It recreates the classic 
Super Mario experience with custom physics, level progression, enemy AI, 
and a boss battle.

The game features two distinct levels, file handling for map loading and 
leaderboards, and a multimedia experience with background music and 
sound effects.

------------------------------------------------------------------------
[2] KEY FEATURES
------------------------------------------------------------------------
> GAMEPLAY MECHANICS:
  - Physics Engine: Custom gravity, velocity, and collision detection 
    (AABB) for ground, walls, and ceilings.
  - Double Jump: Player can perform mid-air jumps.
  - Health System: 3 Lives system with damage handling and respawning.
  - Score & Time: Real-time tracking of score, coins, and level timer.

> ADVANCED FEATURES:
  - Boss Battle: A custom AI Boss in Level 2 that tracks the player and 
    shoots fireballs.
  - Fireworks Animation: A procedural animation system that triggers 
    upon completing the game (saving the Princess).
  - Magnet Power-up: A special item that automatically collects coins 
    in a 3-block radius.
  - Ghost Mode: A debug/cheat feature allowing the player to phase 
    through walls and enemies (Toggle with 'G').

> FILE HANDLING:
  - Dynamic Map Loading: Levels are read from external text files 
    (.txt), allowing for easy level design changes.
  - Leaderboard: High scores are saved to and read from a permanent file.

> AUDIO & VISUALS:
  - ASCII Graphics: Colorful text-based rendering with different themes 
    for Level 1 (Day/Blue) and Level 2 (Night/Black).
  - Sound Effects: Integrated Windows API (winmm.lib) for background 
    music, jumping, coin collection, and explosions.

------------------------------------------------------------------------
[3] CONTROLS
------------------------------------------------------------------------
  W  : Jump / Double Jump
  A  : Move Left
  D  : Move Right
  P  : Pause Game
  X  : Return to Main Menu
  G  : Toggle Ghost Mode (Invincibility/No Clip)

------------------------------------------------------------------------
[4] HOW TO RUN
------------------------------------------------------------------------
1. Ensure Visual Studio is installed with the MASM/Irvine32 library setup.
2. Place the .asm file and ALL resource files in the project directory.
   
   REQUIRED RESOURCE FILES:
   - Level Maps: level1.txt, level1_part2.txt, level2.txt, level2_part2.txt
   - Sounds: mainmenu_bg.wav, lvl_1_bg.wav, coin.wav, jump.wav, 
     game_over.wav, pause.wav, victory.wav, explode.wav, explosion.wav

3. Build and Run the project in Visual Studio.
4. If sound does not play, ensure the .wav files are in the same folder 
   as the executable (.exe) or the source code.

------------------------------------------------------------------------
[5] LEVEL DESIGN
------------------------------------------------------------------------
- LEVEL 1: The standard platforming experience. Bright blue sky, basic 
  enemies, and platforming challenges.
  
- LEVEL 2: The "Dark Void." A harder difficulty setting with a black 
  background. This level culminates in a final boss fight. Defeating the 
  boss triggers the "Princess Saved" victory screen and fireworks show.

------------------------------------------------------------------------
[6] DATA STRUCTURES
------------------------------------------------------------------------
- The map is stored as a 1D Byte Array (ROW_SIZE * NUM_ROWS), simulating 
  a 2D grid.
- Math operations (div/mul) are used to convert (X,Y) coordinates into 
  memory array indices for collision detection.

========================================================================