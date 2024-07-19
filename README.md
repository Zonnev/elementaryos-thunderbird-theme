# An elementary OS theme for Thunderbird

![Screenshot](Thunderbird_eOS_supernova_theme.png)

## ⬇️ Installation

For now theme installation is supported for:

1. [🐦 Thunderbird](https://www.thunderbird.net/en-US/) installed with apt package manager.
   Install it with command `sudo apt install thunderbird`.
2. [🐦 Thunderbird 📦 Flatpak version](https://flathub.org/apps/details/org.mozilla.Thunderbird).
   Install it using AppCenter.

Use this one line install script to install theme. Just copy the line to your terminal and press enter:

```bash
bash <(wget --quiet --output-document - "https://raw.githubusercontent.com/Zonnev/elementaryos-thunderbird-theme/main/install.sh")
```

Or install theme manually:

1. Install Thunderbird in AppCenter or type `sudo apt install thunderbird` in the Terminal.
2. Create the `chrome` folder in: `~/.var/app/org.mozilla.Thunderbird/.thunderbird/<profilefolder>` if you installed in the AppCenter.
3. Create the `chrome` folder in: `~/.thunderbird/<profilefolder>` if you installed in the Terminal.
4. Download the zip file and put the `base.css` in the `chrome` folder.
5. Look which **window button layout** you are using and put the `userChrome.css` from the **corresponding folder** in the `chrome` folder.
6. In Thunderbird enter the Menu and select Settings, scroll all the way down till you see the Config Editor button. Press the button and search for `toolkit.legacyUserProfileCustomizations.stylesheets` and set it to `true`.
7. Restart Thunderbird and the theme should be applied.
