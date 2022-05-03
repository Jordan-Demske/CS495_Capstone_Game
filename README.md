# Simple Minigame Framework 1
This is the framwork for the first minigame to be included in our site for Pharmacist Robert Gold.
It will be one of a series of games relating to the reviews foind on the site, and will be used to help
promote the information in our site in a new and engaging way.

## API documentation

### .import
- A folder used by godot to store assets you add to the game (textures, sounds, et cetera).
Godot converts these in to formats that it uses internally at runtime. These converted files are stored here.
Additional .import files may appear in the project structure, and serve a similar purpose.

### addons
- A folder that contains plugins installed in to godot to provide additional functionality. For example, GUT (Godot Unit Testing)

### assets
- A folder where the raw assets for the game are stored, before editing in engine.

### Test
- A folder, containing a subfolder called Unit, containing the test scripts run by GUT in Godot. (Unit Testing)
This is the standard format for GUT, and additional test should be contained within.

### .gut_editor_config.json and .gut_editor_shortcuts.cfg
- GUT configuration files, that are used to run GUT in godot.

### asset_lib_icon
- The icon for GUT, loaded with the GUT pluggin

### shaders - used to set vfx overlay
- Chromatic_abberation
- drunk_shader

### Coin (PILL) - increase status and health when sober, decreases when "drunk"
#### Coin.tscn - The scene containing the nodes for the coin object in engine.
- Sprite
- CollisionShape2D
- VisibilityNotifier2D
#### Coin.gd - The script containing coins methods.
- _on_VisibilityNotifier2D_screen_exited() - checks to see if the coin has moved off screen, and deletes that instance of coin.

### Mob (Bad Items) - Set health and status to 2, sets status to "drunk"
#### Mob.tscn - The scene containing the nodes for the Mob object in engine.
- Sprite
- CollisionShape2D
- VisibilityNotifier2D
#### Mob.gd - The script containing mobs methods.
- _on_VisibilityNotifier2D_screen_exited() - checks to see if the coin has moved off screen, and deletes that instance of coin.

### HUD - GUI
#### HUD.tscn - The scene containing the nodes for the coin object in engine.
- ScoreLabel
- Message
- StartButton
- Directions (Button)
- MessageTimer
- StatusBar
   - Green (rectangle)
   - Marker (black rectangle)
- ColorRect (Shader)
- Bottle (Directions BG)
  - RichTextLabel
  - Back (Button)
#### HUD.gd - The script containing HUDs methods
- show_message(text) - displays 'text' in HUD's Message node, and "shows" the node. Starts the MessageTimer which removes the message after a few seconds.
- show_game_over() - calls show_message() with a game over message, on MessageTimer's timeout, resets the Message text to the starting menu text. "Shows" the StartButton and Directions button.
- update_score(score) - changes the ScoreLabel value to 'score'
- _on_MessageTimer_timeout() - "hides" Message.
- _on_StartButton_pressed() - "hides" StartButton and Directions button, emits "start_game" signal.
- set_to_position(mod) - takes an integer as a variable, and uses it to set the status bar marker rectangle on the x axis.
- move_marker(mod) - takes an integer as a variable, and uses it to shift the status bar marker rectangle on the x axis.
- _on_Directions_pressed() - shows the bottle node and its children
- _on_Back_pressed() - hides the bottle node and its children

### Main
#### Main.tscn - The scene containing the nodes for the Main object in engine.
- ColorRect
- Player
- SpawnTimer
- CoinTimer
- StartTimer
- DrunkTimer
- DeteriorationTimer
- PointTimer
- StartPosition
- SpawnLocation
- HUD
- Music
- DeathSound
#### Main.gd - The script containing Main's methods.
- _ready() - adds randomization to additional methods on initialization
- _process(_delta) - updates the shader value every frame of the game based on player status
- game_over() - updates HUD to show gameover, stops timers and music, plays death sound, removes every active coin and mob instance.
- player_hit() - sets player state to drunk based on current status, adjusts status marker.
- new_game() - sets score to 0, shows HUD start screen, starts startTimer and music, sets player start position.
- pill_grabbed() - moves status marker based on player status
- _on_StartTimer_timeout() - starts game timers
- _on_CoinTimer_timeout() - randomly spawns falling coin
- _on_SpawnTimer_timeout() - randomly spawns falling mob
- _spawn_child(child) - places the child node in the scene
- _on_PointTimer_timeout() - increase score by 1
- _on_DeteriorationTimer_timeout() - decrease health and status by 1

### Player
#### Player.tscn - The scene containing the nodes for the Player object in engine.
- Sprite
- CollisionShape2D
#### Player.gd - The script containing Players methods
- _ready() - "hides" player
- _process(delta) - runs the physics processes for the Player, and processes player control input for the player.
- _on_Player_body_entered(body) - if body is coin then remove coin and update status/health, if body is mob then update status and set drunk
- check_if_dead() - checks if player health is out of bounds, and ends game if true
- spawn(pos) - sets and "shows" player position in game

### TestRunner
#### TestRunner.tscn - This scene is part of the GUT plugin

### Third-Party Assets

`art/House In a Forest Loop.ogg` Copyright &copy; 2012
[HorrorPen](https://opengameart.org/users/horrorpen), [CC-BY 3.0:
Attribution](http://creativecommons.org/licenses/by/3.0/). Source:
https://opengameart.org/content/loop-house-in-a-forest

`Gamey game Sounds >> Sad Synth` (https://freesound.org/people/Fupicat/sounds/538150/) by Fupicat, liscened under [CC0 1.0] Creative Commons Universal

Font is "Xolonium". Copyright &copy; 2011-2016 Severin Meyer
<sev.ch@web.de>, with Reserved Font Name Xolonium, SIL open font license
version 1.1. Details are in `fonts/LICENSE.txt`.
