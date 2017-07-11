[![License](https://img.shields.io/github/license/MekDrop/custom-downloader.svg?maxAge=2592000)](License.txt) ![GitHub release](https://img.shields.io/github/release/MekDrop/custom-downloader.svg?maxAge=2592000)
# Custom Downloader

Simple bash scripts to download files from folder (torrent and http support by file extention).

# How to use it?

See [requirements](#requirements) first and make sure that you have everything. Modify variables in `downloader.sh`. Place all your torrents and links in files with .url extension in `waiting` folder. Run script. If everything goes good after some time you will see results.

## Folder structure

__&#128194; completed__ - here is a list with completed transfers<br />
__&#128194; processing__ - here is a list with processing transfers<br />
__&#128194; waiting__ - here is a list with waiting transfers (PLACE YOUR FILES HERE!)

# Requirements

* [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))
* [enhanced-ctorrent](http://www.rahul.net/dholmes/ctorrent/)
* [wget](https://www.gnu.org/software/wget/)
