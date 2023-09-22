# newsboat_video_downloader
I sure love the mix of newsboat+mpv+yt-dlp to watch videos from my favourite creators directly from my command line. But sometimes I want to download them beforehand and have them sorted into different folders. Here is the script to do exactly that.

## Installation
Clone this directory and put the bash script in a directory you've got in your `$PATH`.

## Configure
```bash
DATABASELOC="$XDG_DATA_HOME/newsboat/cache.db"
WEBSITEURLLIST="$XDG_CONFIG_HOME/newsboat/websitelist"
VIDEOFOLDER="$HOME/Videos"
```

### DATABASELOC
The location of your cache.db. The newsboat default is `~/.newsboat/cache.db`.

### WEBSITELISTURL
A file where you define from which websites you want to download the videos from. Put this file wherever you like.

#### Example
```
https://www.youtube.com
https://www.odysee.com
```

### VIDEOFOLDER
The directory where you want your Videos to be downloaded in. Default is: `~/Videos/`.

## Usage
Just execute the script and the videos will be downloaded in your configured directory and sorted after the creator of the video.

```
usage: newsboat_video_downloader [-h] [-a AUTHOR] [-m]

optional arguments:
  -h,                      show this help message and exit
  -a, AUTHOR               Download only the videos by a specific creator
  -m,                      Enabled the marking mode which will mark the videos as watched in newsboat
  -d,                      Enables the detox mode and will execute detox in the video directory after downloading
```
