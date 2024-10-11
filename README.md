# Jumping Game in 8086 Assembly Language

This repository contains a Jumping Game developed in 8086 assembly language as part of the university course **Computer Architecture and Assembly Language**. The project was collaboratively created with a colleague, showcasing the application of assembly language for video graphics and game mechanics.

## Project Overview

The Jumping Game is a console-based game where players navigate across tiles with different behaviors. The game utilizes the ES (Extra Segment) region of 8086 assembly language to render graphics and implement game logic. The player must jump across three types of tiles, each with unique characteristics.

### Game Features

- **Tile Types:**
- **Red Tiles:** Move at double speed, challenging the player to jump quickly.
- **Blue Tiles:** Move at normal speed, providing a stable platform.
- **Light Blue Tiles:** Equipped with a timer, these tiles explode after a few seconds, adding urgency to gameplay.

- **Score Calculator:** The game keeps track of the player's score based on successful jumps.

- **Interrupt Handling:** The game utilizes timer and keyboard interrupts for gameplay mechanics, including:
- **Pause Functionality:** Players can pause the game, which allows them to resume from the exact point of interruption.

## Technical Details

- **Programming Language:** 8086 Assembly Language
- **Environment:** Compatible with DOS and emulators supporting 8086 assembly.
- **Graphics Handling:** The game modifies the ES region to display video graphics.

## Getting Started

### Prerequisites

To run the game, you need:
- An 8086 emulator or DOSBox
- Assembly language development tools (e.g., MASM or TASM)

### Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/jumping-game-8086.git
cd jumping-game-8086
```

2. Assemble the code using your preferred assembler:
```bash
masm jumping_game.asm
```

3. Link the object file:
```bash
link jumping_game.obj
```

4. Run the executable in your 8086 emulator.

## How to Play

1. Start the game by running the executable.
2. Press Space to jump across tiles.
3. Monitor the score as you navigate.
4. Use the pause functionality as needed; the game will resume from the paused moment.


## Acknowledgments

- Developed as part of the Computer Architecture and Assembly Language course.
- Special thanks to my colleague for collaboration and support during the development of this project.

---

Feel free to adjust any sections or add more details specific to your project!
