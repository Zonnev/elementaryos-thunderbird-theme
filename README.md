# An elementary OS theme for Thunderbird
![Screenshot](Thunderbird_eOS_theme_with_beta.png)
## Installation

1. Install Thunderbird in AppCenter or type `sudo apt install thunderbird` in the Terminal.
2. Create the `chrome` folder in: `~/.var/app/org.mozilla.Thunderbird/.thunderbird/<profilefolder>` if you installed in the AppCenter.
3. Create the `chrome` folder in: `~/.thunderbird/<profilefolder>` if you installed in the Terminal.
4. Download the zip file and put the `userChrome.css` from `102x AppCenter` or `102x apt` folder in the `chrome` folder.
5. In Thunderbird enter the Menu and select Settings, scroll all the way down till you see the Config Editor button. Press the button and search for `toolkit.legacyUserProfileCustomizations.stylesheets` and set it to `true`.
6. Restart Thunderbird and the theme should be applied.
7. Disable the Title bar in Thunderbird.

## Work in progress

For now this theme only supports the default elementary OS window control layout and a manual install. I want the Thunderbird theme to support all window control layouts to be set in Pantheon Tweaks. When that work is done, we make an install script which automatically selects the window control layout in use and will make installing the Thunderbird theme much more easy.

- I have added a `userChrome.css` for **Thunderbird Beta** in the folder `Thunderbird Beta theme`.
- If you are using the new **Thunderbird Supernova stable releases (Thunderbird 115.x)** then use the `userChrome.css` in the `Thunderbird Supernova` folder.
