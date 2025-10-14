
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
| Template |     110 |       |
| bg       |  27/110 |   24% |
| ca_ES    |  31/110 |   28% |
| cs       |  18/110 |   16% |
| de       |  40/110 |   36% |
| en       |   0/110 |    0% |
|          | 110/110 |  100% |
| copy     | 110/110 |  100% |
| es-git   | 101/110 |   91% |
| es       | 110/110 |  100% |
| fr       |  27/110 |   24% |
| hu_HU    |  27/110 |   24% |
| it_IT    |  27/110 |   24% |
| lt       |  27/110 |   24% |
| nb       |  40/110 |   36% |
| nl       |  39/110 |   35% |
| pl       |  38/110 |   34% |
|          | 110/110 |  100% |
| copy     | 110/110 |  100% |
| pt_BR-git | 101/110 |   91% |
| pt_BR    | 110/110 |  100% |
|          | 110/110 |  100% |
| copy     | 110/110 |  100% |
| ru-git   | 101/110 |   91% |
| ru       | 101/110 |   91% |
| sv       |  39/110 |   35% |
| zh_CN    |  28/110 |   25% |
| zh_TW    |  27/110 |   24% |
