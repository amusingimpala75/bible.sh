# Bible.sh

Simple script to download/reference the Bible from the terminal. This tool is released under the MIT license.

## Usage:
The `TRANSLATION` environment variable can be used to control which translation is used. At the moment it is fairly limited, the most known one being KJV.
Options are:
- "asv"
- "akjv"
- "cpdv"
- "dbt"
- "drb"
- "erv"
- "jps"
- "kjv"
- "slt"
- "wbt"
- "web"
- "ylt"

If `TRANSLATION` is unset, the default is KJV. Regardless, no copy is downloaded/installed unless `bible download` is explicitly called.

The `BIBLE` environment variable is used to set where the bible is downloaded to or read from. The default is `~/.local/share/$TRANSLATION.txt`.

Subcommands are:
- download: Download the bible translation `$TRANSLATION`, and save it to `$BIBLE`.
- random: Fetch a random verse.
- named: This one takes an argument in the form of "Book Chapter:Verse" (such as "John 3:16"), and prints the corresponding verse.
