# Sequential Purging 

This incredible macro ensures that you won't have to fret about forgetting to remove your purgeline from your bed. While the macro itself doesn't remove the purgeline automatically, it does provide a buffer, minimizing the chance of error by always accommodating the previous purgeline from the previous print.

## Modes
### Continuous
In continuous mode the purge line gets drawn every print in an order and when the purge_sections_amount is full it will start back at the first purge section.
### Limited
In Limited mode a purge line gets drawn every print and you dont have to worry about accidentally leaving the purgelines on the bed because the print will not start once the purge_sections_amount is full.

ps. chatGPT's description that i found fairly funny for limited mode:
```Now, in the limited mode, it's like having a strict bouncer at the door of a fancy club for filament purges! You don't have to stress about forgetting those purge lines on the bed because this bouncer won't let the party start until the purge_sections_amount is full. No sneak-ins allowed! It's like having a personal filament cleanup crew ensuring your print bed stays as tidy as a cat's freshly swept litter box.```

## Installation
1. Use `ssh` to open your printer's terminal, eg [Putty](https://www.putty.org/)
   ```bash
    cd
    
    git clone https://github.com/Department-of-Design/Kevins-Awesome-Macros.git
    
    ln -s ~/Kevins-Awesome-Macros/config printer_data/config/Kevins-Awesome-Macros

    cp ~/Kevins-Awesome-Macros/config/sequential_purge.cfg ~/printer_data/config//Kevins-Awesome-Macros/sequential_purge.cfg
    ```

2. Open your `moonraker.conf` file and add this configuration:
   ```yaml
   [update_manager Kevins-Awesome-Macros]
   type: git_repo
   channel: dev
   path: ~/Kevins-Awesome-Macros
   origin: https://github.com/Department-of-Design/Kevins-Awesome-Macros.git
   managed_services: klipper
   primary_branch: main
    ```
3. Open `sequential_purge.cfg` in the `Kevins-Awesome-Macros` folder.
Next got to the variables section in the `sequential_purge` macro. 
    ```yaml
    [gcode_macro sequential_purge]
    description: Makes sequential purges in case you forget to remove the purge your previous print did. Requires save_variables

    # Continuous: where the purge line gets drawn every print in an order and when the purge_sections_amount is full it will start back at the first purge section.
    # Limited: draws a purge line every print and you dont have to worry about accidentally leaving the purgelines on the bed because the print will not start once the purge_sections_amount is full.
    # !! for the Limited version you need CHECK_PURGES somewhere before the SEQUENTIAL_PURGE command in your PRINT_START macro. Preferably before your printer heats up so you don't waste the heating time. 
    # !! when the purge section is full you can use RESET_PURGES to clear the system and start at the first purge section on your next print.

    # set this to True if you want continuous, and to false if you want limited
    # default is True
    variable_continuous: True

    # the distance the ......
    ```
Here you can configure the settings for the macro. The most important setting is `variable_continuous`. With this you can select what [mode](https://github.com/Department-of-Design/Kevins-Awesome-Macros/tree/main/sequential_purging#modes) you want to use. For continuous you have to set `variable_continuous` to `True`.

> **Note:**
    If you choose continuous mode you can remove both the macro's CHECK_PURGES and RESET_PURGES because they are not needed

## Configuration
| Setting                           | Description                                                                                                                                                                                                     | Input                                    | Default |
|-----------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------|---------|
| `variable_continuous`             | Setting for setting the mode you want to use.                                                                                                                                                                   | `True` (continuous) <br>`False` (Limited) | `True`  |
| `variable_bedsize_purge_offset`   | The distance the purgeline is away from the bed in both X and Y. This will only (haven't tested this on any other printers) work on configurations where the 0,0 point is on the left bottom corner of the bed. | `0` to `100`                             | `10`    |
| `variable_purge_sections_amount`  | The amount of purge sections in the line.                                                                                                                                                                       | `0` to `20`                              | `5`     |
| `variable_purge_height`           | The distance from the bed for the purge line.                                                                                                                                                                   | Any bumber above `0`                     | `0.8`   |
| `variable_flow_rate`              | Flow rate for the purgeline, many put this as their hotend flow limit.                                                                                                                                          | Any bumber above `0`                     | `12`    |
| `variable_purge_amount`           | Amount of filament purged.                                                                                                                                                                                      | Any number above `0`                     | `30`      |
| `variable_tip_distance`           | The distance between the tip of the filament and the nozzle before purging, should be similar to the final retract amount specified in PRINT_END.                                                               | Any bumber above `0`                     | `10`      |
| `variable_purge_line_end_overlap` | Specifies the overlap of the purge line with the next purge line in percentage.                                                                                                                                 | Percentage from `0` to `100`             | `50`      |



## Macro's

This package contain's 3 macro's: `SEQUENTIAL_PURGE`, `CHECK_PURGES` and `RESET_PURGES`.

For [continuous](https://github.com/Department-of-Design/Kevins-Awesome-Macros/tree/main/sequential_purging#continuous) mode you only need `SEQUENTIAL_PURGE`. With the [limited](https://github.com/Department-of-Design/Kevins-Awesome-Macros/tree/main/sequential_purging#limited) mode you need all 3 the macro's. 

Here's how your `PRINT_START` would look for both of them.

#### Continuous
```yaml
Home printer
Heat printer
(more print start stuff)
SEQUENTIAL_PURGE
```
In the continuous mode you can just replace your purge with the SEQUENTIAL_PURGE command.
#### Limited
```yaml
CHECK_PURGES
Home printer
Heat printer
(more print start stuff)
SEQUENTIAL_PURGE
```
For the limited mode it's a little diffrent, here you check if the purge section is full before the print start's so you don't heat the printer up to find out there's still purges.

