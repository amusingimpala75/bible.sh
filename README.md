# Bible.sh

Simple script to download/reference the Bible from the terminal. This tool is released under the MIT license.

## Usage:
Nix users, see the `Nix` heading below.

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

### Nix:
The flake here declares packages for each of the above translations, so to try out one is `nix run github:amusingimpala75/bible.sh#asv` for the asv, for example.

To be used in another flake, apply the overlay provided at `overlays.default` and install the package `pkgs.bible.asv` if you would like the asv. The difference here is that the environment variables will NOT work as they are wrapped by nix, and as such the executable is the name of the translation to prevent collision in the case of multiples installations with differing translations.
