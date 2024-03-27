# STILL TESTING DO NOT USE

# Sequential Purging 

This incredible macro ensures that you won't have to fret about forgetting to remove your purge line from your bed. While the macro itself doesn't remove the purge line automatically, it does provide a buffer, minimizing the chance of error by always accommodating the previous purge line from the previous print.

<a href="https://discord.gg/xqpKrxt9FC">
         <img alt="Join" src="https://github.com/kevinakasam/BeltDrivenEnder3/blob/main/_ignore/Pictures/Discord-Logo%2BWordmark-Color.png"
         width=250" >
</a>

## Modes
### Continuous
In continuous mode the purge line gets drawn every print in an order and when the purge_sections_amount is full it will start back at the first purge section.
### Limited
In limited mode a purge line gets drawn every print and you dont have to worry about accidentally leaving the purge lines on the bed because the print will not start once the purge_sections_amount is full.

## Installation
1. Use `ssh` to open your printer's terminal, eg [Putty](https://www.putty.org/)
   ```bash
    cd
    
    git clone https://github.com/Department-of-Design/Kevins-Awesome-Macros.git

    ln -s ~/Kevins-Awesome-Macros/config printer_data/config/kevins_awesome_macros

    cp ~/Kevins-Awesome-Macros/config/KAM-Settings.cfg ~/printer_data/config/KAM-Settings.cfg
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
3. Add this to your printer.cfg.   
    ```yaml
    [include KAM-settings.cfg] 
    [include sequential_purge.cfg]
    ``` 
```mermaid
  graph TD;
      A-->B;
      A-->C;
      B-->D;
      C-->D;
```
4. Open `KAM-settings.cfg`.
Next go to the `Sequential Purging` section. 
    ```yaml
    [gcode_macro _KAM-settings]
    description: Settings for KAM macros

    #     _____                             _   _       _   _____                 _             
    #    / ____|                           | | (_)     | | |  __ \               (_)            
    #   | (___   ___  __ _ _   _  ___ _ __ | |_ _  __ _| | | |__) |   _ _ __ __ _ _ _ __   __ _ 
    #    \___ \ / _ \/ _` | | | |/ _ \ '_ \| __| |/ _` | | |  ___/ | | | '__/ _` | | '_ \ / _` |
    #    ____) |  __/ (_| | |_| |  __/ | | | |_| | (_| | | | |   | |_| | | | (_| | | | | | (_| |
    #   |_____/ \___|\__, |\__,_|\___|_| |_|\__|_|\__,_|_| |_|    \__,_|_|  \__, |_|_| |_|\__, |
    #                   | |                                                  __/ |         __/ |
    #                   |_|                                                 |___/         |___/ 

    # Continuous: where the purge line gets drawn every print in an order and when the purge_sections_amount is full it will start back at the first purge section.
    # Limited: draws a purge line every print and you dont have to worry about accidentally leaving the purgelines on the bed because the print will not start once the purge_sections_amount is full.
    # !! for the Limited mode you need CHECK_PURGES somewhere before the SEQUENTIAL_PURGE command in your PRINT_START macro. Preferably before your printer heats up so you don't waste the heating time. 
    # !! when the purge section is full you can use RESET_PURGES to clear the system and start at the first purge section on your next print.

    # set this to True if you want continuous, and to false if you want limited
    # default is True
    variable_continuous: True

    # this is only...
    ```

Here you can configure the settings for the macro. The most important setting is `variable_continuous`. With this you can select what [mode](https://github.com/Department-of-Design/Kevins-Awesome-Macros/tree/main/sequential_purge#modes) you want to use. For continuous you have to set `variable_continuous` to `True`.

## Configuration
| Setting                           | Description                                                                                                                                                                                                                                                                        | Input                                     | Default |
|-----------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------|---------|
| `variable_continuous`             | Setting for setting the mode you want to use.                                                                                                                                                                                                                                      | `True` (Continuous) <br>`False` (Limited) | `True`  |
| `variable_stop_print_on_warning`  | This is only needed on limited mode. This will stop the print if the purge section is full, if this is set to false it will echo a message to console instead of aborting the print.<br>This will also automatically reset the purges and continue printing. Use at your own risk. | `True`<br>`False`                         | `False` |
| `variable_warning_time`           | Time user has to remove purges                                                                                                                                                                                                                                                     | `0` to `3600`                             | `30`    |
| `variable_bedsize_purge_offset`   | The distance the purge line is away from the bed in both X and Y. This will only (haven't tested this on any other printers) work on configurations where the 0,0 point is on the left bottom corner of the bed.                                                                    | `0` to `100`                              | `10`    |
| `variable_purge_sections_amount`  | The amount of purge sections in the line.                                                                                                                                                                                                                                          | `0` to `20`                               | `5`     |
| `variable_purge_height`           | The distance from the bed for the purge line.                                                                                                                                                                                                                                      | Any number above `0`                      | `0.8`   |
| `variable_flow_rate`              | Flow rate for the purge line, many put this as their hotend flow limit.                                                                                                                                                                                                             | Any number above `0`                      | `12`    |
| `variable_purge_amount`           | Amount of filament purged.                                                                                                                                                                                                                                                         | Any number above `0`                      | `30`    |
| `variable_tip_distance`           | The distance between the tip of the filament and the nozzle before purging, should be similar to the final retract amount specified in PRINT_END.                                                                                                                                  | Any number above `0`                      | `10`    |
| `variable_purge_line_end_overlap` | Specifies the overlap of the purge line with the next purge line in percentage.                                                                                                                                                                                                    | Percentage from `0` to `100`              | `50`    |

## Macros in config

This package contain's 3 macros: `SEQUENTIAL_PURGE`, `CHECK_PURGES` and `RESET_PURGES`.

For [continuous](https://github.com/Department-of-Design/Kevins-Awesome-Macros/tree/main/sequential_purge#continuous) mode you only need `SEQUENTIAL_PURGE`. With the [limited](https://github.com/Department-of-Design/Kevins-Awesome-Macros/tree/main/sequential_purge#limited) mode you need all 3 the macros. 

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
For the limited mode it's a little different, here you check if the purge section is full before the print start's so you don't heat the printer up to find out there's still purges.

## Usage (only when using limited mode)
When your purge section is full and you try to start a print, you'll notice you can't. This is because your printer knows the purge section is full and you'll have to remove all the purge lines and use the `RESET_PURGES` command to let the printer know you've removed all purges. Now you can start a print again and be happily ever after. 

## Troubleshooting

<details>
    <summary>
        <b>
        I'm getting an error about save_variables!
        </b>
    </summary>
<p>
</p>
This happens because the macro already includes the `save_variable` section. To fix this remove the section in a place that is not sequential_purge.cfg. 
</details>

## Credits
Huge thanks to [Kyleisah](https://github.com/kyleisah) for the amazing work on KAMP and for the inspiration for this macro.