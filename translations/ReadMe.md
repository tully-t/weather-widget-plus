
## New Translations

- Fill out [`template.pot`](template.pot) with your translations then open a [new issue](https://github.com/tully-t/weather-widget-plus/issues/new), name the file `your-language-here.txt`, attach the txt file to the issue (drag and drop).

## If you can make a pull request:

- `git clone https://github.com/tully-t/weather-widget-plus`
- `cd weather-widget-plus/translations/po`
- Copy the `template.pot` file and name it your locale's code (Eg: `en`/`de`/`fr`) with the extension `.po`. Your region's locale code can be found at: https://stackoverflow.com/questions/3191664/list-of-all-locales-and-their-short-codes/28357857#28357857
- Fill out all the `msgstr ""` in your new .po file
- `sh ./build.sh` (Run the weather-widget-plus/translations/po/build.sh script)
- Submit your pull request with your changes

### Scripts

* `sh ./merge` will parse the `i18n()` calls in the `*.qml` files and write it to the `template.pot` file. Then it will merge any changes into the `*.po` language files.
* `sh ./build` will convert the `*.po` files to it's binary `*.mo` version and move it to `contents/locale/...` which will make it possible for the translations to be bundled in the `*.plasmoid` without needing the user to manually install them.

### Links

* https://develop.kde.org/docs/plasma/widget/translations-i18n/
* https://l10n.kde.org/stats/gui/trunk-kf5/team/fr/plasma-desktop/
* https://techbase.kde.org/Development/Tutorials/Localization/i18n_Build_Systems
* https://api.kde.org/frameworks/ki18n/html/prg_guide.html
* https://github.com/Zren/plasma-applet-lib

Version 8 of Zren's i18n scripts

|  Locale  |  Lines  | % Done|
|----------|---------|-------|
| Template |     106 |       |
| bg       |  28/106 |   26% |
| ca_ES    |  34/106 |   32% |
| cs       |  19/106 |   17% |
| de       |  45/106 |   42% |
| en       |   0/106 |    0% |
| es       | 106/106 |  100% |
| fr       |  28/106 |   26% |
| hu_HU    |  28/106 |   26% |
| it_IT    |  28/106 |   26% |
| lt       |  28/106 |   26% |
| nb       |  45/106 |   42% |
| nl       |  44/106 |   41% |
| pl       |  43/106 |   40% |
| pt_BR    | 106/106 |  100% |
| ru       |  45/106 |   42% |
| sv       |  44/106 |   41% |
| zh_CN    |  29/106 |   27% |
| zh_TW    |  28/106 |   26% |
