# newsboat_video_downloader
I sure love the mix of newsboat+mpv+youtube-dl to watch videos from my favourite creators directly from my command line. But sometimes I want to download them beforehand and have them sorted into different folders. Here is the script to do exactly that.

## Usage
Just execute the script and the videos will be downloaded a directory called "Youtube" in your current directory and sorted after the creator of the video.

```
usage: newsboat_video_downloader [-h] [-c CREATOR [CREATOR ...]] [-t]

optional arguments:
  -h, --help            show this help message and exit
  -c CREATOR [CREATOR ...], --creator CREATOR [CREATOR ...]
                        Download only the videos by a specific creator
  -t, --testing         Enables the testing mode: not setting items as read after downloading
```
