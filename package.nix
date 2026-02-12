let
  translationsHashes = builtins.fromJSON (builtins.readFile ./translations.json);
in
{
  gnugrep,

  fetchurl,
  writeShellApplication,

  translation,
  ...
}:
assert translationsHashes ? ${translation};
writeShellApplication {
  name = translation;
  text = builtins.readFile ./bible.sh;
  meta.description = "Bible query for the ${translation} translation";
  runtimeInputs = [ gnugrep ];
  runtimeEnv = {
    BIBLE = fetchurl {
      url = "https://openbible.com/textfiles/${translation}.txt";
      sha256 = translationsHashes.${translation};
      name = "${translation}.txt";
    };
  };
}
