# Batman to Zabbix Converter

I was using Batman for a few days to track the battery life on my android phone. When i tried visualizing the information stored in those columns of text, it hit me: I already know something that is great at displaying stats: Zabbix. This will convert and send the data to your zabbix-server. If you like this script, let me know!

## Requirements

You need access to a server running [zabbix](http://www.zabbix.com/). If you do not have one (or are capable of setting one up), this script is not for you. Sorry 'bout that.

You'll also need [Batman](https://play.google.com/store/apps/details?id=com.voss.batman), which you can get from the play store.

## Setup

### Server-Side

Import the `zabbix_host_import.xml` on your zabbix server. This should generate a new host called "Your-Device" including some items and graphs. Rename it, if you like.

### Client-Side

Have the correct zabbix_sender binary for your platform nearby. It can be either on your path, or you can just place it directly into this project's directory. You can download the Zabbix Sender as part of the [Zabbix Agent](http://www.zabbix.com/download.php) or from your OS's package-manager.

Copy `zabbix_sender.conf.example` to `zabbix_sender.conf`. Alter its contents to point to your server and insert your hostname (if you changed it, see above).

## Usage

You have two possibilities to run the converter/importer:

a) Place `batman.csv` into the project's directory and run `batmanconvert.rb`  
b) Call `batmanconvert.rb` from a terminal and give it the csv's location as parameter like this: `batmanconvert.rb test/batman.01.csv` (in case you renamed it)

## License

This is not a huge script or anything out of the ordinary. If you must have a license: I'm triple-licensing it under the following licenses. Please pick the one that suits your needs.

* [GPLv3](http://www.gnu.org/copyleft/gpl.html)
* [MIT](http://opensource.org/licenses/MIT)
* [WTFPL](http://sam.zoy.org/wtfpl/)
