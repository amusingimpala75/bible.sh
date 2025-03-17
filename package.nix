let
  translationsHashes = builtins.fromJSON (builtins.readFile ./translations.json);
in
{
  fetchurl,
  makeWrapper,
  symlinkJoin,
  withTranslation,
  writeScriptBin,

  grepCommand ? "grep",
  ...
}:
assert translationsHashes ? ${withTranslation};
let
  name = withTranslation;
  script = (writeScriptBin name (builtins.readFile ./bible)).overrideAttrs(old: {
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
  inherit name;
  paths = [ script ];
  buildInputs = [ makeWrapper ];
  postBuild = "wrapProgram $out/bin/${name} --prefix PATH : $out/bin --set BIBLE ${file} --set GREP ${grepCommand}";
}
