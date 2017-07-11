[![License](https://img.shields.io/github/license/MekDrop/custom-downloader.svg?maxAge=2592000)](License.txt) ![GitHub release](https://img.shields.io/github/release/MekDrop/custom-downloader.svg?maxAge=2592000)
# Custom Downloader

Simple bash scripts to download files from folder (torrent and http support by file extention).

## How to use it?

See [requirements](#requirements) first and make sure that you have everything. Modify [variables](#variables-in-downloadersh) in `downloader.sh`. Place all your torrents and links in files with .url extension in `waiting` folder. Run script. If everything goes good after some time you will see results.

## Requirements

* [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))
* [enhanced-ctorrent](http://www.rahul.net/dholmes/ctorrent/)
* [wget](https://www.gnu.org/software/wget/)

## Folder structure

<dl>
  <dt>&#128194; &nbsp; completed</dt>
  <dd>Here is a list with completed transfers</dd>
  
   <dt>&#128194; &nbsp; processing</dt>
  <dd>Here is a list with processing transfers</dd>
  
   <dt>&#128194; &nbsp; waiting</dt>
  <dd>Here is a list with waiting transfers (PLACE YOUR FILES HERE!)</dd>
</dl>

## Variables in `downloader.sh`

<dl>
  <dt>apppath</dt>
  <dd>Application path where is `enhanced-ctorrent`</dd>
  
  <dt>ports</dt>
  <dd>Ports to use for downloads</dd>
  
  <dt>dpath</dt>
  <dd>Path where store downloaded files</dd>
  
  <dt>mailto</dt>
  <dd>Enter here email address to send you notification when download is completed.</dd>
  
  <dt>tmp</dt>
  <dd>Uncompleted downloads folder</dd>
  
  <dt>log</dt>
  <dd>Logs path</dd>
  
  <dt>pcount</dt>
  <dd>How many downloads can be run at same time?</dd>
</dl>
