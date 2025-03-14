let
  translationsHashes = builtins.fromJSON (builtins.readFile ./translations.json);
in
{
  fetchurl,
  makeWrapper,
  symlinkJoin,
  withTranslation,
  writeScriptBin,
  ...
}:
assert translationsHashes ? ${withTranslation};
let
  name = "bible";
  script = (writeScriptBin name (builtins.readFile ./${name})).overrideAttrs(old: {
    buildCommand = "${old.buildCommand}\n patchShebangs $out";
  });
  path = "${withTranslation}.txt";
  file = fetchurl {
    url = "https://openbible.com/textfiles/${path}";
    sha256 = translationsHashes.${withTranslation};
    name = path;
  };
in
symlinkJoin {
  name = withTranslation;
  paths = [ script ];
  buildInputs = [ makeWrapper ];
  postBuild = "wrapProgram $out/bin/${name} --prefix PATH : $out/bin --set BIBLE ${file}";
}
