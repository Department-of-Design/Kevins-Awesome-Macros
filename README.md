# Kevin's Awesome Macros

![image](https://repository-images.githubusercontent.com/777636883/d4b1e7d1-9515-496b-a353-a37fbd9885d5)

A collection of awesome macros for Klipper printers

> [!IMPORTANT]
> Please make sure to ${ \textsf{\color{red}read the documentation} }$ before installing these macros. The docs contain valuable information about installation, configuration, and optional features.

# How does one use the macro's? 

There's a file called KAM-settings.cfg. This file already includes all the settings for Sequential Purging. Sequential Purging is currently the only macro that we've made. But soon when more macro's come available you'll be able to add more variables in the file for setting up the other macro's. 

# All available macro's
## Sequential Purging Macro

![Sequential Purge4](https://github.com/user-attachments/assets/939f6509-9136-4ea3-83d8-b0293a6a49f5)

[![Documentation](https://github.com/Department-of-Design/Kevins-Awesome-Macros/assets/16231288/da62d421-d8e3-43b6-b535-5429b333bdab)](https://github.com/Department-of-Design/Kevins-Awesome-Macros/tree/main/sequential_purge)

This incredible macro ensures you shall worry no more! Avoid problems caused by purge lines from previous prints that haven't been removed from the bed.

While the macro itself doesn't (and can't) remove the purge line from your bed automatically, it does provide a mechanism by which the purge line is printed in avoidance of previous purges, remembering and avoiding the location of the purge lines in previous print jobs.

## Wait for bed edge temp

[![Documentation](https://github.com/Department-of-Design/Kevins-Awesome-Macros/assets/16231288/da62d421-d8e3-43b6-b535-5429b333bdab)](https://github.com/Department-of-Design/Kevins-Awesome-Macros/tree/main/wait_for_bed_edge)

This simple macro is for printers that have a temperature sensor at the edge of the bed to check whether the whole bed is heated. For example aluminum beds heat faster at the center and take some time to heat at the edges. 

This macro checks the size of the part your printing and if it crosses a certain border around the center of the bed it will wait for the edges to heat so you dont unnecessarily heat the whole bed for a small print.

# Quick install

To install the macro(s) you want, follow the steps below. This guide assumes you’re using a compatible terminal program like [Putty](https://www.putty.org/) to access your printer.

### Installation Steps:

1. **Update your system and install Git:**
   Open your terminal and run the following commands:

   ```bash
   sudo apt-get update && sudo apt-get install git -y
   ```

2. **Download the Macro Setup Script:**
   Navigate to your home directory and clone the installation repository:

   ```bash
   cd ~ && git clone https://github.com/Department-of-Design/Kevins-Awesome-Macros.git
   ```

3. **Run the Setup Script:**
   Execute the setup script to begin installation:

   ```bash
   ./Kevins-Awesome-Macros/KAM-setup.sh
   ```

4. **Follow the On-Screen Menu:**
   The script will present you with an installation menu. You can navigate this menu by entering the corresponding number for each option and pressing `Enter`.

   Example:
   ```bash
   ========================
   Choose an option: 1
   ```

5. **Monitor for Prompts:**
   During installation, you may be prompted for manual input. Make sure to follow any on-screen instructions and keep an eye on the terminal for updates.

6. **Edit Your `moonraker.conf` File: Add the following configuration to your `moonraker.conf` file:**
   ```yaml
   [update_manager Kevins-Awesome-Macros]
   type: git_repo
   channel: dev
   path: ~/Kevins-Awesome-Macros
   origin: https://github.com/Department-of-Design/Kevins-Awesome-Macros.git
   managed_services: klipper
   primary_branch: main
   ```

7. **Edit Your `printer.cfg` File: Add the following line to your `printer.cfg` file:**
   ```yaml
   [include KAM-settings.cfg]
   ```
   
8. **Continue to documentation**
    Continue to the documentation of the macro you're trying to install. This will also be in the output of the installation.
   
# Community

Got stuck with a macro? Unsure of what to do with an error?  
Or just curious where all the other nerds hang out?

Discord is the place-to-be! Home to the Department of Design and fans of KevinAkaSam's inventions alike.

[![Discord Invite](https://discordapp.com/api/guilds/964441223169449984/widget.png?style=banner3)](https://discord.gg/xqpKrxt9FC)
