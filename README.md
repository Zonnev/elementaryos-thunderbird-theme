# An elementary OS theme for Thunderbird
![Screenshot](Thunderbird_eOS_supernova_theme.png)
## Installation

1. Install Thunderbird in AppCenter or type `sudo apt install thunderbird` in the Terminal.
2. Create the `chrome` folder in: `~/.var/app/org.mozilla.Thunderbird/.thunderbird/<profilefolder>` if you installed in the AppCenter.
3. Create the `chrome` folder in: `~/.thunderbird/<profilefolder>` if you installed in the Terminal.
4. Download the zip file and put the `base.css` in the `chrome` folder.
5. Look which **window button layout** you are using and put the `userChrome.css` from the **corresponding folder** in the `chrome` folder.
6. In Thunderbird enter the Menu and select Settings, scroll all the way down till you see the Config Editor button. Press the button and search for `toolkit.legacyUserProfileCustomizations.stylesheets` and set it to `true`.
7. Restart Thunderbird and the theme should be applied.

## Work in progress

For now this theme only supports a manual install. The Thunderbird theme supports all window control layouts set in Pantheon Tweaks. We want to make an install script which automatically selects the window control layout in use and will make installing the Thunderbird theme much more easy.

- I have added a `userChrome.css` for **Thunderbird Beta** in the folder `Thunderbird Beta theme`.
